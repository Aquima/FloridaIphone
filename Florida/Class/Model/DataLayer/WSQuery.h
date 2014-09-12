//
//  WSQuery.h
//  Florida
//
//  Created by Raul Quispe on 9/9/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSQuery : NSObject
+(void)getRecipes:(NSString *)nameNotification withSession:(NSURLSession*)defaultSession;
+(void)getDeteailRecipe:(NSString *)nameNotification withRecipeId:(NSString*)idRecipe withSession:(NSURLSession*)defaultSession;
@end
