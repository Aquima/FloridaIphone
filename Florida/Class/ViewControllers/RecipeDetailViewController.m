//
//  RecipeDetailViewController.m
//  Florida
//
//  Created by Raul Quispe on 9/12/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "RecipeCD.h"
@interface RecipeDetailViewController ()
{
    
 
    __weak IBOutlet UITextView *txtIgredientsAndPreparation;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *superTopView;                                                              
}
@end

@implementation RecipeDetailViewController
@synthesize recipe;
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
    NSLog(@"Recipe: %@",recipe);

    // Do any additional setup after loading the view.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
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
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)goVideo:(id)sender {
    
}
- (IBAction)saveToFavorites:(id)sender {
}
- (IBAction)showListCompra:(id)sender {
}
- (IBAction)shareSocial:(id)sender {
}

@end
