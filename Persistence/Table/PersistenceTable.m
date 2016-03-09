//
//  PersistenceTable.m
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import "PersistenceTable.h"
#import "PersistenceQueryCommand.h"
#import "PersistenceQueryCommand+SchemaOperations.h"

@interface PersistenceTable ()
@property(nonatomic,strong)PersistenceTable<PersistenceTableProtocol>* child;
@end

@implementation PersistenceTable
- (instancetype)init
{
    self = [super init];
    if (self&&[self conformsToProtocol:@protocol(PersistenceTableProtocol)]) {
        if(self&&[self conformsToProtocol:@protocol(PersistenceTableProtocol)]){
            self.child = (PersistenceTable<PersistenceTableProtocol>*)self;
            NSError* error = nil;
            PersistenceQueryCommand * command = [[PersistenceQueryCommand alloc]initWithDataBaseName:self.child.databaseName];
            [[command createTable:self.child.tableName columDics:self.child.columnDics] executeWithError:&error];
            if(error){
                NSLog(@"%@",error);
            }
        }
    }else{
        NSException* exception = [NSException exceptionWithName:@"PersistentTable init error" reason:@"the child must conforms to PersistenceTableProtocol" userInfo:nil];
        @throw exception;
    }
    return self;
}

-(BOOL)executeSQL:(NSString*)sql withError:(NSError* __autoreleasing*)error{
    PersistenceQueryCommand* command = [[PersistenceQueryCommand alloc]initWithDataBaseName:self.child.databaseName];
    [command.sqlString appendString:sql];
    return [command executeWithError:error];
}

-(NSArray*)fetchDataWithSQL:(NSString*)sql withError:(NSError* __autoreleasing*)error{
    PersistenceQueryCommand* command = [[PersistenceQueryCommand alloc]initWithDataBaseName:self.child.databaseName];
    [command.sqlString appendString:sql];
    return [command fetchWithError:error];
    
}
@end
