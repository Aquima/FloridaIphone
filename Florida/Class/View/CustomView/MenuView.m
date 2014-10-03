//
//  MenuView.m
//  Florida
//
//  Created by Raul Quispe on 9/28/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView{
   
    
}
@synthesize menu;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(MenuView *)sharedInstance {
    static dispatch_once_t pred;
    static MenuView *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[MenuView alloc] init];
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
    NSArray*options=[[NSArray alloc] initWithObjects:@"Recetas Favoritas",@"Mi Lista de Compras",@"Recetas Preparadas",@"Cerrar sesión", nil];
    UIView*contentOptions=[[UIView alloc] initWithFrame:CGRectMake(25, 67, 270, 92)];
    [contentOptions setBackgroundColor:[UIColor whiteColor]];
    UIImageView*topBarGold = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 4)] ;
    [topBarGold setImage:[UIImage imageNamed:@"linea_degradado"]];
    [contentOptions addSubview:topBarGold];
    for (int i=0; i<2; i++) {
        UIButton*btnAction=[[UIButton alloc] initWithFrame:CGRectMake(0, 4+i*44, 270, 44)];
        [btnAction setTag:i];
        [btnAction setTitle:[options objectAtIndex:i]  forState:UIControlStateNormal];
        [btnAction.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
        [btnAction setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        [btnAction addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
      //  [btnAction.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
        [contentOptions addSubview:btnAction];
        if (i>0) {
            UIView*line=[[UIView alloc] initWithFrame:CGRectMake(0, 4+i*44, 270, 0.5)];
            [line setBackgroundColor:[UIColor colorWithHexString:@"184f03"]];
            [contentOptions addSubview:line];
        }
    }
    [menu addSubview:shadow];
    [menu addSubview:contentOptions];
    return self;
}
-(IBAction)selectorBtn:(UIButton*)sender{
    switch (sender.tag) {
        case 0:
            [self.delegate selectShowfavorite];
            break;
            
        case 1:
            [self.delegate selectShowBuyList];
            break;
        case 2:
            [self.delegate selectShowRecipesPrepareted];
            break;
        case 3:
            [self.delegate selectendSesion];
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
