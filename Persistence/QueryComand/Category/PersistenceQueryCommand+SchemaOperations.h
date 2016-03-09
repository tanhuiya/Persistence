//
//  PersistenceQueryCommand+SchemaOperations.h
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceQueryCommand.h"

@interface PersistenceQueryCommand (SchemaOperations)
-(PersistenceQueryCommand*)createTable:(NSString*)tableName columDics:(NSDictionary*)colums;
-(PersistenceQueryCommand*)addColumn:(NSString*)columnName columnDes:(NSString*)colomnDes table:(NSString*)tableName;
@end
