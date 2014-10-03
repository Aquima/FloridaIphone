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
    UIButton*shadow=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [shadow setBackgroundColor:[UIColor colorWithHexString:@"000000"]];
    shadow.alpha=0.6;
    shadow.tag=4;
    [shadow addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    menu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    
    [menu setHidden:YES];
    UIView*contentOptions=[[UIView alloc] initWithFrame:CGRectMake(25, 213, 270, 141)];
    [contentOptions setBackgroundColor:[UIColor whiteColor]];
    UIImageView*topBarGold = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 4)] ;
    [topBarGold setImage:[UIImage imageNamed:@"linea_degradado"]];
    [contentOptions addSubview:topBarGold];
    UIButton*btnAction=[[UIButton alloc] initWithFrame:CGRectMake(135, 92, 135, 49)];
    [btnAction setBackgroundColor:[UIColor colorWithHexString:@"339933"]];
    [btnAction setTag:0];
    [btnAction setTitle:@"Aceptar"  forState:UIControlStateNormal];
    [btnAction.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [btnAction setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [btnAction addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    //  [btnAction.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
    [contentOptions addSubview:btnAction];
    
    UIButton*btnActionCancel=[[UIButton alloc] initWithFrame:CGRectMake(0, 92, 135, 49)];
    [btnActionCancel setBackgroundColor:[UIColor colorWithHexString:@"ededed"]];
    [btnActionCancel setTag:1];
    [btnActionCancel setTitle:@"Cancelar"  forState:UIControlStateNormal];
    [btnActionCancel.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [btnActionCancel setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [btnActionCancel addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    //  [btnAction.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
    [contentOptions addSubview:btnActionCancel];
    
    UILabel*message=[[UILabel alloc] initWithFrame:CGRectMake(35, 30, 200, 36)];
    [message setTextColor:[UIColor colorWithHexString:@"333333"]];
    [message setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [message setLineBreakMode:NSLineBreakByWordWrapping];
    [message setTextAlignment:NSTextAlignmentCenter];
    [message setNumberOfLines:2];
    [message setText:@"¿Estás seguro de eliminar de tu lista de favoritos?"];
    [contentOptions addSubview:message];
    [menu addSubview:shadow];
    [menu addSubview:contentOptions];
    return self;
}
-(IBAction)selectorBtn:(UIButton*)sender{
    switch (sender.tag) {
        case 0:
            [self.delegate selectDelete];
            break;
            
        case 1:
            [self.delegate selectCancel];
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
