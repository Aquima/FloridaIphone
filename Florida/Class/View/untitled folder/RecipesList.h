//
//  RecipesList.h
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol recipeListDelegate
-(void)selectRecipe:(id)recipe;
-(void)showAlert;
@end
@interface RecipesList : UIView<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray*data;
    __weak IBOutlet UITableView*tblRecipes;
}
@property(nonatomic,weak)id<recipeListDelegate>delegate;
@property BOOL isFavorite;
-(void)initWithData:(NSArray*)recipes;
-(void)reloadData;
-(void)deleteFavorite;
@end
