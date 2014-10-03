//
//  SeciontTableViewCell.h
//  Florida
//
//  Created by Raul Quispe on 9/27/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeciontTableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel*lblTitle;
    __weak IBOutlet UIImageView*imgIcon;
}
-(void)loadWithtitle:(NSString*)title withIcon:(NSString*)icon;
@end
