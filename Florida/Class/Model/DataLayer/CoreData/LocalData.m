//
//  LocalData.m
//  CotizadorSodimac
//
//  Created by Raul Quispe on 5/25/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "LocalData.h"
#import "kbStoreDataModel.h"
#import "RecipeCD.h"
#import "CategoryRecipe.h"
#import "CategoryCD.h"
#import "Recipe.h"
@implementation LocalData

#pragma mark - SProduct
+ (NSManagedObject *)insertarObjeto:(NSDictionary *)aObjDic enTabla:(NSString *)aTable{


    NSManagedObject  *objNuevo = [NSEntityDescription insertNewObjectForEntityForName:aTable inManagedObjectContext:[[kbStoreDataModel sharedInstance] managedObjectContext]];
    [objNuevo setValue:[aObjDic objectForKey:@"idQuotation"] forKey:@"idQuotation"];
    return [self grabarCambiosDeObjeto:objNuevo];

}
+ (void)insertarObjetoCategory:(CategoryRecipe *)category{
    CategoryCD  *objNuevo = [NSEntityDescription insertNewObjectForEntityForName:@"CategoryCD" inManagedObjectContext:[[kbStoreDataModel sharedInstance] managedObjectContext]];
    objNuevo.idCategory=category.idCategory;
    objNuevo.nameCategory=category.nameCategory;
   // [objNuevo setValue:[aObjDic objectForKey:@"idQuotation"] forKey:@"idQuotation"];
   [self grabarCambiosDeObjeto:objNuevo];
}
+ (void)insertarObjetoRecipe:(Recipe *)recipe{
    RecipeCD  *objNuevo = [NSEntityDescription insertNewObjectForEntityForName:@"RecipeCD" inManagedObjectContext:[[kbStoreDataModel sharedInstance] managedObjectContext]];
    objNuevo.idCategory=recipe.idCategory;
    objNuevo.nameCategory=recipe.nameCategory;
    objNuevo.time=recipe.time;
    objNuevo.title=recipe.title;
    objNuevo.portions=recipe.portions;
    objNuevo.ranking=recipe.ranking;
    objNuevo.urlImage=recipe.url_image;
    objNuevo.hasVideo=recipe.has_video;
    objNuevo.isFavorite=NO;
    objNuevo.idRecipe=recipe.idRecipe;
    // [objNuevo setValue:[aObjDic objectForKey:@"idQuotation"] forKey:@"idQuotation"];
    [self grabarCambiosDeObjeto:objNuevo];
}
+ (NSManagedObject *)existeElementoEnLaTabla:(NSString *)aTabla{
    
    NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:aTabla inManagedObjectContext:[[kbStoreDataModel sharedInstance] managedObjectContext]];
	[fetchRequest setEntity:entity];

    NSArray *arrayElementos = [[kbStoreDataModel sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if ([arrayElementos count] != 0) {
        return [arrayElementos objectAtIndex:0];
    }
	return nil;
}
+ (NSManagedObject *)grabarCambiosDeObjeto:(NSManagedObject *)objDM{
    NSError *error;

    if (![[[kbStoreDataModel sharedInstance] managedObjectContext] save:&error]){
        NSLog(@"NO SE PUDO ACTUALIZAR LA TABLA:%@  -  %@",objDM.entity.name ,[error localizedDescription]);
        return nil;
    }
    return objDM;
}
+(void)deleteElement:(NSManagedObject*)obj{
     [[kbStoreDataModel sharedInstance].managedObjectContext deleteObject:obj];
    NSError *error = nil;
    [[kbStoreDataModel sharedInstance].managedObjectContext save:&error];
}
+(void)deleteElement:(NSString*)toTable idElement:(NSString*)idElement{
    NSError *error;
    NSPredicate*query = [NSPredicate predicateWithFormat:@"idQuotation=%i",idElement];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:query];
	NSEntityDescription *entity = [NSEntityDescription entityForName:toTable inManagedObjectContext:[[kbStoreDataModel sharedInstance] managedObjectContext]];
	[fetchRequest setEntity:entity];

    NSArray *arrayElementos = [[kbStoreDataModel sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if ([arrayElementos count] != 0) {
        [[kbStoreDataModel sharedInstance].managedObjectContext deleteObject:[arrayElementos lastObject]];
    }
}
+(NSArray*)listElements:(NSString*)toTable{
    NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:toTable inManagedObjectContext:[[kbStoreDataModel sharedInstance] managedObjectContext]];
	[fetchRequest setEntity:entity];

    NSArray *arrayElementos = [[kbStoreDataModel sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if ([arrayElementos count] != 0) {
        return arrayElementos;
    }
	return nil;

}
#pragma mark - elements
+(NSArray*)listElements:(NSString*)toTable withQuery:(NSString*)query{
    NSError *error;
    NSPredicate*predicate = [NSPredicate predicateWithFormat:@"%@",query];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:predicate];
	NSEntityDescription *entity = [NSEntityDescription entityForName:toTable inManagedObjectContext:[[kbStoreDataModel sharedInstance] managedObjectContext]];
	[fetchRequest setEntity:entity];

    NSArray *arrayElementos = [[kbStoreDataModel sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if ([arrayElementos count] != 0) {
        return arrayElementos;
    }
	return nil;
  /*  NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"companyName contains[cd] %@ OR boothNumber beginswith %@",
                              text,
                              text];
    
    // commented out old starting point :)
    //[results addObjectsFromArray:[all filteredArrayUsingPredicate:predicate]];
    
    // create a descriptor
    // this assumes that the results are Key-Value-accessible
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"companyName"
                                                                 ascending:YES];
    //
    NSArray *results = [[all filteredArrayUsingPredicate:predicate]
                        sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];*/

}
@end
