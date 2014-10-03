//
//  SearchView.h
//  Florida
//
//  Created by Raul Quispe on 10/2/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewDelegate
-(void)goSearch:(NSString*)param;

@end
@interface SearchView : UIView<UITextFieldDelegate>
@property(nonatomic,weak)id<SearchViewDelegate>delegate;
@property(nonatomic,strong) UIView*menu;
+(SearchView *)sharedInstance;
-(void)hide:(BOOL)hide;
-(void)show:(BOOL)show;
@end
