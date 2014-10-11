//
//  NoteView.m
//  Florida
//
//  Created by Raul Quispe on 9/29/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView{
    UITextView*note;
}
@synthesize menu;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(NoteView *)sharedInstance {
    static dispatch_once_t pred;
    static NoteView *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[NoteView alloc] init];
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
    UIView*contentOptions;//=[[UIView alloc] initWithFrame:CGRectMake(25, 173, 270, 141)];
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    if( screenHeight==568 ){
        
        NSLog(@"Iphone5");
        contentOptions=[[UIView alloc] initWithFrame:CGRectMake(25, 173, 270, 141)];
    }
    else{
        NSLog(@"Iphone4");
        contentOptions=[[UIView alloc] initWithFrame:CGRectMake(25, 64, 270, 141)];
    }
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
    
    note=[[UITextView alloc] initWithFrame:CGRectMake(15, 6, 240, 83)];
    [note setTextColor:[UIColor colorWithHexString:@"333333"]];
    [note setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [note setTextAlignment:NSTextAlignmentLeft];
   // [note setText:@"Escribe aquí tus notas para Empanadas de atún"];
    [note setReturnKeyType:UIReturnKeyDone];
    [note setDelegate:self];
    [contentOptions addSubview:note];
    [menu addSubview:shadow];
    [menu addSubview:contentOptions];
   
    return self;
}
-(BOOL)isIphone5{
    if (( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < 468) {
        return TRUE;
    }else{
        return FALSE;
    }

}
-(IBAction)selectorBtn:(UIButton*)sender{
    [note resignFirstResponder];
    switch (sender.tag) {
        case 0:
            [self.delegate selectNoteAccept:note.text];
            break;
            
        case 1:
            [self.delegate selectNoteCancel];
            break;
            
        default:
            [self hide:YES];
            break;
    }
}

-(void)hide:(BOOL)hide{
    [menu setHidden:hide];
    [note resignFirstResponder];
}
-(void)show:(BOOL)show{
    [menu setHidden:!show];
    [note becomeFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    } else {
        if ([textView.text isEqualToString:self.message]) {
            textView.text=@"";
        }else{
            
        }
        NSLog(@"Other pressed");
    }
    return YES;
}
-(void)setText:(NSString*)text{
    [note setText:text];
}
@end
