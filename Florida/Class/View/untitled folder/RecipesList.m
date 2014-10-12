//
//  RecipesList.m
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "RecipesList.h"
#import "RecipeCD.h"
#import "RecipesTableViewCell.h"
#import "LocalData.h"
@implementation RecipesList{
    RecipeCD*currentRecipeCD;
    NSIndexPath *currentIndex;
    BOOL isFavorite;
}
@synthesize isFavorite;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)deleteBuyList{
    [data removeObjectAtIndex:currentIndex.row];
    [tblRecipes deleteRowsAtIndexPaths:@[currentIndex] withRowAnimation:UITableViewRowAnimationFade];
    currentRecipeCD.isBuyList=@0;
    NSMutableArray*ingredientesCompuesto=[[NSMutableArray alloc] init];
    NSArray*ingredientes=(NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData:currentRecipeCD.ingredients];
    for (NSArray*ingrediente in ingredientes) {

        NSArray*index=[[NSArray alloc] initWithObjects:[ingrediente objectAtIndex:0],@"0", nil];
        if (![[ingrediente objectAtIndex:0] isEqualToString:@""]) {
            [ingredientesCompuesto addObject:index];
        }
        
    }
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:ingredientesCompuesto];
    currentRecipeCD.ingredients=arrayData;
    [LocalData grabarCambiosDeObjeto:currentRecipeCD];
}
-(void)deleteFavorite{
    [data removeObjectAtIndex:currentIndex.row];
    [tblRecipes deleteRowsAtIndexPaths:@[currentIndex] withRowAnimation:UITableViewRowAnimationFade];
    currentRecipeCD.isFavorite=@0;
    [LocalData grabarCambiosDeObjeto:currentRecipeCD];
}
-(void)initWithData:(NSArray*)recipes{
    data=[[NSMutableArray alloc] initWithArray:recipes];
    tblRecipes.dataSource=self;
    tblRecipes.delegate=self;
    [tblRecipes reloadData];
}
-(void)reloadData{
    [tblRecipes reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"title" message:@"mesage" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    //    [alert show];
    return [data count];
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"recipeCell";
    RecipesTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RecipesTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:identifier];
    }
    
    [cell loadWithRecipe:(RecipeCD*)[data objectAtIndex:indexPath.row]];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}// Default is 1 if not implemented
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipesTableViewCell*curretnCell=(RecipesTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self.delegate selectRecipe:curretnCell.recipe];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        currentIndex=indexPath;
        currentRecipeCD=[data objectAtIndex:indexPath.row];
      /*  [[OriginData sharedInstance].arrayCurrentMyCart removeObjectAtIndex:indexPath.row];
        [products removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tabBar.viewBadge.lblTitle setText:[NSString stringWithFormat:@"%d",[[OriginData sharedInstance].arrayCurrentMyCart count]]];
        if ([products count]>0) {
            [imgMessage setHidden:YES];
        }else{
            [imgMessage setHidden:NO];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];*/
        [self.delegate showAlert];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // RecipesTableViewCell *cell =(RecipesTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    //[UIColor colorWithHexString:@"007dc3"];
    //[cell.viewDelete setBackgroundColor:[UIColor colorWithHexString:@"fe3a30"]];
  //--  [cell.viewDelete setBackgroundColor:[UIColor colorWithHexString:@"007dc3"]];
    //  [cell setBackgroundColor:[UIColor redColor]];
    // set frames for all content you have got for that cell
    
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleDelete;
    if (self.isFavorite==YES||self.isBuyList==YES) {
        return style;
    }else{
        return style=UITableViewCellEditingStyleNone;
    }
    
    
}
@end
