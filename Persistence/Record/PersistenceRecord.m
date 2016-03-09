//
//  PersistenceRecord.m
//  Persistence
//
//  Created by tanhui on 16/3/7.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceRecord.h"
#import "objc/runtime.h"

@implementation PersistenceRecord

-(NSDictionary*)dictionaryRepresentionWithTable:(PersistenceTable<PersistenceTableProtocol>*)table{
    unsigned int outCount = 0;
    objc_property_t * propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary* propertyDic = [NSMutableDictionary dictionary];
    for (int i=0; i < outCount; i++) {
        objc_property_t property = propertyList[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:propertyName];
        if(!value){
            propertyDic[propertyName]=[NSNull null];
        }else{
            propertyDic[propertyName]=value;
        }
    }
    free(propertyList);
    NSMutableDictionary* representDic = [NSMutableDictionary dictionary];
    [table.columnDics enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (propertyDic[key]) {
            representDic[key]=propertyDic[key];
        }
    }];
    return representDic;
}

-(void)objectRepresentWithDictionary:(NSDictionary*)dictionary{
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self setPersistenceValue:obj withKey:key];
    }];
}

-(void)setPersistenceValue:(id)value withKey:(NSString*)key{
    NSString* setter = [NSString stringWithFormat:@"set%@%@:",[[key substringToIndex:1] capitalizedString],[key substringFromIndex:1]];
    if([self respondsToSelector:NSSelectorFromString(setter)]){
        if([value isKindOfClass:[NSNull class]]){
            [self setValue:nil forKey:key];
        }else{
            [self setValue:value forKey:key];
        }
    }
}

-(NSObject<PersistenceRecordProtocol>*)mergeRecord:(NSObject<PersistenceRecordProtocol>*)record shouldOverride:(BOOL)override{
    if ([self respondsToSelector:@selector(represntateKeyList)]) {
        NSArray* availableList = [self represntateKeyList];
        [availableList enumerateObjectsUsingBlock:^(NSString*  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([record respondsToSelector:NSSelectorFromString(name)]) {
                id value = [record valueForKey:name];
                if (override) {
                    [self setPersistenceValue:value withKey:name];
                }else{
                    if (![self valueForKey:name]) {
                        [self setPersistenceValue:value withKey:name];
                    }
                }
            }
        }];
    }
    return self;
}

@end
