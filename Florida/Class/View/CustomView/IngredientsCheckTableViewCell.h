//
//  IngredientsCheckTableViewCell.h
//  Florida
//
//  Created by Raul Quispe on 10/1/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IngredientsCheckTableViewCellDelegate
-(void)selectWithData:(int)newData withIndex:(NSIndexPath*)index;
@end
@interface IngredientsCheckTableViewCell : UITableViewCell
@property(nonatomic,weak)id<IngredientsCheckTableViewCellDelegate>delegate;
@property(nonatomic,weak)IBOutlet UIButton*btnCheck;
@property(nonatomic,weak)IBOutlet UILabel*lblTitle;
-(void)loadData:(NSIndexPath*)index;
@end
