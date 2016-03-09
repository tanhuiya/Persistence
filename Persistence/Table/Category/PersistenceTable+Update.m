//
//  PersistenceTable+Update.m
//  Persistence
//
//  Created by ci123 on 16/3/9.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceTable+Update.h"
#import "PersistenceQueryCommand+DataOperations.h"

@implementation PersistenceTable (Update)
-(BOOL)updateRecord:(NSObject<PersistenceRecordProtocol>*)record error:(NSError* __autoreleasing *)error{
    NSDictionary* updateDic = [record dictionaryRepresentionWithTable:self.child.tableName];
    return [self updateKeyValues:updateDic primaryKeyValue:[record valueForKey:[self.child primaryKeyName]] error:error];
}
-(BOOL)updateKeyValues:(NSDictionary*)keyValue primaryKeyValue:(NSNumber*)primaryValue error:(NSError* __autoreleasing *)error{
    
    NSString* whereCondition = [NSString stringWithFormat:@"%@=%@",self.child.primaryKeyName,primaryValue];
    return [self updateKeyValues:keyValue whereCondition:whereCondition error:error];
}

-(BOOL)updatekey:(NSString*)key value:(id)value primaryKeyValue:(NSNumber*)primaryValue error:(NSError* __autoreleasing *)error{
    return  [self updateKeyValues:@{key:value} primaryKeyValue:primaryValue error:error];
}

-(BOOL)updateKeyValues:(NSDictionary*)keyValue whereCondition:(NSString*)condition error:(NSError* __autoreleasing *)error{
    PersistenceQueryCommand* command = [[PersistenceQueryCommand alloc]initWithDataBaseName:self.child.databaseName];
   return [command updateWithDataList:keyValue condition:condition table:self.child.tableName];
}
@end
