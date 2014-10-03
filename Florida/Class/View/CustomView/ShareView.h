//
//  ShareView.h
//  Florida
//
//  Created by Raul Quispe on 10/3/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareViewDelegate
-(void)selectTwitterWith:(NSString*)message;
-(void)selectFacebookWith:(NSString*)message;
@end
@interface ShareView : UIView
@property(nonatomic,weak)id<ShareViewDelegate>delegate;
@property(nonatomic,strong) UIView*menu;
@property(nonatomic,strong) NSString*shareMessage;
+(ShareView *)sharedInstance;
-(void)hide:(BOOL)hide;
-(void)show:(BOOL)show;
@end
