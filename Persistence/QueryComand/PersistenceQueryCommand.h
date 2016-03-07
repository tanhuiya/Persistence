//
//  PersistentQueryCommand.h
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersistenceDatabase;

@interface PersistenceQueryCommand : NSObject
@property(nonatomic,strong,readonly)NSMutableString* sqlString;

-(instancetype)initWithDatabase:(PersistenceDatabase*)database;

-(instancetype)initWithDataBaseName:(NSString*)databaseName;

-(PersistenceQueryCommand*)resetQueryCommand;

-(BOOL)executeWithError:(NSError* __autoreleasing*)error;

-(NSArray<NSDictionary*>*)fetchWithError:(NSError*__autoreleasing *)error;

@end
