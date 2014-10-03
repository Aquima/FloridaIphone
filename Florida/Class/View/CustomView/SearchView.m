//
//  SearchView.m
//  Florida
//
//  Created by Raul Quispe on 10/2/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "SearchView.h"
#import "GrayTextField.h"
@implementation SearchView{
    GrayTextField*itxtSearch;
    
}
@synthesize menu;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
+(SearchView *)sharedInstance {
    static dispatch_once_t pred;
    static SearchView *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[SearchView alloc] init];
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
    UIView*contentOptions=[[UIView alloc] initWithFrame:CGRectMake(25, 67, 270, 40)];
    [contentOptions setBackgroundColor:[UIColor whiteColor]];
    UIImageView*topBarGold = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 4)] ;
    [topBarGold setImage:[UIImage imageNamed:@"linea_degradado"]];
    [contentOptions addSubview:topBarGold];
    itxtSearch = [[GrayTextField alloc] initWithFrame:CGRectMake(0, 4, 270, 40)];
    [contentOptions addSubview:itxtSearch];
    [itxtSearch setDelegate:self];
    [menu addSubview:shadow];
    [menu addSubview:contentOptions];
    return self;
}
-(IBAction)selectorBtn:(UIButton*)sender{
    switch (sender.tag) {
        default:
            [self hide:YES];
            break;
    }
}

-(void)hide:(BOOL)hide{
    [menu setHidden:hide];
    [itxtSearch setText:@""];
    [itxtSearch resignFirstResponder];
}
-(void)show:(BOOL)show{
    [menu setHidden:!show];
    [itxtSearch becomeFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.delegate goSearch:textField.text];
    [itxtSearch setText:@""];
     [self hide:YES];
    [textField resignFirstResponder];
    return YES;
}
@end
