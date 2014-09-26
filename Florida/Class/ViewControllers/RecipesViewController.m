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
@interface RecipesViewController ()<recipeListDelegate,UIGestureRecognizerDelegate>
{
    RecipeCD*sendRecipe;
    __weak IBOutlet RecipesList *viewRecipesList;
    __weak IBOutlet UILabel*lblTitle;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *superTopView;
     MBProgressHUD *progress;
}
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

- (void)viewDidLoad
{
    [super viewDidLoad];
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
@end
