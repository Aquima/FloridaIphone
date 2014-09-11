//
//  Recipe.h
//  Florida
//
//  Created by Raul Quispe on 9/10/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject
@property(nonatomic,strong)NSString*idCategory;
@property(nonatomic,strong)NSString*nameCategory;
@property(nonatomic,strong)NSString*idRecipe;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*url_image;
@property(nonatomic,strong)NSString*time;
@property(nonatomic,strong)NSString*portions;
@property(nonatomic,strong)NSString*has_video;
@property(nonatomic,strong)NSString*ranking;
/*
 id : "3"
 url_image : "http://florida.pe/fotos/receta/3/crepes_en_salsa_de_atun.jpg"
 title : "Crepes en salsa de atún"
 time : "15"
 portions : "6"
 has_video : "0"
 ranking : "4"
 */
@end
