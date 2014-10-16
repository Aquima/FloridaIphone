//
//  VideoViewController.m
//  Florida
//
//  Created by Raul Quispe on 10/14/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController (){
    __weak IBOutlet UIWebView *webController;
    __weak IBOutlet UIView *superTopView;
    __weak IBOutlet UIView *topView;
}


@end
@interface UIDevice (MyPrivateNameThatAppleWouldNeverUseGoesHere)
- (void) setOrientation:(UIInterfaceOrientation)orientation;
@end
@implementation VideoViewController
@synthesize urlAddress;
- (void)viewDidLoad {
    [super viewDidLoad];
      [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];
    [superTopView setBackgroundColor:[UIColor colorWithHexString:@"62bf40"]];
    [topView setBackgroundColor:[UIColor colorWithHexString:@"42a221"]];
    // Do any additional setup after loading the view.
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webController loadRequest:requestObj];

}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
     //[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];
}
-(void)viewDidLayoutSubviews {
    NSLog(@"%@", (self.view.frame.size.width == ([[UIScreen mainScreen] bounds].size.width*([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height))+([[UIScreen mainScreen] bounds].size.height*([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height))) ? @"Portrait" : @"Landscape");
  //  [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeLeft];
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
