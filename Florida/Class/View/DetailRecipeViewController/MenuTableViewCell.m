//
//  MenuTableViewCell.m
//  Florida
//
//  Created by Raul Quispe on 9/28/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "RecipeCD.h"
#import "GreenButton.h"
@implementation MenuTableViewCell
@synthesize btnFavorite,btnAddNote,btnBuyList,btnShare;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadData:(RecipeCD*)recipe{
    BOOL isFavorite = [[recipe isFavorite] boolValue];
    if (isFavorite==NO) {
        [(UIButton*)btnFavorite setImage:[UIImage imageNamed:@"menu3"] forState:UIControlStateNormal];
        [self.addFavorite setText:@"Favorite"];
    }else{
        [(UIButton*)btnFavorite setImage:[UIImage imageNamed:@"menu2B"] forState:UIControlStateNormal];
         [self.addFavorite setText:@"Quitar"];
    }
    [btnAddNote setColor:[UIColor colorWithHexString:@"007052"] forState:UIControlStateSelected];
    [btnAddNote setColor:[UIColor colorWithHexString:@"339933"] forState:UIControlStateNormal];
    
    [btnFavorite setColor:[UIColor colorWithHexString:@"007052"] forState:UIControlStateSelected];
    [btnFavorite setColor:[UIColor colorWithHexString:@"339933"] forState:UIControlStateNormal];
    
    [btnShare setColor:[UIColor colorWithHexString:@"007052"] forState:UIControlStateSelected];
    [btnShare setColor:[UIColor colorWithHexString:@"339933"] forState:UIControlStateNormal];
}
-(IBAction)addNote:(UIButton*)sender{
    [self.delegate addNote];
  
    
}
-(IBAction)addBuyList:(UIButton*)sender{
    [self.delegate addBuyList];
    [btnBuyList setColor:[UIColor colorWithHexString:@"339933"] forState:UIControlStateSelected];
    [btnBuyList setColor:[UIColor colorWithHexString:@"007052"] forState:UIControlStateNormal];
}
-(IBAction)addFavorites:(UIButton*)sender{
    [self.delegate addFavorites:sender withLabel:self.addFavorite];
}
-(IBAction)share:(UIButton*)sender{
    [self.delegate share];
}
-(void)isBuyList:(BOOL)isBuyList{

    if (isBuyList==YES) {
        [btnBuyList setColor:[UIColor colorWithHexString:@"339933"] forState:UIControlStateSelected];
        [btnBuyList setColor:[UIColor colorWithHexString:@"007052"] forState:UIControlStateNormal];
    }else{
        [btnBuyList setColor:[UIColor colorWithHexString:@"007052"] forState:UIControlStateSelected];
        [btnBuyList setColor:[UIColor colorWithHexString:@"339933"] forState:UIControlStateNormal];
    }
}
@end
