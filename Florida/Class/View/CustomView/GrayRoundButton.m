//
//  GrayRoundButton.m
//  Emoiste
//
//  Created by Raul Quispe on 9/4/14.
//  Copyright (c) 2014 emoiste. All rights reserved.
//

#import "GrayRoundButton.h"

@implementation GrayRoundButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
   // [self setBackgroundColor:[UIColor colorWithHexString:@"4f4744"]];
    [[self layer] setCornerRadius:25.f];
   [[self layer] setMasksToBounds:YES];
    [self setColor:[UIColor colorWithHexString:@"5c2a47"] forState:UIControlStateNormal];
    [self setColor:[UIColor colorWithHexString:@"d0ccbf"] forState:UIControlStateHighlighted];

    // [self setColor:[UIColor colorWithHexString:@"4f4744"] forState:UIControlStateHighlighted];
       // [self.layer setBorderColor:[[UIColor colorWithHexString:@"4f4744"] CGColor]];
   
}

- (void)setColor:(UIColor *)color forState:(UIControlState)state
{
    UIView *colorView = [[UIView alloc] initWithFrame:self.frame];
    colorView.backgroundColor = color;
    
    UIGraphicsBeginImageContext(colorView.bounds.size);
    [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:colorImage forState:state];
}
@end
