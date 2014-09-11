//
//  Categories.h
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol categoriesDelegate
-(void)selectCategory:(id)category;
@end
@interface Categories : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak)id<categoriesDelegate>delegate;
@property(nonatomic,strong)IBOutlet UICollectionView*categoriesCV;
-(void)loadData:(NSArray*)categoriesData;
@end
