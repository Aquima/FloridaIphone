//
//  MenuTableViewCell.h
//  Florida
//
//  Created by Raul Quispe on 9/28/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecipeCD;
@class GreenButton;
@protocol MenuTableViewCellDelegate
-(void)addNote;
-(void)addBuyList;
-(void)addFavorites:(id)sender;
-(void)share;
@end
@interface MenuTableViewCell : UITableViewCell
@property(nonatomic,weak)id<MenuTableViewCellDelegate>delegate;
@property(nonatomic,weak)IBOutlet GreenButton*btnFavorite;
@property(nonatomic,weak)IBOutlet GreenButton*btnAddNote;
@property(nonatomic,weak)IBOutlet GreenButton*btnBuyList;
@property(nonatomic,weak)IBOutlet GreenButton*btnShare;
-(void)loadData:(RecipeCD*)recipe;
-(void)isBuyList:(BOOL)isBuyList;
@end
