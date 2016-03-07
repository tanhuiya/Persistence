//
//  PersistenceTable.h
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersistenceTableProtocol <NSObject>

@required
-(NSString*)databaseName;
-(NSString*)tableName;
-(NSDictionary*)columnDics;
-(Class)recordClass;
-(NSString*)primaryKeyName;
@end


@interface PersistenceTable: NSObject

@property(nonatomic,readonly,strong)PersistenceTable<PersistenceTableProtocol>* child;

-(BOOL)executeSQL:(NSString*)sql withError:(NSError* __autoreleasing*)error;

-(NSArray*)fetchDataWithSQL:(NSString*)sql withError:(NSError* __autoreleasing*)error;

@end
