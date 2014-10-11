//
//  BuyListView.m
//  Florida
//
//  Created by Raul Quispe on 10/1/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "BuyListView.h"
#import "IngredientsCheckTableViewCell.h"
@interface BuyListView()<IngredientsCheckTableViewCellDelegate>
@end
@implementation BuyListView{
    UITextView*note;
    NSMutableArray*data;
    UITableView*tblRecipes;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize menu;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
+(BuyListView *)sharedInstance {
    static dispatch_once_t pred;
    static BuyListView *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[BuyListView alloc] init];
    });
    return shared;
}

-(id)init
{
    
    UIButton*shadow=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [shadow setBackgroundColor:[UIColor colorWithHexString:@"000000"]];
    shadow.alpha=0.6;
    shadow.tag=4;
    [shadow addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    menu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [menu setHidden:YES];
    
    UIView*contentOptions;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    if( screenHeight==568 ){
   
        NSLog(@"Iphone5");
        contentOptions=[[UIView alloc] initWithFrame:CGRectMake(18, 84, 284, 400)];
    }
    else{
        NSLog(@"Iphone4");
        contentOptions=[[UIView alloc] initWithFrame:CGRectMake(18, 34, 284, 400)];
    }
    [contentOptions setBackgroundColor:[UIColor whiteColor]];
    UIView * greenView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 284, 42)];
    [greenView setBackgroundColor:[UIColor colorWithHexString:@"42A221"]];
    
    UILabel*lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(42, 10, 200, 20.f)];
    [lblTitle setTextColor:[UIColor colorWithHexString:@"ffffff"]];
    [lblTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:16.f]];
    [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setNumberOfLines:1];
    [lblTitle setText:@"Agregar un elemento nuevo"];
    [greenView addSubview:lblTitle];
    
    UILabel*message=[[UILabel alloc] initWithFrame:CGRectMake(15, 45, 254, 52)];
    [message setTextColor:[UIColor colorWithHexString:@"333333"]];
    [message setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [message setLineBreakMode:NSLineBreakByWordWrapping];
    [message setTextAlignment:NSTextAlignmentLeft];
    [message setNumberOfLines:3];
    [message setText:@"Elige los ingredientes y selecciona la opción “Ya lo tengo” para eliminarlo de tu lista de compras"];
    [greenView addSubview:message];
    //
    [contentOptions addSubview:greenView];
    UIImageView*topBarGold = [[UIImageView alloc] initWithFrame:CGRectMake(0, 42, 270, 4)] ;
    [topBarGold setImage:[UIImage imageNamed:@"linea_degradado"]];
    [contentOptions addSubview:topBarGold];
    
    tblRecipes = [[UITableView alloc] initWithFrame:CGRectMake(0, 96, 284, 260)];
    [contentOptions addSubview:tblRecipes];
    [tblRecipes setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIButton*btnAction=[[UIButton alloc] initWithFrame:CGRectMake(142, 358, 142, 49)];
    [btnAction setBackgroundColor:[UIColor colorWithHexString:@"339933"]];
    [btnAction setTag:0];
    [btnAction setTitle:@"Ya lo tengo"  forState:UIControlStateNormal];
    [btnAction.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [btnAction setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [btnAction addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    //  [btnAction.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
    [contentOptions addSubview:btnAction];
    
    UIButton*btnActionCancel=[[UIButton alloc] initWithFrame:CGRectMake(0, 358, 142, 49)];
    [btnActionCancel setBackgroundColor:[UIColor colorWithHexString:@"ededed"]];
    [btnActionCancel setTag:1];
    [btnActionCancel setTitle:@"Cerrar"  forState:UIControlStateNormal];
    [btnActionCancel.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.f]];
    [btnActionCancel setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [btnActionCancel addTarget:self action:@selector(selectorBtn:) forControlEvents:UIControlEventTouchUpInside];
    //  [btnAction.titleLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
    [contentOptions addSubview:btnActionCancel];
    
    
    [contentOptions addSubview:note];
    
    [menu addSubview:shadow];
    [menu addSubview:contentOptions];
    return self;
}

-(IBAction)selectorBtn:(UIButton*)sender{
    [note resignFirstResponder];
    switch (sender.tag) {
        case 0:
            [self.delegate selectBuyAccept:data];
            break;
            
        case 1:
            [self.delegate selectBuyCancel];
            break;
            
        default:
            [self hide:YES];
            break;
    }
}

-(void)hide:(BOOL)hide{
    [menu setHidden:hide];
    [note resignFirstResponder];
}
-(void)show:(BOOL)show{
    [menu setHidden:!show];
    [note becomeFirstResponder];
}
#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IngredientsCheckTableViewCell *cell = (IngredientsCheckTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"IngredientsCheckTableViewCell"];
    if (cell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IngredientsCheckTableViewCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = (IngredientsCheckTableViewCell*)[topLevelObjects objectAtIndex:0];
    }
    NSArray*values=(NSArray*)[data objectAtIndex:indexPath.row];
    if ([(NSString*)[values objectAtIndex:1] isEqualToString:@"0"]) {
        [cell.btnCheck setTag:0];
        [cell.btnCheck setImage:[UIImage imageNamed:@"checkOf"] forState:UIControlStateNormal];
    }else{
        [cell.btnCheck setTag:1];
        [cell.btnCheck setImage:[UIImage imageNamed:@"checkOn"] forState:UIControlStateNormal];
    }
    [cell.lblTitle setFont:[UIFont fontWithName:@"Roboto-Medium" size:9.f]];
    [cell.lblTitle setText:(NSString*)[values objectAtIndex:0]];
    [cell setDelegate:self];
    [cell loadData:indexPath];
    return cell;
}
-(void)initWithData:(NSArray*)ingredients{
    data=[[NSMutableArray alloc] initWithArray:ingredients];
    tblRecipes.dataSource=self;
    tblRecipes.delegate=self;
    [tblRecipes reloadData];
}
-(void)reloadData{
    [tblRecipes reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"title" message:@"mesage" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    //    [alert show];
    return [data count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}// Default is 1 if not implemented
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38;
}

-(void)selectWithData:(int)newData withIndex:(NSIndexPath *)index{
    NSString*ingredient=(NSString*)[(NSArray*)[data objectAtIndex:index.row] objectAtIndex:0];
    NSArray*newValue=[[NSArray alloc] initWithObjects:ingredient,[NSString stringWithFormat:@"%d",newData], nil];
    [data replaceObjectAtIndex:index.row withObject:newValue];
}
@end
