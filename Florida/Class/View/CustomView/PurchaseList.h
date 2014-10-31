//
//  PurchaseList.h
//  Florida
//
//  Created by Raul Quispe on 10/20/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PurchaseListDelegate
-(void)selectPurchaseAccept:(NSArray*)newData;
-(void)selectPurchaseCancel;
@end
@interface PurchaseList : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)id<PurchaseListDelegate>delegate;
@property(nonatomic,strong) UIView*menu;
@property(nonatomic,strong) NSString*message;
+(PurchaseList *)sharedInstance;
-(void)hide:(BOOL)hide;
-(void)show:(BOOL)show;
-(void)initWithData:(NSArray*)ingredients;
@end