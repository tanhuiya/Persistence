//
//  PersistenceDatabase.h
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface PersistenceDatabase : NSObject

@property(nonatomic,assign,readonly)sqlite3 *database;

@property(nonatomic,copy,readonly)NSString* databaseName;

@property(nonatomic,copy,readonly)NSString* databaseFilePath;


-(instancetype)initWithDatabaseName:(NSString*)databaseName error:(NSError*)error;
@end
