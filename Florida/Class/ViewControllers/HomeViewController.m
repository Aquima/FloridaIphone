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

@interface HomeViewController ()<categoriesDelegate,UITextFieldDelegate>{
    __weak IBOutlet Categories *viewCategories;
    __weak IBOutlet UITextField *itxtSearch;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIView *topView;
}

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
    [topView setBackgroundColor:[UIColor colorWithHexString:@"5c2a47"]];
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

    // Do any additional setup after loading the view.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)consult{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRecipes:) name:@"endRecipes" object:nil];
    [[OriginData sharedInstance] invokeAsyncSyncRecipes:@"endRecipes"];
}
-(void)endRecipes:(NSNotification*)notification{
    NSDictionary*dataRecipes=(NSDictionary*)notification.object;
    NSArray*categoryCDList = [dataRecipes objectForKey:@"CategoryList"];
    
    recipesCDList = [dataRecipes objectForKey:@"RecipeList"];
    [viewCategories loadData:categoryCDList];
    [viewCategories setDelegate:self];
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
     [viewController setTitleList:[NSString stringWithFormat:@"Resultados de \'%@\'",param]];
    [viewController setRecipeList:results];
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

@end
