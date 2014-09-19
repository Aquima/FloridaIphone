//
//  Parser.m
//  ZonaEntel
//
//  Created by Raul Quispe on 12/14/13.
//  Copyright (c) 2013 kodebinario. All rights reserved.
//

#import "Parser.h"
#import "Recipe.h"
#import "CategoryRecipe.h"
#import "LocalData.h"
#import "RecipeCD.h"
@implementation Parser
/*
+(NSArray*)parseLevel:(NSDictionary*)response
{
    @autoreleasepool {
        //    Levels*newLevel=[[Levels alloc] init];
        
        return listLevels;
    }
}*/
+(NSDictionary*)parseRecipes:(NSDictionary*)response{
    @autoreleasepool {
        
        NSMutableArray*recipesList=[[NSMutableArray alloc] init];
        NSMutableArray*categoryList=[[NSMutableArray alloc] init];
        NSArray*recipesWithCategory=(NSArray*)[response objectForKey:@"recipes"];
        for (NSDictionary*category in recipesWithCategory) {
            NSArray*__weak recipes=(NSArray*)[category objectForKey:@"recipes"];
            CategoryRecipe*newCategory=[[CategoryRecipe alloc] init];
            newCategory.idCategory= [category objectForKey:@"id"];
            newCategory.nameCategory = [category objectForKey:@"name"];
            [categoryList addObject:newCategory];
            for (NSDictionary*recipe in recipes) {
                Recipe*newRecipe=[[Recipe alloc] init];
                newRecipe.idCategory = [category objectForKey:@"id"];
                newRecipe.nameCategory = [category objectForKey:@"name"];
                newRecipe.idRecipe = [recipe objectForKey:@"id"];
                newRecipe.title = [recipe objectForKey:@"title"];
                newRecipe.url_image = [recipe objectForKey:@"url_image"];
                newRecipe.time = [recipe objectForKey:@"time"];
                newRecipe.has_video = [recipe objectForKey:@"has_video"];
                newRecipe.ranking = [recipe objectForKey:@"ranking"];
                newRecipe.portions = [recipe objectForKey:@"portions"];
                
                [recipesList addObject:newRecipe];
            }
        }
        for (Recipe*recipe in recipesList) {
            [LocalData insertarObjetoRecipe:recipe];
        }
        for (CategoryRecipe*category in categoryList) {
            [LocalData insertarObjetoCategory:category];
        }
        NSArray*categoryCDList = [LocalData listElements:@"CategoryCD"];
        NSArray*recipesCDList = [LocalData listElements:@"RecipeCD"];
        NSDictionary*categoryAndRecipe = @{@"CategoryList": categoryCDList,@"RecipeList":recipesCDList};
        NSUserDefaults*infoUser = [NSUserDefaults standardUserDefaults];
        [infoUser setObject:@"YES" forKey:@"syncComplete"];
        [infoUser synchronize];
        return  categoryAndRecipe;
    }
    
}
+(RecipeCD*)parseRecipeDetail:(NSDictionary*)response withRecipe:(id)recipe{
    @autoreleasepool {
        
        RecipeCD*recipeCD=(RecipeCD*)recipe;
        recipeCD.urlVideo=[NSString stringWithFormat:@"%@",[response objectForKey:@"url_video"]];
        recipeCD.url_share=[NSString stringWithFormat:@"%@",[response objectForKey:@"url_share"]];
        NSArray*ingredients=(NSArray*)[response objectForKey:@"ingredients"];
        NSMutableString*stringIngredients=[[NSMutableString alloc] init];
        for (NSString*ingrediente in ingredients) {
            [stringIngredients appendString:[NSString stringWithFormat:@"\n%@",ingrediente]];
        }
        recipeCD.ingredients=[NSString stringWithFormat:@"%@",stringIngredients];
        recipeCD.preparation=[NSString stringWithFormat:@"%@",[response objectForKey:@"preparation"]];
        recipeCD.syncComplete=@1;
        [LocalData grabarCambiosDeObjeto:recipeCD];
        return recipeCD;
    }
    
}
@end