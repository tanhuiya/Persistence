//
//  PersistenceTable+Insert.m
//  Persistence
//
//  Created by ci123 on 16/3/8.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceTable+Insert.h"
#import "PersistenceQueryCommand+DataOperations.h"

@implementation PersistenceTable (Insert)
-(BOOL)insertRecord:(NSObject<PersistenceRecordProtocol>*)record error:(NSError* __autoreleasing *)error{
    NSDictionary* recordDic = [record dictionaryRepresentionWithTable:self.child];
    PersistenceQueryCommand* command = [[PersistenceQueryCommand alloc]initWithDataBaseName:self.child.databaseName];
    [command insertDataList:@[recordDic] table:self.child.tableName];
    return [command executeWithError:error];
}

-(BOOL)insertRecordList:(NSArray<NSObject<PersistenceRecordProtocol>*>*)recordList error:(NSError* __autoreleasing *)error{
    NSMutableArray* recordDictArr = [NSMutableArray array];
    [recordList enumerateObjectsUsingBlock:^(NSObject<PersistenceRecordProtocol> * _Nonnull record, NSUInteger idx, BOOL * _Nonnull stop) {
        [recordDictArr addObject:[record dictionaryRepresentionWithTable:self.child]];
    }];
    PersistenceQueryCommand* command = [[PersistenceQueryCommand alloc]initWithDataBaseName:self.child.databaseName];
    [command insertDataList:recordDictArr table:self.child.tableName];
    return [command executeWithError:error];
}
@end
