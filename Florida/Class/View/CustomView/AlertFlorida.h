//
//  AlertFlorida.h
//  Florida
//
//  Created by Raul Quispe on 9/29/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AlertFloridaDelegate
-(void)selectDelete;
-(void)selectCancel;
-(void)selectOk;
@end
@interface AlertFlorida : UIView
@property(nonatomic,weak)id<AlertFloridaDelegate>delegate;
@property(nonatomic,strong) UIView*menu;
+(AlertFlorida *)sharedInstance;
-(void)hide:(BOOL)hide;
-(void)show:(BOOL)show;
-(void)setMessageAlert:(NSString*)messageString withOk:(BOOL)ok;
@end
