//
//  PersistenceTable+Update.h
//  Persistence
//
//  Created by ci123 on 16/3/9.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceTable.h"

@interface PersistenceTable (Update)
-(BOOL)updateRecord:(NSObject<PersistenceRecordProtocol>*)record error:(NSError* __autoreleasing *)error;
//-(BOOL)updateRecord:(NSObject<PersistenceRecordProtocol>*)record  error:(NSError* __autoreleasing *)error;

-(BOOL)updateKeyValues:(NSDictionary*)keyValue primaryKeyValue:(NSNumber*)primaryValue error:(NSError* __autoreleasing *)error;

-(BOOL)updatekey:(NSString*)key value:(id)value primaryKeyValue:(NSNumber*)primaryValue error:(NSError* __autoreleasing *)error;

-(BOOL)updateKeyValues:(NSDictionary*)keyValue whereCondition:(NSString*)condition error:(NSError* __autoreleasing *)error;

@end
