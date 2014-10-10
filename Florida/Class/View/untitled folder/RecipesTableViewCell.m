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
{
    UIBezierPath *maskPath;
    CAShapeLayer *maskLayer;
}
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
    
    [lblPortions setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0f]];
    [lblPortions setTextColor:[UIColor colorWithHexString:@"333333"]];
    
    [lblTimer setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0f]];
    [lblTimer setTextColor:[UIColor colorWithHexString:@"333333"]];
    
    [lblTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:17.0f]];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"333333"]];

   // [lblPortions setFont:[UIFont fontWithName:@"Roboto Medium" size:11.f]];
   // [lblTimer setFont:[UIFont fontWithName:@"Roboto Medium" size:11.f]];
    recipe=recipeCD;
    [lblTitle setText:recipeCD.title];
    [self cornersRound:imgRecipe];
    [imgRecipe sd_setImageWithURL:[NSURL URLWithString:recipeCD.urlImage]];
    [lblTimer setText:[NSString stringWithFormat:@"%@ min",recipeCD.time]];
    [lblPortions setText:[NSString stringWithFormat:@"%@ porciones",recipeCD.portions]];
    lblTitle.numberOfLines = 0;
    [lblTitle setText:recipeCD.title];
    //[self.lblInfo setText:@"20% de descuento en tu entrada de martes a jueves."];
    // CGSize labelSize = [self.lblInfo.text sizeWithAttributes:@{NSFontAttributeName:self.lblInfo.font}];
    float ancho=lblTitle.text.length*9;
    int numberLines=ceilf(ancho/lblTitle.frame.size.width);
    
    switch (numberLines) {
        default:
            lblTitle.frame = CGRectMake(
                                              lblTitle.frame.origin.x, 16,
                                              lblTitle.frame.size.width, 18);
            lblTitle.numberOfLines = 1;
            puntationsView.frame=CGRectMake(puntationsView.frame.origin.x, 42, puntationsView.frame.size.width, puntationsView.frame.size.height);
            break;
        case 2:
            lblTitle.frame = CGRectMake(
                                              lblTitle.frame.origin.x, 16,
                                              lblTitle.frame.size.width, 45);
            lblTitle.numberOfLines = 2;
             puntationsView.frame=CGRectMake(puntationsView.frame.origin.x, 62, puntationsView.frame.size.width, puntationsView.frame.size.height);
            break;
        
    }
    //  [self.lblInfo setText:@"20% de descuento en tu entrada de martes a jueves."];
    [lblTitle setText:recipeCD.title];
    if ([recipeCD.hasVideo isEqualToString:@"0"]) {
        [imgHasVideo setHidden:YES];
    }else{
        [imgHasVideo setHidden:NO];
    }
    NSLog(@"%d",[recipeCD.ranking intValue]);
    int i=0;
    for (UIButton*btnStar in btnRanking) {
        
        if (i<[recipeCD.ranking intValue]) {
            [btnStar setImage:[UIImage imageNamed:@"stars"] forState:UIControlStateNormal];
        }else{
            //[btnStar setHidden:YES];
            [btnStar setImage:[UIImage imageNamed:@"starsOf"] forState:UIControlStateNormal];
        }

        i++;
    }

}
-(void)cornersRound:(UIView*)view{
    maskPath = [UIBezierPath bezierPathWithRoundedRect:view.layer.bounds byRoundingCorners:UIRectCornerTopRight| UIRectCornerTopLeft | UIRectCornerBottomLeft  | UIRectCornerBottomRight cornerRadii:CGSizeMake(30, 30)];
    maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;

    view.layer.mask = maskLayer;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = view.bounds;
    shape.path = maskPath.CGPath;
    shape.lineWidth = 3.0f;
    shape.strokeColor = [UIColor colorWithHexString:@"339933"].CGColor;
    shape.fillColor=[UIColor clearColor].CGColor;
    [view.layer addSublayer:shape];
    
    
}
@end
