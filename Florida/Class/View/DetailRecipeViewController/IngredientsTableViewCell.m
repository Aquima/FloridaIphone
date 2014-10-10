//
//  IngredientsTableViewCell.m
//  Florida
//
//  Created by Raul Quispe on 9/28/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "IngredientsTableViewCell.h"

@implementation IngredientsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadWithtitle:(NSString*)title withIcon:(NSString*)icon{
    [lblTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0f]];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"333333"]];

    [imgIcon setImage:[UIImage imageNamed:icon]];
    [lblTitle setText:title];
  //  [self setHtml:title];
}
- (void) setHtml: (NSString*) html
{
    
    UIFont *font = [UIFont fontWithName:@"Roboto-Medium" size:11.0f];
  //  NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                                //forKey:NSFontAttributeName];
  //  NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"strigil" attributes:attrsDictionary];
    
    NSError *err = nil;
    lblTitle.attributedText =
    [[NSAttributedString alloc]
     initWithData: [html dataUsingEncoding:NSUTF8StringEncoding]
     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType ,NSFontAttributeName:font}
     documentAttributes: nil
     error: &err];
    if(err)
        NSLog(@"Unable to parse label text: %@", err);
}

@end
