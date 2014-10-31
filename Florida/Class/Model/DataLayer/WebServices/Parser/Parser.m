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
       
       NSMutableArray*ingredientesCompuesto=[[NSMutableArray alloc] init];
        int indexIngredient=0;
        for (NSString*ingrediente in ingredients) {
            NSString*strIndex=[NSString stringWithFormat:@"%d",indexIngredient];
            NSString*ingredients =[ingrediente stringByReplacingOccurrencesOfString:@"&uacute;" withString:@"ú"];
            ingredients =[ingredients stringByReplacingOccurrencesOfString:@"&aacute;" withString:@"á"];
            ingredients =[ingredients stringByReplacingOccurrencesOfString:@"&oacute;" withString:@"ó"];
            ingredients =[ingredients stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"é"];
            ingredients =[ingredients stringByReplacingOccurrencesOfString:@"&iacute;" withString:@"í"];
            ingredients =[ingredients stringByReplacingOccurrencesOfString:@"&uacute;" withString:@"ú"];
            ingredients=[ingredients stringByReplacingOccurrencesOfString:@"<span style=\"text-decoration: underline;\">" withString:@""];
            ingredients=[ingredients stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
             ingredients=[ingredients stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"ñ"];
            ingredients=[ingredients stringByReplacingOccurrencesOfString:@"&frac12;" withString:@"½"];
             ingredients=[ingredients stringByReplacingOccurrencesOfString:@"&frac14;" withString:@"¼"];
            ingredients=[ingredients stringByReplacingOccurrencesOfString:@"&frac18;" withString:@"⅛"];
            ingredients=[ingredients stringByReplacingOccurrencesOfString:@"&ordm;" withString:@"º"];

            NSArray*index=[[NSArray alloc] initWithObjects:ingredients,@"1",strIndex, nil];
            if (![ingredients isEqualToString:@""]) {
                 [ingredientesCompuesto addObject:index];
                indexIngredient++;
            }
           
        }
         NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:ingredientesCompuesto];
        recipeCD.ingredients=arrayData;//[NSString stringWithFormat:@"%@",stringIngredients]; NSASCIIStringEncoding
        
        NSData *stringData = [[response objectForKey:@"preparation"] dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES];
        NSString *cleanString = [[NSString alloc] initWithData: stringData encoding: NSASCIIStringEncoding];
     
        cleanString =[cleanString stringByReplacingOccurrencesOfString:@"&aacute;" withString:@"á"];
        cleanString =[cleanString stringByReplacingOccurrencesOfString:@"&oacute;" withString:@"ó"];
        cleanString =[cleanString stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"é"];
        cleanString =[cleanString stringByReplacingOccurrencesOfString:@"&iacute;" withString:@"í"];
        cleanString =[cleanString stringByReplacingOccurrencesOfString:@"&uacute;" withString:@"ú"];
        cleanString=[cleanString stringByReplacingOccurrencesOfString:@"&uacute;" withString:@"ú"];
        cleanString=[cleanString stringByReplacingOccurrencesOfString:@"<span style=\"text-decoration: underline;\">" withString:@""];
        cleanString=[cleanString stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
        cleanString=[cleanString stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"ñ"];
        cleanString=[cleanString stringByReplacingOccurrencesOfString:@"&frac12;" withString:@"½"];
        cleanString=[cleanString stringByReplacingOccurrencesOfString:@"&frac14;" withString:@"¼"];
        cleanString=[cleanString stringByReplacingOccurrencesOfString:@"&frac18;" withString:@"⅛"];
        cleanString=[cleanString stringByReplacingOccurrencesOfString:@"&ordm;" withString:@"º"];
        //"<span style=\"text-decoration: underline;\">Vinagreta dulce</span>",
        NSString* str = [NSString stringWithUTF8String:[cleanString cStringUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@", str);
        
     //   NSString *correctString =[NSString stringWithUTF8String:cleanString];
        recipeCD.preparation=cleanString;//[NSString stringWithFormat:@"%s",[[response objectForKey:@"preparation"] UTF8String]];
        recipeCD.syncComplete=@1;
        recipeCD.isBuyList=@0;
        [LocalData grabarCambiosDeObjeto:recipeCD];
        return recipeCD;
    }
    
}
@end