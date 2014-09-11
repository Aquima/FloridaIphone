//
//  CategoryCell.h
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryCD;
@interface CategoryCell : UICollectionViewCell
@property(nonatomic,strong)IBOutlet UILabel*lblTitle;
@property(nonatomic,strong)CategoryCD*category;
-(void)loadWithCategoryCD:(CategoryCD*)categoryCD;
@end
