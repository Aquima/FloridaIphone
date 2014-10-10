//
//  RecipeDetailTableViewCell.h
//  Florida
//
//  Created by Raul Quispe on 9/27/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RecipeDetailTableViewCellDelegate
-(void)loadVideo;
@end
@class RecipeCD;
@interface RecipeDetailTableViewCell : UITableViewCell{
    __weak IBOutlet UIImageView*imgRecipe;
    __weak IBOutlet UIButton*btnHasVideo;
    __weak IBOutlet UILabel*lblTitle;
    __weak IBOutlet UILabel*lblPortions;
    __weak IBOutlet UILabel*lblTimer;
    __weak IBOutlet UIView*puntationsView;
    __strong IBOutletCollection(UIButton) NSArray*btnRanking;
}
@property(nonatomic,weak)id<RecipeDetailTableViewCellDelegate>delegate;
-(void)loadWithRecipe:(RecipeCD*)recipeCD;
-(IBAction)goVideo:(id)sender;
@end
