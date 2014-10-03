//
//  ShareView.m
//  Florida
//
//  Created by Raul Quispe on 10/3/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView{
    
    
}
@synthesize menu;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
+(ShareView *)sharedInstance {
    static dispatch_once_t pred;
    static ShareView *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[ShareView alloc] init];
    });
    return shared;
}
-(id)init
{
    UIButton*shadow=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [shadow setBackgroundColor:[UIColor colorWithHexString:@"000000"]];
    shadow.alpha=0.6;
    shadow.tag=4;
    [shadow addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    menu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    
    [menu setHidden:YES];
    UIView*contentOptions=[[UIView alloc] initWithFrame:CGRectMake(25, 213, 270, 54)];
    [contentOptions setBackgroundColor:[UIColor whiteColor]];
    UIImageView*topBarGold = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 4)] ;
    [topBarGold setImage:[UIImage imageNamed:@"linea_degradado"]];
    [contentOptions addSubview:topBarGold];
    for (int i=0; i<2; i++) {
        UIButton*btnAction=[[UIButton alloc] init];//:CGRectMake(0,10, 35, 35)];
        [btnAction setTag:i];
        if (i==0) {
            btnAction.frame=CGRectMake(0,4, 135, 50);
            [btnAction setImage:[UIImage imageNamed:@"twitter_zOna"] forState:UIControlStateNormal];
        }else{
             btnAction.frame=CGRectMake(135,4, 135, 50);
             [btnAction setImage:[UIImage imageNamed:@"facebook_zOna"] forState:UIControlStateNormal];
        }
       // [btnAction setTitle:[options objectAtIndex:i]  forState:UIControlStateNormal];
        [btnAction.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
        [btnAction setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [btnAction addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
        //  [btnAction.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
        [contentOptions addSubview:btnAction];

    }
    [menu addSubview:shadow];
    [menu addSubview:contentOptions];
    return self;
}
-(IBAction)selectorBtn:(UIButton*)sender{
    switch (sender.tag) {
        case 0:
            [self.delegate selectFacebookWith:self.shareMessage];
            break;
            
        case 1:
            [self.delegate selectTwitterWith:self.shareMessage];
            break;
        default:
            [self hide:YES];
            break;
    }
}

-(void)hide:(BOOL)hide{
    [menu setHidden:hide];
}
-(void)show:(BOOL)show{
    [menu setHidden:!show];
}
@end
