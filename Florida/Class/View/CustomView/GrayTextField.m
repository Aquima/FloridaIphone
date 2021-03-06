//
//  GrayTextField.m
//  Emoiste
//
//  Created by Raul Quispe on 9/4/14.
//  Copyright (c) 2014 emoiste. All rights reserved.
//

#import "GrayTextField.h"

@implementation GrayTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[self layer] setMasksToBounds:NO];
    UIColor *fillColor = [UIColor colorWithHexString:@"ffffff"];
    [fillColor setFill];
    // [self setBackgroundColor:[UIColor clearColor]];
    UIColor *strokeColor =[UIColor colorWithHexString:@"ffffff"];
    [strokeColor setStroke];
    float corner=0.0;
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(corner, 0.0)];
    
    // Draw the lines.
    [aPath addLineToPoint:CGPointMake(self.frame.size.width, 0.0)];
    [aPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height-corner)];
    [aPath addLineToPoint:CGPointMake(self.frame.size.width-corner, self.frame.size.height)];
    [aPath addLineToPoint:CGPointMake(0.0, self.frame.size.height)];
    [aPath addLineToPoint:CGPointMake(0.0, corner)];
    
    [aPath closePath];
    [aPath fill];
    [aPath stroke];
    
    [[self layer] setCornerRadius:3.f];
    [[self layer] setMasksToBounds:YES];
    [self setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor lightGrayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Buscar Receta" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 10, bounds.origin.y + 8,
                      bounds.size.width - 20, bounds.size.height - 16);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}


@end
