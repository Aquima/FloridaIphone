//
//  CategoryCell.m
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "CategoryCell.h"
#import "CategoryCD.h"
@implementation CategoryCell

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
-(void)loadWithCategoryCD:(CategoryCD *)categoryCD{
    self.category=categoryCD;
    [self.lblTitle setFont:[UIFont fontWithName:@"Lora-Regular" size:10.f]];
    [self.lblTitleDish setFont:[UIFont fontWithName:@"Lora-Regular" size:9.f]];
    NSMutableString *liS=[[NSMutableString alloc]init];
    for (int i=0; i < [categoryCD.nameCategory length]; i++)
    {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [categoryCD.nameCategory characterAtIndex:i]];
        [liS appendString:ichar];
       
            [liS appendString:@" "];
        
    }

    [self.lblTitle setText:[liS uppercaseString]];
}
@end
