//
//  PreparationsTableViewCell.m
//  Florida
//
//  Created by Raul Quispe on 9/28/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "PreparationsTableViewCell.h"

@implementation PreparationsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadWithtitle:(NSString*)preparation{
    [lblPreparation setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0f]];
    [lblPreparation setTextColor:[UIColor colorWithHexString:@"333333"]];
    [lblPreparation setNumberOfLines:50];
    float ancho=preparation.length*9;
    int numberLines=ceilf(ancho/304);
    lblPreparation.frame=CGRectMake(10, 0, 300, (numberLines*9)+10);
    [lblPreparation setText:preparation];
}
@end
