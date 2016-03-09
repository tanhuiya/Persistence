//
//  TestRecordCase.m
//  Persistence
//
//  Created by tanhui on 16/3/7.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "TestRecordCase.h"
#import "TestRecord01.h"
#import "MyTable01.h"
#import "PersistenceTable.h"
#import "PersistenceTable+Insert.h"

@implementation TestRecordCase
-(void)test{
    TestRecord01* record01 = [[TestRecord01 alloc]init];
    record01.sex = @(0);
    record01.name = @"tanhui";
    
    TestRecord01* record02 = [[TestRecord01 alloc]init];
    record02.cid = @101;
    
    record01=(TestRecord01*)[record01 mergeRecord:record02 shouldOverride:YES];
    NSLog(@"%@",record01);
    NSError* error = nil;
    MyTable01* table = [[MyTable01 alloc]init];
    
    [table insertRecord:record01 error:&error];
    if(error){
        NSLog(@"%@",error);
    }
}
@end
