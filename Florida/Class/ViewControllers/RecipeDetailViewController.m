//
//  RecipeDetailViewController.m
//  Florida
//
//  Created by Raul Quispe on 9/12/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "RecipeCD.h"
#import "RecipeDetailTableViewCell.h"
#import "SeciontTableViewCell.h"
#import "IngredientsTableViewCell.h"
#import "PreparationsTableViewCell.h"
#import "MenuView.h"
#import "MenuTableViewCell.h"
#import "LocalData.h"
#import "RecipesViewController.h"
#import "NoteView.h"
#import "BuyListView.h"
#import "GreenButton.h"
#import "ShareView.h"
#import "MBProgressHUD.h"
#import "AlertFlorida.h"
#import "VideoViewController.h"
@import Social;
@interface RecipeDetailViewController ()<MenuTableViewCellDelegate,MenuViewDelegate,NoteViewDelegate,BuyListViewDelegate,ShareViewDelegate,RecipeDetailTableViewCellDelegate,AlertFloridaDelegate>
{
    
 
    __weak IBOutlet UITextView *txtIgredientsAndPreparation;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *superTopView;
    NSArray*ingredients;
    NSString*message;
    MBProgressHUD *progress;
    UIButton*btnCurrentFavorite;
    UILabel*lblCurrentFavorite;

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
    progress = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:progress];
    progress.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:[AlertFlorida sharedInstance].menu];
    [self.view addSubview:[BuyListView sharedInstance].menu];
    [self.view addSubview:[NoteView sharedInstance].menu];
    [[NoteView sharedInstance] setDelegate:self];
     [self.view addSubview:[[MenuView sharedInstance] menu]];
    NSLog(@"Recipe: %@",recipe);
    [[MenuView sharedInstance] setDelegate:self];
    [superTopView setBackgroundColor:[UIColor colorWithHexString:@"62bf40"]];
    [topView setBackgroundColor:[UIColor colorWithHexString:@"42a221"]];
      // Do any additional setup after loading the view.
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
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
   
}
-(IBAction)showMenu:(id)sender{
     [[MenuView sharedInstance] show:YES];
}
- (IBAction)goVideo:(id)sender {
    
}
- (IBAction)saveToFavorites:(id)sender {
}
- (IBAction)showListCompra:(id)sender {
}
- (IBAction)shareSocial:(id)sender {
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"title" message:@"mesage" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    //    [alert show];
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            ingredients=(NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:recipe.ingredients];
            NSLog(@"ingredient: %@",ingredients );

            return [ingredients count]+1;
            break;
        case 2:
            return 2;
            break;
        default:
            return 1;
            break;
    }
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier;
    UITableViewCell*cell;
    RecipeDetailTableViewCell*recipeDetail;
    SeciontTableViewCell*sectionCell;
    IngredientsTableViewCell*ingredientsCell;
    PreparationsTableViewCell*preparationCell;
    MenuTableViewCell*menuCell;
    switch (indexPath.section) {
        case 0:
            identifier = @"recipeDetailCell";
            recipeDetail=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:identifier];
            }
            [recipeDetail loadWithRecipe:recipe];
            [recipeDetail setDelegate:self];
            return recipeDetail;
            break;
        case 1:
            if (indexPath.row==0) {
                identifier = @"sectionCell";
                ingredients=(NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:recipe.ingredients];
                NSLog(@"ingredient: %@",ingredients );
                
                sectionCell=[tableView dequeueReusableCellWithIdentifier:identifier];
                if (sectionCell == nil) {
                    sectionCell = [[SeciontTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:identifier];
                }
                [sectionCell loadWithtitle:@"Ingredientes" withIcon:@"book"];
                return sectionCell;
            }else{
                identifier = @"ingredientsCell";
                ingredients=(NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:recipe.ingredients];
                NSLog(@"ingredient: %@",ingredients );
                
                ingredientsCell=[tableView dequeueReusableCellWithIdentifier:identifier];
                if (ingredientsCell == nil) {
                    ingredientsCell = [[IngredientsTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:identifier];
                }
                NSArray*values=(NSArray*)[ingredients objectAtIndex:indexPath.row-1];
                [ingredientsCell loadWithtitle:[values objectAtIndex:0] withIcon:@"pencil"];
                 return ingredientsCell;
            }
            
           
            break;
        case 2:
            if (indexPath.row==0) {
                identifier = @"sectionCell";
                ingredients=(NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:recipe.ingredients];
                NSLog(@"ingredient: %@",ingredients );
                
                sectionCell=[tableView dequeueReusableCellWithIdentifier:identifier];
                if (sectionCell == nil) {
                    sectionCell = [[SeciontTableViewCell alloc]
                                   initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:identifier];
                }
                [sectionCell loadWithtitle:@"Preparacion" withIcon:@"hand"];
                return sectionCell;
            }else{
                identifier = @"preparationCell";
                    
                preparationCell=[tableView dequeueReusableCellWithIdentifier:identifier];
                if (preparationCell == nil) {
                    preparationCell = [[PreparationsTableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:identifier];
                }
                [preparationCell loadWithtitle:recipe.preparation];
                return preparationCell;
            }

            
            break;
        default:
            identifier = @"menuCell";
            
            menuCell=[tableView dequeueReusableCellWithIdentifier:identifier];
            if (menuCell == nil) {
                menuCell = [[MenuTableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:identifier];
            }
            menuCell.delegate=self;
            [menuCell loadData:recipe];
            BOOL isBuyList = [[recipe isBuyList] boolValue];
            [menuCell isBuyList:isBuyList];
            return menuCell;
            break;
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}// Default is 1 if not implemented
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 278;
            break;
        case 1:
            if (indexPath.row==0) {
                return 42;
            }else{
               return 32;
            }
            break;
        case 2:
            if (indexPath.row==0) {
                return 42;
            }else{
                float ancho=recipe.preparation.length*9;
                int numberLines=ceilf(ancho/304);
                return (numberLines*9)+10;
            }
        
            break;
        default:
            return 42;
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  //  RecipesTableViewCell*curretnCell=(RecipesTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
  //  [self.delegate selectRecipe:curretnCell.recipe];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - MenuTableViewCellDelegate
-(void)addBuyList{
     [[BuyListView sharedInstance] setDelegate:self];
     [[BuyListView sharedInstance] show:YES];
     ingredients=(NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:recipe.ingredients];
    [[BuyListView sharedInstance] initWithData:ingredients];
    BOOL isBuyList = [[recipe isBuyList] boolValue];
    if (isBuyList==NO) {
        recipe.isBuyList=@1;
        [LocalData grabarCambiosDeObjeto:recipe];
    }
}
-(void)addFavorites:(id)sender withLabel:(id)label{
    BOOL isFavorite = [[recipe isFavorite] boolValue];
    if (isFavorite==NO) {
 
        btnCurrentFavorite=(UIButton*)sender;
        lblCurrentFavorite=(UILabel*)label;
        [self.view addSubview:[AlertFlorida sharedInstance].menu];
        [[AlertFlorida sharedInstance] show:YES];
        [[AlertFlorida sharedInstance] setDelegate:self];
        [[AlertFlorida sharedInstance] setMessageAlert:@"Se Agrego a Favoritos" withOk:YES];
    }else{
        btnCurrentFavorite=(UIButton*)sender;
           lblCurrentFavorite=(UILabel*)label;
         [self.view addSubview:[AlertFlorida sharedInstance].menu];
        [[AlertFlorida sharedInstance] show:YES];
        [[AlertFlorida sharedInstance] setDelegate:self];
        [[AlertFlorida sharedInstance] setMessageAlert:@"¿Estás seguro de eliminar de tu lista de favoritos?" withOk:NO];
        //@"¿Estás seguro de eliminar de tu lista de favoritos?"
    }
}

-(void)addNote{
    NSString*note=recipe.note;
    if (note==nil) {
        message = [NSString stringWithFormat: @"Escribe aquí tus notas para %@",recipe.title];
        [[NoteView sharedInstance] setText:message];
        [[NoteView sharedInstance] setMessage:message];
        [[NoteView sharedInstance] show:YES];
    }else{
        [[NoteView sharedInstance] setText:note];
        [[NoteView sharedInstance] show:YES];
    }
    
    
}
-(void)share{
    [self.view addSubview:[ShareView sharedInstance].menu];
    [[ShareView sharedInstance] setDelegate:self];
    [[ShareView sharedInstance] show:YES];
}
#pragma mark - MenuViewDelegate
-(void)selectShowfavorite{
     [[MenuView sharedInstance] hide:YES];
    [[MenuView sharedInstance] setDelegate:self];
    RecipesViewController*controller=[self.navigationController.viewControllers objectAtIndex:1];
    
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

    [controller setRecipeList:results];
    [controller setIsFavorite:YES];
    [self.navigationController popToViewController:controller animated:YES];
}
-(void)selectShowBuyList{
    [[MenuView sharedInstance] hide:YES];
    [[MenuView sharedInstance] setDelegate:self];
    RecipesViewController*controller=[self.navigationController.viewControllers objectAtIndex:1];
    
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
    
    [controller setRecipeList:results];
    [controller setIsBuyList:YES];
    [self.navigationController popToViewController:controller animated:YES];

}
-(void)selectShowRecipesPrepareted{
    [[MenuView sharedInstance] hide:YES];
    [[MenuView sharedInstance] setDelegate:self];
}
-(void)selectendSesion{
    [[MenuView sharedInstance] hide:YES];
    [[MenuView sharedInstance] setDelegate:self];
}
#pragma mark - NoteViewDelegate
-(void)selectNoteCancel{
     [[NoteView sharedInstance] hide:YES];
}
-(void)selectNoteAccept:(NSString*)newNote{
    
    if (![newNote isEqualToString:message]) {
        recipe.note=newNote;
        [LocalData grabarCambiosDeObjeto:recipe];
        [[NoteView sharedInstance] hide:YES];
    }else{
        
    }
    
}
#pragma mark - BuyListDelegate
-(void)selectBuyAccept:(NSArray*)newData{
    [[BuyListView sharedInstance] hide:YES];
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:newData];
    recipe.ingredients=arrayData;
    [LocalData grabarCambiosDeObjeto:recipe];

}
-(void)selectBuyCancel{
    [[BuyListView sharedInstance] hide:YES];
}
#pragma mark - ShareViewDelegate
-(void)selectTwitterWith:(NSString*)message{
    [progress show:YES];
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText:[NSString stringWithFormat:@"%@",recipe.url_share]];
    NSURL *url = [NSURL URLWithString:recipe.urlImage];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage*image=[[UIImage alloc] initWithData:imageData];
    [tweetSheet addImage:image];

    [self presentViewController:tweetSheet animated:YES completion:nil];
 [progress hide:YES];
}
-(void)selectFacebookWith:(NSString*)message{
     [progress show:YES];
    SLComposeViewController *facebookSheet = [SLComposeViewController
                                              composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [facebookSheet setInitialText:[NSString stringWithFormat:@"%@",recipe.url_share]];
    NSURL *url = [NSURL URLWithString:recipe.urlImage];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage*image=[[UIImage alloc] initWithData:imageData];
    [facebookSheet addImage:image];
    [self presentViewController:facebookSheet animated:YES completion:nil];
    [progress hide:YES];
}
#pragma mark- RecipeDetailTableViewCellDelegate
-(void)loadVideo{
  //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString: recipe.urlVideo]];
    VideoViewController*viewController =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"videoVC"];
    [viewController setUrlAddress:recipe.urlVideo];
    [self.navigationController pushViewController:viewController animated:YES];

}
#pragma mark - AlertViewDelegate
-(void)selectDelete{
    recipe.isFavorite=@0;
    [lblCurrentFavorite setText:@"Favorito"];
    [LocalData grabarCambiosDeObjeto:recipe];
    [btnCurrentFavorite setImage:[UIImage imageNamed:@"menu3"] forState:UIControlStateNormal];
     [[AlertFlorida sharedInstance] hide:YES];
}
-(void)selectCancel{
    [[AlertFlorida sharedInstance] hide:YES];
}
-(void)selectOk{
    recipe.isFavorite=@1;
    [LocalData grabarCambiosDeObjeto:recipe];
    [btnCurrentFavorite setImage:[UIImage imageNamed:@"menu2B"] forState:UIControlStateNormal];
    [[AlertFlorida sharedInstance] hide:YES];
    [lblCurrentFavorite setText:@"Quitar"];
}
@end
