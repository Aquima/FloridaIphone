//
//  RecipeDetailTableViewCell.h
//  Florida
//
//  Created by Raul Quispe on 9/27/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecipeCD;
@interface RecipeDetailTableViewCell : UITableViewCell{
    __weak IBOutlet UIImageView*imgRecipe;
    __weak IBOutlet UIImageView*imgHasVideo;
    __weak IBOutlet UILabel*lblTitle;
    __weak IBOutlet UILabel*lblPortions;
    __weak IBOutlet UILabel*lblTimer;
    __weak IBOutlet UIView*puntationsView;
    __strong IBOutletCollection(UIButton) NSArray*btnRanking;
}
-(void)loadWithRecipe:(RecipeCD*)recipeCD;
@end
