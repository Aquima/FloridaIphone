//
//  OriginData.m
//  ZonaEntel
//
//  Created by Raul Quispe on 12/13/13.
//  Copyright (c) 2013 kodebinario. All rights reserved.
//

#import "OriginData.h"
#import "Reachability.h"
#import "WSQuery.h"
#import "LocalData.h"
@implementation OriginData
@synthesize isAvailableConnection;
+(OriginData *)sharedInstance {
    static dispatch_once_t pred;
    static OriginData *shared = nil;

    dispatch_once(&pred, ^{
        shared = [[OriginData alloc] init];
    });
    return shared;
}
-(id)init
{
    
    defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    return self;
}
-(void)stateOfConection
{
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];

    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        self.isAvailableConnection=YES;
    };

    reach.unreachableBlock = ^(Reachability*reach)
    {
        self.isAvailableConnection=NO;
    };

    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
}

-(void)invokeAsyncSyncRecipes:(NSString*)nameNotification  {
    NSUserDefaults*infoUser=[NSUserDefaults standardUserDefaults];
    if ([infoUser objectForKey:@"syncComplete"]==nil) {
         [WSQuery getRecipes:nameNotification withSession:defaultSession];
//        if (self.isAvailableConnection) {
//            //call web service
//            [WSQuery getRecipes:nameNotification withSession:defaultSession];
//            /*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endGetRecipes:) name:@"endRecipes" object:nil];*/
//            // [WSRegister getLogin:nameNotification withUserData:userData];
//        }else{
//            //call data on my device or show alert error of conection
//            UIAlertView*showStatus = [[UIAlertView alloc] initWithTitle:@"Internet" message:@"No hay conexion a internet" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
//            [showStatus show];
//        }
    }else{
        NSArray*categoryList = [LocalData listElements:@"CategoryCD"];
        NSArray*recipesList = [LocalData listElements:@"RecipeCD"];
        NSDictionary*categoryAndRecipe = @{@"CategoryList": categoryList,@"RecipeList":recipesList};
        [[NSNotificationCenter defaultCenter] postNotificationName:nameNotification object:categoryAndRecipe];
    }
   
}
-(void)invokeAsyncSyncDetailRecipe:(NSString*)nameNotification withIdRecipe:(NSString*)idRecipe withRecipe:(id)recipe{
    [WSQuery getDeteailRecipe:nameNotification withRecipeId:idRecipe withRecipe:recipe withSession:defaultSession];
   // [WSQuery getDeteailRecipe:nameNotification withRecipeId:idRecipe withSession:defaultSession];
}


@end
