//
//  PersistenceRecord.h
//  Persistence
//
//  Created by tanhui on 16/3/7.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersistenceTable.h"

@protocol PersistenceRecordProtocol <NSObject>

@required
-(NSDictionary*)dictionaryRepresentionWithTable:(PersistenceTable<PersistenceTableProtocol>*)table;

-(void)objectRepresentWithDictionary:(NSDictionary*)dictionary;

-(NSObject<PersistenceRecordProtocol>*)mergeRecord:(NSObject<PersistenceRecordProtocol>*)record shouldOverride:(BOOL)override;
@optional

-(NSArray*)represntateKeyList;

@end

@interface PersistenceRecord : NSObject<PersistenceRecordProtocol>

@end
