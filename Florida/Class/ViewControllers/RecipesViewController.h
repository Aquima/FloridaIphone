//
//  RecipesViewController.h
//  Florida
//
//  Created by Raul Quispe on 9/11/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipesViewController : UIViewController
@property(nonatomic,strong)NSArray*recipeList;
@property(nonatomic,strong)NSString*titleList;
@property BOOL isFavorite;
@property BOOL isBuyList;
@end
