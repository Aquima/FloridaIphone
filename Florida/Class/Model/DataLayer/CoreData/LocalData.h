//
//  LocalData.h
//  CotizadorSodimac
//
//  Created by Raul Quispe on 5/25/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObject;
@class CategoryRecipe;
@class Recipe;
@interface LocalData : NSObject
+ (NSManagedObject *)grabarCambiosDeObjeto:(NSManagedObject *)objDM;
+ (NSManagedObject *)insertarObjeto:(NSDictionary *)aObjDic enTabla:(NSString *)aTable;
+(NSArray*)listElements:(NSString*)toTable;
+(void)deleteElement:(NSManagedObject*)obj;
+(void)deleteElement:(NSString*)toTable idElement:(NSString*)idElement;
+(void)insertarObjetoCategory:(CategoryRecipe *)category;
+ (void)insertarObjetoRecipe:(Recipe *)recipe;
@end
