//
//  PersistenceQueryCommand+SchemaOperations.m
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceQueryCommand+SchemaOperations.h"

@implementation PersistenceQueryCommand (SchemaOperations)
-(PersistenceQueryCommand*)createTable:(NSString*)tableName columDics:(NSDictionary*)colums{
    [self resetQueryCommand];
    if (!tableName.length) {
        return nil;
    }
    NSMutableArray* columnList = [NSMutableArray array];
    [colums enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull columnName, NSString*  _Nonnull columnDes, BOOL * _Nonnull stop) {
        if (!columnDes||!columnDes.length) {
            [columnList addObject:[NSString stringWithFormat:@"%@",columnName]];
        }else{
            [columnList addObject:[NSString stringWithFormat:@"%@ %@",columnName,columnDes]];
        }
    }];
    NSString* columnStr = [columnList componentsJoinedByString:@","];
    [self.sqlString appendFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@)",tableName,columnStr];
    return self;
}
-(PersistenceQueryCommand*)addColumn:(NSString*)columnName columnDes:(NSString*)colomnDes table:(NSString*)tableName{
    [self resetQueryCommand];
    if (!tableName.length) {
        return nil;
    }
    [self.sqlString appendFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@",tableName,columnName,colomnDes];
    return self;
}
@end
