//
//  PersistenceQueryCommand+DataOperations.m
//  Persistence
//
//  Created by ci123 on 16/3/8.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceQueryCommand+DataOperations.h"

@implementation PersistenceQueryCommand (DataOperations)
-(PersistenceQueryCommand*)insertDataList:(NSArray*)dataList table:(NSString*)tablename{
    if (!tablename) {
        return nil;
    }
    NSMutableArray* valueStringList = [NSMutableArray array];
    __block NSString* keyString = nil;
    [dataList enumerateObjectsUsingBlock:^(NSDictionary*  dataDic, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray* columnList = [NSMutableArray array];
        NSMutableArray* valueList = [NSMutableArray array];
       [dataDic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
           [columnList addObject:key];
           if([value isKindOfClass:[NSNull class]]){
               [valueList addObject:@"''"];
           }else{
               [valueList addObject:[NSString stringWithFormat:@"'%@'",value]];
           }
       }];
        if (keyString==nil) {
            keyString = [columnList componentsJoinedByString:@","];
        }
        [valueStringList addObject:[NSString stringWithFormat:@"(%@)",[valueList componentsJoinedByString:@","]]];
    }];
    [self.sqlString appendFormat:@"INSERT INTO %@ (%@) VALUES %@",tablename,keyString,[valueStringList componentsJoinedByString:@","]];
    return self;
}

-(PersistenceQueryCommand*)updateWithDataList:(NSDictionary*)dataDict condition:(NSString*)condition table:(NSString*)tableName{
    if (!tableName) {
        return nil;
    }
    NSMutableArray * updataArray = [NSMutableArray array];
    [dataDict enumerateKeysAndObjectsUsingBlock:^(NSString* key, id   value, BOOL * _Nonnull stop) {
        if([value isKindOfClass:[NSNull class]]){
            [updataArray addObject:[NSString stringWithFormat:@"%@=''",key]];
        }else{
            [updataArray addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
        }
    }];
    [self.sqlString appendFormat:@"UPDATE %@ SET %@ %@",tableName,[updataArray componentsJoinedByString:@","],condition];
    return self;
}
@end
