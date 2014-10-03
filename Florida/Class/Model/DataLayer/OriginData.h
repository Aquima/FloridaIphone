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
@property (nonatomic,strong) NSArray*listRecipesCD;
@property(nonatomic,strong)CLLocation *myLocation;
+(OriginData *)sharedInstance;

-(void)stateOfConection;
#pragma Login
-(void)invokeAsyncSyncRecipes:(NSString*)nameNotification;
-(void)invokeAsyncSyncDetailRecipe:(NSString*)nameNotification withIdRecipe:(NSString*)idRecipe withRecipe:(id)recipe;
@end