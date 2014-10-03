//
//  MenuView.h
//  Florida
//
//  Created by Raul Quispe on 9/28/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MenuViewDelegate
-(void)selectShowfavorite;
-(void)selectShowBuyList;
-(void)selectShowRecipesPrepareted;
-(void)selectendSesion;

@end
@interface MenuView : UIView
@property(nonatomic,weak)id<MenuViewDelegate>delegate;
@property(nonatomic,strong) UIView*menu;
+(MenuView *)sharedInstance;
-(void)hide:(BOOL)hide;
-(void)show:(BOOL)show;
@end
