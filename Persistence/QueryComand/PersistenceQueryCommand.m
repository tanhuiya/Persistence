//
//  PersistentQueryCommand.m
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceQueryCommand.h"
#import "PersistenceDatabase.h"
#import "PersistenceConfiguration.h"
#import <sqlite3.h>

@interface PersistenceQueryCommand ()

@property(nonatomic,strong)NSMutableString* sqlString;
@property(nonatomic,copy)NSString* databaseName;
@property(nonatomic,strong)PersistenceDatabase* database;

@end

@implementation PersistenceQueryCommand
#pragma mark lifeCircle
-(instancetype)initWithDatabase:(PersistenceDatabase*)database{
    if ([super init]) {
        self.database = database;
    }
    return self;
}

-(instancetype)initWithDataBaseName:(NSString*)databaseName{
    if ([super init]) {
        self.databaseName = databaseName;
    }
    return self;
}

-(PersistenceQueryCommand*)resetQueryCommand{
    self.sqlString = nil;
    return self;
}

-(NSArray<NSDictionary*>*)fetchWithError:(NSError*__autoreleasing *)error{
    NSMutableArray * resultList = [NSMutableArray array];
    sqlite3_stmt* stmt = NULL;
    const char* queryStr = [self.sqlString cStringUsingEncoding:NSUTF8StringEncoding];
    int result = sqlite3_prepare_v2(self.database.database, queryStr, -1, &stmt, NULL);
    if(result != SQLITE_OK && error){
        const char* errMsg = sqlite3_errmsg(self.database.database);
        NSError * generatedError = [NSError errorWithDomain:PersistenceErrorDomain code:PersistanceErrorCodeQueryStringError userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Error in sql : %@ \n Error message is : %@ \n",self.sqlString,[NSString stringWithCString:errMsg encoding:NSUTF8StringEncoding]]}];
        sqlite3_finalize(stmt);
        *error = generatedError;
        return resultList;
    }
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        int columns = sqlite3_column_count(stmt);
        NSMutableDictionary* resultDic = [NSMutableDictionary dictionaryWithCapacity:columns];
        for (int i = 0 ; i < columns; i++) {
            const char* cname = sqlite3_column_name(stmt, i);
            NSString * columnName = [NSString stringWithCString:cname encoding:NSUTF8StringEncoding];
            int type = sqlite3_column_type(stmt, i);
            switch (type) {
                case SQLITE_INTEGER:
                {
                    int value = sqlite3_column_int(stmt, i);
                    [resultDic setObject:[NSNumber numberWithInt:value] forKey:columnName];
                    break;
                }
                case SQLITE_FLOAT:
                {
                    float value = sqlite3_column_double(stmt, i);
                    [resultDic setObject:[NSNumber numberWithFloat:value] forKey:columnName];
                    break;
                }
                case SQLITE_TEXT:
                {
                    const char* value = (const char*)sqlite3_column_text(stmt, i);
                    [resultDic setObject:[NSString stringWithCString:value encoding:NSUTF8StringEncoding] forKey:columnName];
                    break;
                }
                case SQLITE_BLOB:
                {
                    int bytes = sqlite3_column_bytes(stmt, i);
                    if(bytes > 0){
                        const void* blob = sqlite3_column_blob(stmt, i);
                        [resultDic setObject:[NSData dataWithBytes:blob length:bytes] forKey:columnName];
                    }
                    break;
                }
                case SQLITE_NULL:
                {
                    [resultDic setObject:[NSNull null] forKey:columnName];
                    break;
                }
                default:
                    break;
            }
        }
        [resultList addObject:resultDic];
    };
    return resultList;
}

-(BOOL)executeWithError:(NSError*__autoreleasing *)error{
    sqlite3_stmt* stm = NULL;
    const char* quetyStr = [self.sqlString cStringUsingEncoding:NSUTF8StringEncoding];
    int result = sqlite3_prepare_v2(self.database.database, quetyStr, -1, &stm, NULL);
    if(result != SQLITE_OK && error){
        const char* errMsg = sqlite3_errmsg(self.database.database);
        NSError * generatedError = [NSError errorWithDomain:PersistenceErrorDomain code:PersistanceErrorCodeQueryStringError userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Error in sql : %@ \n Error message is : %@ \n",self.sqlString,[NSString stringWithCString:errMsg encoding:NSUTF8StringEncoding]]}];
        sqlite3_finalize(stm);
        *error = generatedError;
        return NO;
    }
    result = sqlite3_step(stm);
    if (result != SQLITE_DONE && error) {
        const char* errMsg = sqlite3_errmsg(self.database.database);
        NSError * generatedError = [NSError errorWithDomain:PersistenceErrorDomain code:PersistanceErrorCodeQueryStringError userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Error in sql : %@ \n Error message is : %@ \n",self.sqlString,[NSString stringWithCString:errMsg encoding:NSUTF8StringEncoding]]}];
        sqlite3_finalize(stm);
        *error = generatedError;
        return NO;
    }
    sqlite3_finalize(stm);
    return YES;
}

#pragma mark - getters and setters
- (NSMutableString *)sqlString
{
    if (_sqlString == nil) {
        _sqlString = [[NSMutableString alloc] init];
    }
    return _sqlString;
}
-(PersistenceDatabase*)database{
    if (!_database) {
        NSError* error = nil;
        _database = [[PersistenceDatabase alloc]initWithDatabaseName:self.databaseName error:error];
    }
    return _database;
}
@end
