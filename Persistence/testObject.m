//
//  testObject.m
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "testObject.h"
#import "MyTable01.h"
#import "PersistenceQueryCommand+SchemaOperations.h"

@implementation testObject
-(void)test{
    MyTable01* table1 = [[MyTable01 alloc]init];
    NSError* error = nil;
    PersistenceQueryCommand* command = [[PersistenceQueryCommand alloc]initWithDataBaseName:table1.databaseName];
    [[command addColumn:@"username" columnDes:@"text" table:table1.tableName] executeWithError:&error];
    if(error){
        NSLog(@"%@",error);
    }
}
@end
