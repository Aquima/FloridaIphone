//
//  Categories.m
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "Categories.h"
#import "CategoryCell.h"
#import "CategoryCD.h"
@implementation Categories{
    NSArray*data;
}
@synthesize categoriesCV;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)loadData:(NSArray*)categoriesData{
    data=categoriesData;
    [categoriesCV setDelegate:self];
    [categoriesCV setDataSource:self];
    [categoriesCV reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    //_data is a class member variable that contains one array per section.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  [data count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryCell* newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"categoryCellView"
                                                                             forIndexPath:indexPath];
    CategoryCD*category=[data objectAtIndex:indexPath.row];
    NSLog(@"%@ %@",category.idCategory,category.nameCategory);
    [newCell loadWithCategoryCD:category];

    switch (indexPath.row) {
       
        case 0:
            [newCell.viewContent setBackgroundColor:[UIColor colorWithHexString:@"5c2a47"]];
            [newCell.viewDishs setBackgroundColor:[UIColor colorWithHexString:@"5c2a47"]];
            break;
        case 1:
            [newCell.viewContent setBackgroundColor:[UIColor colorWithHexString:@"3e70dd"]];
            [newCell.viewDishs setBackgroundColor:[UIColor colorWithHexString:@"3e70dd"]];
            break;
        case 2:
            [newCell.viewContent setBackgroundColor:[UIColor colorWithHexString:@"fecc66"]];
            [newCell.viewDishs setBackgroundColor:[UIColor colorWithHexString:@"fecc66"]];
            break;
        case 3:
            [newCell.viewContent setBackgroundColor:[UIColor colorWithHexString:@"a2d6b7"]];
            [newCell.viewDishs setBackgroundColor:[UIColor colorWithHexString:@"a2d6b7"]];
            break;
        case 4:
            [newCell.viewContent setBackgroundColor:[UIColor colorWithHexString:@"e089ae"]];
            [newCell.viewDishs setBackgroundColor:[UIColor colorWithHexString:@"e089ae"]];
            break;
            
    }

    return newCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(320, 300);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell*categoryCellSelected = (CategoryCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate selectCategory:categoryCellSelected.category];
}

@end
