//
//  Parser.h
//  ZonaEntel
//
//  Created by Raul Quispe on 12/14/13.
//  Copyright (c) 2013 kodebinario. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Recipe;
@class RecipeCD;
@interface Parser : NSObject

+(NSDictionary*)parseRecipes:(NSDictionary*)response;
+(RecipeCD*)parseRecipeDetail:(NSDictionary*)response withRecipe:(id)recipe;
@end
