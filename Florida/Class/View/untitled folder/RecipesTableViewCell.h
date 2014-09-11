//
//  RecipesTableViewCell.h
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecipeCD;
@interface RecipesTableViewCell : UITableViewCell{
    __weak IBOutlet UIImageView*imgRecipe;
    __weak IBOutlet UILabel*lblTitle;
    __strong IBOutletCollection(UIButton) NSArray*btnRenking;
    __weak RecipeCD*recipe;
}
@property(nonatomic,strong) RecipeCD*recipe;
-(void)loadWithRecipe:(RecipeCD*)recipe;
@end
