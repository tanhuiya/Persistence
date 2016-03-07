//
//  TestRecord01.h
//  Persistence
//
//  Created by tanhui on 16/3/7.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceRecord.h"

@interface TestRecord01 : PersistenceRecord
@property(strong,nonatomic)NSNumber* cid;
@property(strong,nonatomic)NSString* name;
@property(strong,nonatomic)NSNumber* sex;

@property(strong,nonatomic)NSString* password;
@property(strong,nonatomic)NSString* username;
@end
