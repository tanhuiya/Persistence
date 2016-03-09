//
//  PersistenceTable+Insert.h
//  Persistence
//
//  Created by ci123 on 16/3/8.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceTable.h"
#import "PersistenceRecord.h"

@interface PersistenceTable (Insert)
-(BOOL)insertRecord:(NSObject<PersistenceRecordProtocol>*)record error:(NSError* __autoreleasing *)error;

-(BOOL)insertRecordList:(NSArray<NSObject<PersistenceRecordProtocol>*>*)recordList error:(NSError* __autoreleasing *)error;
@end
