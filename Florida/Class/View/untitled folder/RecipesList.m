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
@implementation RecipesList

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
-(void)initWithData:(NSArray*)recipes{
    data=recipes;
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
    return 110;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipesTableViewCell*curretnCell=(RecipesTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self.delegate selectRecipe:curretnCell.recipe];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
