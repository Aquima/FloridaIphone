//
//  IngredientsCheckTableViewCell.m
//  Florida
//
//  Created by Raul Quispe on 10/1/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "IngredientsCheckTableViewCell.h"

@implementation IngredientsCheckTableViewCell{
    NSIndexPath*currentIndexpath;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)selectorCheck:(UIButton*)sender{
    if (sender.tag == 0) {
        sender.tag = 1;
        [self.delegate selectWithData:1 withIndex:currentIndexpath];
        [sender setImage:[UIImage imageNamed:@"checkOn"] forState:UIControlStateNormal];
    }else{
         sender.tag = 0;
         [self.delegate selectWithData:0 withIndex:currentIndexpath];
        [sender setImage:[UIImage imageNamed:@"checkOf"] forState:UIControlStateNormal];
    }
}
-(void)loadData:(NSIndexPath*)index{
    currentIndexpath=index;
}
@end
