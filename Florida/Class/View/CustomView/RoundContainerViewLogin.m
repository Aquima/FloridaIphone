//
//  RoundContainerViewLogin.m
//  Emoiste
//
//  Created by Raul Quispe on 9/3/14.
//  Copyright (c) 2014 emoiste. All rights reserved.
//

#import "RoundContainerViewLogin.h"

@implementation RoundContainerViewLogin
@synthesize contentView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
         [self.layer setBackgroundColor:[UIColor colorWithHexString:@"96908e"].CGColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code olvidadDiza dulce como la brisa
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds byRoundingCorners: UIRectCornerBottomRight | UIRectCornerBottomLeft | UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.backgroundColor=[UIColor clearColor];
    maskLayer.backgroundColor=(__bridge CGColorRef)([UIColor clearColor]);
    self.layer.mask = maskLayer;
    self.layer.mask = maskLayer;
   
    UIView*view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [view setBackgroundColor:[UIColor colorWithHexString:@"96908e"]];
    [self addSubview:view];
    
    contentView.frame = CGRectMake(6, 6, self.frame.size.width-12, self.frame.size.height-12);
    [contentView setBackgroundColor:[UIColor redColor]];
    [view addSubview:contentView];
    
    UIBezierPath *maskPathContent = [UIBezierPath bezierPathWithRoundedRect:contentView.layer.bounds byRoundingCorners: UIRectCornerBottomRight | UIRectCornerBottomLeft | UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayerContent = [CAShapeLayer layer];
    maskLayerContent.frame = contentView.bounds;
    maskLayerContent.path = maskPathContent.CGPath;
    contentView.backgroundColor=[UIColor whiteColor];
    maskLayerContent.backgroundColor=(__bridge CGColorRef)([UIColor clearColor]);
    contentView.layer.mask = maskLayerContent;
    contentView.layer.mask = maskLayerContent;
}


@end
