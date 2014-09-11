//
//  RecipeCD.h
//  Florida
//
//  Created by Raul Quispe on 9/10/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RecipeCD : NSManagedObject

@property (nonatomic, retain) NSString * idRecipe;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * portions;
@property (nonatomic, retain) NSString * urlImage;
@property (nonatomic, retain) NSString * hasVideo;
@property (nonatomic, retain) NSString * ranking;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSString * idCategory;
@property (nonatomic, retain) NSString * nameCategory;

@end
