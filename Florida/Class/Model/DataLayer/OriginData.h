//
//  OriginData.h
//  ZonaEntel
//
//  Created by Raul Quispe on 12/13/13.
//  Copyright (c) 2013 kodebinario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface OriginData : NSObject{
    NSURLSessionConfiguration *defaultConfigObject;
    NSURLSession *defaultSession;
}
@property BOOL isAvailableConnection;
@property (nonatomic,strong) NSMutableArray*callCompletedOffLine;
@property (nonatomic,strong) NSMutableArray*allBenefits;
@property(nonatomic,strong)CLLocation *myLocation;
+(OriginData *)sharedInstance;

-(void)stateOfConection;
#pragma Login
-(void)invokeAsyncSyncRecipes:(NSString*)nameNotification;
@end