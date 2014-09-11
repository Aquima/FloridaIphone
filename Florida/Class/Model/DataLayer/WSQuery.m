//
//  WSQuery.m
//  Florida
//
//  Created by Raul Quispe on 9/9/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "WSQuery.h"
#import "Parser.h"
#import "Constants.h"
@implementation WSQuery
+(void)getRecipes:(NSString *)nameNotification withSession:(NSURLSession*)defaultSession
{
   // NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userData options:kNilOptions error:nil];
    
    
    NSString*methodName=@"recetas";
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@",PATH,methodName];
    NSString *properlyEscapedURL = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:properlyEscapedURL];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"Get"];
   // [request setHTTPBody:jsonData];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:request
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                            if(error == nil){
                                                                NSError *jsonError = nil;
                                                                id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                                                                //translate
                                                                NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                                                                //parse to entity
                                                                //  [Parser parseUser:jsonDictionary];
                                                                //  [[Parser sharedInstance] ]
                                                                [[NSNotificationCenter defaultCenter] postNotificationName:nameNotification object:[Parser parseRecipes:jsonDictionary]];
                                                            }
                                                            
                                                        }];
    
    [dataTask resume];
}

@end
