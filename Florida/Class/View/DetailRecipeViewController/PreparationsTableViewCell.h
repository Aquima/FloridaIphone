//
//  PreparationsTableViewCell.h
//  Florida
//
//  Created by Raul Quispe on 9/28/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreparationsTableViewCell : UITableViewCell
{
    __weak IBOutlet UILabel*lblPreparation;
}
-(void)loadWithtitle:(NSString*)preparation;
@end
