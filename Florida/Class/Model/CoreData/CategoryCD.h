//
//  CategoryCD.h
//  Florida
//
//  Created by Raul Quispe on 9/26/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CategoryCD : NSManagedObject

@property (nonatomic, retain) NSString * idCategory;
@property (nonatomic, retain) NSString * nameCategory;

@end
