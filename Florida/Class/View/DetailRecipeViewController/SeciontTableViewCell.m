//
//  SeciontTableViewCell.m
//  Florida
//
//  Created by Raul Quispe on 9/27/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "SeciontTableViewCell.h"

@implementation SeciontTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadWithtitle:(NSString*)title withIcon:(NSString*)icon{
    [lblTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.0f]];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"ffffff"]];
    [self setBackgroundColor:[UIColor colorWithHexString:@"5a5a77"]];
    [imgIcon setImage:[UIImage imageNamed:icon]];
    [lblTitle setText:title];
}
@end
