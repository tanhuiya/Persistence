//
//  PersistenceQueryCommand+DataOperations.h
//  Persistence
//
//  Created by ci123 on 16/3/8.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceQueryCommand.h"

@interface PersistenceQueryCommand (DataOperations)
-(PersistenceQueryCommand*)insertDataList:(NSArray*)dataList table:(NSString*)tablename;

-(PersistenceQueryCommand*)updateWithDataList:(NSDictionary*)dataDict condition:(NSString*)condition table:(NSString*)tableName;
@end
