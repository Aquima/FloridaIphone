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

@implementation VideoViewController
@synthesize urlAddress;
- (void)viewDidLoad {
    [super viewDidLoad];

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


/*
#pragma mark - Navigation
*/
- (IBAction)goBack:(id)sender {
	[self dismissViewControllerAnimated: YES completion: nil];
}

- (BOOL) shouldAutorotate { return YES; }
- (NSUInteger) supportedInterfaceOrientations { return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft; }

@end
