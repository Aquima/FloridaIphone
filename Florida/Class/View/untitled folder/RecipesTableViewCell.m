//
//  RecipesTableViewCell.m
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "RecipesTableViewCell.h"
#import "RecipeCD.h"
#import "UIImageView+WebCache.h"
@implementation RecipesTableViewCell
@synthesize recipe;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadWithRecipe:(RecipeCD*)recipeCD{
    recipe=recipeCD;
    [lblTitle setText:recipeCD.title];
    [imgRecipe sd_setImageWithURL:[NSURL URLWithString:recipeCD.urlImage] placeholderImage:[UIImage imageNamed:@"PlaceHolder"]];
}
@end
