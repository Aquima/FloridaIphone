//
//  AlertFlorida.m
//  Florida
//
//  Created by Raul Quispe on 9/29/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "AlertFlorida.h"

@implementation AlertFlorida
{
    UILabel*message;
    UIButton*btnActionCancel;
    UIButton*btnAction;
    UIButton*btnOK;
    UIButton*shadow;
}
@synthesize menu;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(AlertFlorida *)sharedInstance {
    static dispatch_once_t pred;
    static AlertFlorida *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[AlertFlorida alloc] init];
    });
    return shared;
}

-(id)init
{
    shadow=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [shadow setBackgroundColor:[UIColor colorWithHexString:@"000000"]];
    shadow.alpha=0.6;
    shadow.tag=4;
    [shadow addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    menu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    
    [menu setHidden:YES];
    UIView*contentOptions;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    if( screenHeight==568 ){
        
        NSLog(@"Iphone5");
        contentOptions=[[UIView alloc] initWithFrame:CGRectMake(25, 213, 270, 141)];
    }
    else{
        NSLog(@"Iphone4");
        contentOptions=[[UIView alloc] initWithFrame:CGRectMake(25, 163.5, 270, 141)];
    }

    [contentOptions setBackgroundColor:[UIColor whiteColor]];
    UIImageView*topBarGold = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 4)] ;
    [topBarGold setImage:[UIImage imageNamed:@"linea_degradado"]];
    [contentOptions addSubview:topBarGold];
    btnAction=[[UIButton alloc] initWithFrame:CGRectMake(135, 92, 135, 49)];
    [btnAction setBackgroundColor:[UIColor colorWithHexString:@"339933"]];
    [btnAction setTag:0];
    [btnAction setTitle:@"Aceptar"  forState:UIControlStateNormal];
    [btnAction.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [btnAction setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [btnAction addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    //  [btnAction.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
    [contentOptions addSubview:btnAction];
    
    btnActionCancel=[[UIButton alloc] initWithFrame:CGRectMake(0, 92, 135, 49)];
    [btnActionCancel setBackgroundColor:[UIColor colorWithHexString:@"ededed"]];
    [btnActionCancel setTag:1];
    [btnActionCancel setTitle:@"Cancelar"  forState:UIControlStateNormal];
    [btnActionCancel.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [btnActionCancel setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [btnActionCancel addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    [contentOptions addSubview:btnActionCancel];
    btnOK=[[UIButton alloc] initWithFrame:CGRectMake(67.5, 87, 135, 49)];
    [btnOK setBackgroundColor:[UIColor colorWithHexString:@"339933"]];
    [btnOK setTag:2];
    [btnOK setTitle:@"OK"  forState:UIControlStateNormal];
    [btnOK.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [btnOK setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];

    //  [btnAction.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
    [contentOptions addSubview:btnOK];
    
    message=[[UILabel alloc] initWithFrame:CGRectMake(35, 30, 200, 36)];
    [message setTextColor:[UIColor colorWithHexString:@"333333"]];
    [message setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [message setLineBreakMode:NSLineBreakByWordWrapping];
    [message setTextAlignment:NSTextAlignmentCenter];
    [message setNumberOfLines:2];
    [contentOptions addSubview:message];
    [menu addSubview:shadow];
    [menu addSubview:contentOptions];
    return self;
}
-(void)setMessageAlert:(NSString*)messageString withOk:(BOOL)ok{
    [message setText:messageString];
    if (ok==YES) {
        [btnAction setHidden:YES];
        [btnActionCancel setHidden:YES];
        [shadow setEnabled:NO];
        [btnOK setHidden:NO];
    }else{
        [btnAction setHidden:NO];
        [btnActionCancel setHidden:NO];
        [btnOK setHidden:YES];
        [shadow setEnabled:YES];
    }
}
-(IBAction)selectorBtn:(UIButton*)sender{
    switch (sender.tag) {
        case 0:
            [self.delegate selectDelete];
            break;
        case 1:
            [self.delegate selectCancel];
            break;
        case 2:
            [self.delegate selectOk];
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
