//
//  MyTable01.m
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "MyTable01.h"
#import "TestRecord01.h"

@implementation MyTable01
-(NSString*)databaseName{
    return @"jyb";
}
-(NSString*)tableName{
    return @"myinfo";
}
-(NSDictionary*)columnDics{
    return @{
        @"cid":@"INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL",
        @"name":@"text",
        @"sex":@"int",
             };
}
-(Class)recordClass{
    return [TestRecord01 class];
}
-(NSString*)primaryKeyName{
    return @"cid";
}
@end
