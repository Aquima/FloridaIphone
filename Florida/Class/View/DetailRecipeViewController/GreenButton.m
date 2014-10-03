//
//  GreenButton.m
//  Florida
//
//  Created by Raul Quispe on 9/28/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "GreenButton.h"

@implementation GreenButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
  //  [self setColor:[UIColor colorWithHexString:@"007052"] forState:UIControlStateSelected];
   // [self setColor:[UIColor colorWithHexString:@"339933"] forState:UIControlStateNormal];

    
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
