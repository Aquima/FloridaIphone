//
//  Parser.h
//  ZonaEntel
//
//  Created by Raul Quispe on 12/14/13.
//  Copyright (c) 2013 kodebinario. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Recipe;
@interface Parser : NSObject

+(NSDictionary*)parseRecipes:(NSDictionary*)response;

@end
