//
//  HomeViewController.m
//  Florida
//
//  Created by Raul Quispe on 9/10/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "HomeViewController.h"
#import "RecipeCD.h"
#import "CategoryCD.h"
#import "Categories.h"
#import "RecipesViewController.h"
#import "SearchView.h"
#import "MenuView.h"
@interface HomeViewController ()<categoriesDelegate,UITextFieldDelegate,SearchViewDelegate,MenuViewDelegate>{
    __weak IBOutlet Categories *viewCategories;
    __weak IBOutlet UITextField *itxtSearch;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *backgroundLogo;
    __weak IBOutlet UIView *preloadView;
    __weak IBOutlet UIView *superTopView;
    __strong IBOutletCollection(UILabel)NSArray*listLabels;
}

@end
@interface UIDevice (MyPrivateNameThatAppleWouldNeverUseGoesHere)
- (void) setOrientation:(UIInterfaceOrientation)orientation;
@end
@implementation HomeViewController{
    NSArray*recipesCDList;
}

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
    if (    (self.view.frame.size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height)))) {
        //portrait
    }else{
        //landscape
        [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
    }
    //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    
    [self shouldAutorotate];
    [self.view addSubview:[SearchView sharedInstance].menu];
    for (UILabel*label in listLabels) {
        [label setFont:[UIFont fontWithName:@"Roboto Medium" size:8.0f]];
        [label setTextColor:[UIColor colorWithHexString:@"666666"]];
    }
    [superTopView setBackgroundColor:[UIColor colorWithHexString:@"62bf40"]];
    [backgroundLogo setBackgroundColor:[UIColor colorWithHexString:@"007052"]];
    [topView setBackgroundColor:[UIColor colorWithHexString:@"42a221"]];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"edf5dd"]];
    [lblTitle setFont:[UIFont fontWithName:@"Lora-Regular" size:12.f]];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"FFFFFF"]];
  //  [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern"]]];
    [itxtSearch setDelegate:self];
    NSUserDefaults*infoUser=[NSUserDefaults standardUserDefaults];
 
    if ([infoUser objectForKey:@"syncComplete"]==nil) {
        [self performSelector:@selector(consult) withObject:nil afterDelay:1.5];
    }else{
        [self consult];
    }
    [UIViewController attemptRotationToDeviceOrientation];
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}
-(void)viewWillAppear:(BOOL)animated{
    //  [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
    if (    (self.view.frame.size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height)))) {
        //portrait
    }else{
        //landscape
        [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
    }
}


-(void)viewDidLayoutSubviews {
    NSLog(@"%@", (self.view.frame.size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height))) ? @"Portrait" : @"Landscape");
     [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)consult{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRecipes:) name:@"endRecipes" object:nil];
    [[OriginData sharedInstance] invokeAsyncSyncRecipes:@"endRecipes"];
}
-(void)endRecipes:(NSNotification*)notification{
    NSDictionary*dataRecipes=(NSDictionary*)notification.object;
    NSArray*categoryCDList = [dataRecipes objectForKey:@"CategoryList"];
    for (CategoryCD*category in categoryCDList) {
      //  CategoryCD*category=[data objectAtIndex:indexPath.row];
        NSLog(@"%@ %@",category.idCategory,category.nameCategory);
    }
    recipesCDList = [dataRecipes objectForKey:@"RecipeList"];
    [OriginData sharedInstance].listRecipesCD=recipesCDList;
    [viewCategories loadData:categoryCDList];
    [viewCategories setDelegate:self];
    [preloadView setHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - CategoriesDelegate
-(void)selectCategory:(id)category{
    CategoryCD*currentCategory=(CategoryCD*)category;
      NSPredicate *predicate = [NSPredicate predicateWithFormat:
     @"idCategory contains[cd] %@",currentCategory.idCategory];
     
     // commented out old starting point :)
     //[results addObjectsFromArray:[all filteredArrayUsingPredicate:predicate]];
     
     // create a descriptor
     // this assumes that the results are Key-Value-accessible
     NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"idCategory"
     ascending:YES];
     //
     NSArray *results = [[recipesCDList filteredArrayUsingPredicate:predicate]
     sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    RecipesViewController*viewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"recipesVC"];
    [viewController setTitleList:currentCategory.nameCategory];
    [viewController setRecipeList:results];
    [viewController setIsFavorite:NO];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchRecipes:textField.text];
    [textField setText:@""];
    [textField resignFirstResponder];
    return NO;
}
-(void)searchRecipes:(NSString*)param{
   
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"title contains[cd] %@",param];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"idCategory"
                                                                 ascending:YES];
    //
    NSArray *results = [[recipesCDList filteredArrayUsingPredicate:predicate]
                        sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    RecipesViewController*viewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"recipesVC"];
     [viewController setTitleList:[NSString stringWithFormat:@"Resultados de \'%@\'",param]];
    [viewController setRecipeList:results];
    [viewController setIsFavorite:NO];
    [self.navigationController pushViewController:viewController animated:YES];
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


-(IBAction)selectCategoryButton:(UIButton*)sender{
    NSString*idCategory=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"idCategory contains[cd] %@",idCategory];

    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"idCategory"
                                                                 ascending:YES];
    //
    NSArray *results = [[recipesCDList filteredArrayUsingPredicate:predicate]
                        sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    RecipesViewController*viewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"recipesVC"];
    //[viewController setTitleList:currentCategory.nameCategory];
    [viewController setRecipeList:results];
    [self.navigationController pushViewController:viewController animated:YES];
}
-(IBAction)showSearch:(id)sender{
    [[SearchView sharedInstance] show:YES];
    [[SearchView sharedInstance] setDelegate:self];
}
-(IBAction)showMenu:(id)sender{
    [self.view addSubview:[MenuView sharedInstance].menu];
    [[MenuView sharedInstance] show:YES];
    [[MenuView sharedInstance] setDelegate:self];
}
#pragma mark -SearchViewDelegate   
-(void)goSearch:(NSString *)param{
    [self searchRecipes:param];
}
#pragma mark - MenuViewDelegate
-(void)selectShowfavorite{
    [[MenuView sharedInstance] hide:YES];
    RecipesViewController*viewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"recipesVC"];
    
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
    
    [viewController setRecipeList:results];
    [viewController setIsFavorite:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)selectShowBuyList{
    [[MenuView sharedInstance] hide:YES];
    RecipesViewController*viewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"recipesVC"];
    
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
    
    [viewController setRecipeList:results];
   // [viewController setIsFavorite:YES];
    [self.navigationController pushViewController:viewController animated:YES];

}
-(void)selectShowRecipesPrepareted{
    [[MenuView sharedInstance] hide:YES];
}
-(void)selectendSesion{
    [[MenuView sharedInstance] hide:YES];
}

@end
