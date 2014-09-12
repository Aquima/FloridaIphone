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
@interface RecipesViewController ()<recipeListDelegate>
{
    RecipeCD*sendRecipe;
    __weak IBOutlet RecipesList *viewRecipesList;
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
    // Do any additional setup after loading the view.
    [viewRecipesList initWithData:recipeList];
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
}
@end
