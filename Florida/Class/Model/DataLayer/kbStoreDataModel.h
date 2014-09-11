//
//  kbStoreDataModel.h
//
//  Created by Raul Quispe on 21/11/12.
//  Copyright (c) 2012 KodeBinario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface kbStoreDataModel : NSObject
@property (nonatomic, strong) NSManagedObjectModel * _managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext * _managedObjectContext;
@property (nonatomic, strong)NSPersistentStoreCoordinator *_persistentStoreCoordinator;
@property(nonatomic,strong)NSFetchedResultsController* _fetchedResultsController;

+(kbStoreDataModel*)sharedInstance;
- (NSManagedObjectContext *)managedObjectContext;
-(void)saveContext;
- (NSManagedObjectModel *)managedObjectModel;
- (void) deleteAllObjects: (NSString *) entityDescription;
-(NSFetchedResultsController *) fetchedResultsController;

@end