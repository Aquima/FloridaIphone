//
//  RecipesViewController.m
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "RecipesViewController.h"
#import "RecipesList.h"
#import "RecipeCD.h"
#import "RecipeDetailViewController.h"
#import "MBProgressHUD.h"
#import "AlertFlorida.h"
#import "MenuView.h"
@interface RecipesViewController ()<recipeListDelegate,UIGestureRecognizerDelegate,AlertFloridaDelegate,MenuViewDelegate>
{
    RecipeCD*sendRecipe;
    __weak IBOutlet RecipesList *viewRecipesList;
    __weak IBOutlet UILabel*lblTitle;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *superTopView;
     MBProgressHUD *progress;
}
@end
@interface UIDevice (MyPrivateNameThatAppleWouldNeverUseGoesHere)
- (void) setOrientation:(UIInterfaceOrientation)orientation;
@end
@implementation RecipesViewController
@synthesize recipeList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [[MenuView sharedInstance] setDelegate:self];
    [[AlertFlorida sharedInstance] setDelegate:self];
    progress = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:progress];
    progress.mode = MBProgressHUDModeIndeterminate;
    [superTopView setBackgroundColor:[UIColor colorWithHexString:@"62bf40"]];

    [topView setBackgroundColor:[UIColor colorWithHexString:@"42a221"]];
    // Do any additional setup after loading the view.
    [lblTitle setText:self.titleList];
    [viewRecipesList initWithData:recipeList];
    [viewRecipesList setDelegate:self];
 
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated{
  //  [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
    if (    (self.view.frame.size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height)))) {
        //portrait
    }else{
        //landscape
        [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
    }

    if (self.isFavorite==YES) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"isFavorite == %d",1];
        
        // commented out old starting point :)
        //[results addObjectsFromArray:[all filteredArrayUsingPredicate:predicate]];
        
        // create a descriptor
        // this assumes that the results are Key-Value-accessible
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"idCategory"
                                                                     ascending:YES];
        //
        NSArray *results = [[[OriginData sharedInstance].listRecipesCD filteredArrayUsingPredicate:predicate]
                            sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
        
        recipeList=results;
        [viewRecipesList initWithData:recipeList];
        [viewRecipesList setIsFavorite:YES];
        [viewRecipesList reloadData];
    }else if(self.isBuyList==YES){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"isBuyList == %d",1];
        
        // commented out old starting point :)
        //[results addObjectsFromArray:[all filteredArrayUsingPredicate:predicate]];
        
        // create a descriptor
        // this assumes that the results are Key-Value-accessible
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"idCategory"
                                                                     ascending:YES];
        //
        NSArray *results = [[[OriginData sharedInstance].listRecipesCD filteredArrayUsingPredicate:predicate]
                            sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
        
        recipeList=results;
        [viewRecipesList initWithData:recipeList];
        [viewRecipesList setIsFavorite:YES];
        [viewRecipesList reloadData];
       
    }else{
        [viewRecipesList initWithData:recipeList];
        [viewRecipesList setIsFavorite:NO];
        [viewRecipesList reloadData];
    }
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)showMenu:(id)sender{
    [self.view addSubview:[MenuView sharedInstance].menu];
     [[MenuView sharedInstance] setDelegate:self];
    [[MenuView sharedInstance] show:YES];
}
#pragma mark - RecipesDelegate
-(void)selectRecipe:(id)recipe{
    sendRecipe=recipe;
    BOOL syncComplete = [[sendRecipe syncComplete] boolValue];
    if (syncComplete==NO) {
        [progress show:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endDetail:) name:@"endDetail" object:nil];
        [[OriginData sharedInstance] invokeAsyncSyncDetailRecipe:@"endDetail" withIdRecipe:sendRecipe.idRecipe withRecipe:sendRecipe];
       // [[OriginData sharedInstance] invokeAsyncSyncDetailRecipe:@"endDetail" withIdRecipe:sendRecipe.idRecipe se];
    }else{
        RecipeDetailViewController*viewController =
        [[UIStoryboard storyboardWithName:@"Main"
                                   bundle:NULL] instantiateViewControllerWithIdentifier:@"recipeDetailVC"];
        [viewController setRecipe:sendRecipe];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
-(void)endDetail:(NSNotification*)notification{
    [viewRecipesList reloadData];
    sendRecipe=(RecipeCD*)notification.object;
     [progress hide:YES];
    RecipeDetailViewController*viewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"recipeDetailVC"];
    [viewController setRecipe:sendRecipe];
    [self.navigationController pushViewController:viewController animated:YES];

   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notification.name object:nil];
}
-(void)showAlert{
    [self.view addSubview:[AlertFlorida sharedInstance].menu];
  
    [[AlertFlorida sharedInstance] show:YES];
     [[AlertFlorida sharedInstance] setMessageAlert:@"¿Estás seguro de eliminar de tu lista de favoritos?" withOk:NO];
      [[AlertFlorida sharedInstance] setDelegate:self];
}
#pragma mark - AlertFlorida
-(void)selectCancel{
    [[AlertFlorida sharedInstance] hide:YES];
    
    
}
-(void)selectDelete{
    [[AlertFlorida sharedInstance] hide:YES];
    if (self.isFavorite==YES) {
        [viewRecipesList deleteFavorite];
    }else if(self.isBuyList==YES){
        [viewRecipesList deleteBuyList];
    }
    
}
-(void)selectOk{
    [[AlertFlorida sharedInstance] hide:YES];
}
#pragma mark - MenuViewDelegate
-(void)selectShowfavorite{
     [[MenuView sharedInstance] hide:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"isFavorite == %d",1];
    
    // commented out old starting point :)
    //[results addObjectsFromArray:[all filteredArrayUsingPredicate:predicate]];
    
    // create a descriptor
    // this assumes that the results are Key-Value-accessible
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"idCategory"
                                                                 ascending:YES];
    //
    NSArray *results = [[[OriginData sharedInstance].listRecipesCD filteredArrayUsingPredicate:predicate]
                        sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    
    recipeList=results;
    [viewRecipesList initWithData:recipeList];
    [viewRecipesList setIsFavorite:YES];
    [viewRecipesList reloadData];
}
-(void)selectShowBuyList{
    [[MenuView sharedInstance] hide:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"isBuyList == %d",1];
    
    // commented out old starting point :)
    //[results addObjectsFromArray:[all filteredArrayUsingPredicate:predicate]];
    
    // create a descriptor
    // this assumes that the results are Key-Value-accessible
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"idCategory"
                                                                 ascending:YES];
    //
    NSArray *results = [[[OriginData sharedInstance].listRecipesCD filteredArrayUsingPredicate:predicate]
                        sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    
    recipeList=results;
    [viewRecipesList initWithData:recipeList];
    //[viewRecipesList setIsFavorite:YES];
    [viewRecipesList reloadData];

}
-(void)selectShowRecipesPrepareted{
    [[MenuView sharedInstance] hide:YES];
}
-(void)selectendSesion{
    [[MenuView sharedInstance] hide:YES];
}

@end
