//
//  PersistenceDatabase.m
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceDatabase.h"

@interface PersistenceDatabase ()

@property(nonatomic,assign)sqlite3* database;
@property(nonatomic,copy)NSString* databaseName;
@property(nonatomic,copy)NSString* databaseFilePath;

@end

@implementation PersistenceDatabase

#pragma mark lifeCircle

-(instancetype)initWithDatabaseName:(NSString *)databaseName error:(NSError *)error{
    if([super init]){
        self.databaseName = databaseName;
        self.databaseFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:self.databaseName];
//        BOOL isDatabaseExsit = [[NSFileManager defaultManager]fileExistsAtPath:self.databaseFilePath];
        if (sqlite3_open([self.databaseFilePath cStringUsingEncoding:NSUTF8StringEncoding], &_database) != SQLITE_OK) {
            [self closeDatabase];
        }
    }
    return self;
}
-(void)dealloc{
    [self closeDatabase];
}
-(void)closeDatabase{
    sqlite3_close(self.database);
    self.databaseFilePath = nil;
}
@end
