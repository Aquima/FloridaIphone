//
//  BuyListView.h
//  Florida
//
//  Created by Raul Quispe on 10/1/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BuyListViewDelegate
-(void)selectBuyAccept:(NSArray*)newData;
-(void)selectBuyCancel;
@end
@interface BuyListView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)id<BuyListViewDelegate>delegate;
@property(nonatomic,strong) UIView*menu;
@property(nonatomic,strong) NSString*message;
+(BuyListView *)sharedInstance;
-(void)hide:(BOOL)hide;
-(void)show:(BOOL)show;
-(void)initWithData:(NSArray*)ingredients;
@end