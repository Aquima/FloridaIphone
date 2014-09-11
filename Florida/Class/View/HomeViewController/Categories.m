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

    [newCell loadWithCategoryCD:category];

    return newCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Protocol methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(155, 155);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell*categoryCellSelected = (CategoryCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate selectCategory:categoryCellSelected.category];
}

@end
