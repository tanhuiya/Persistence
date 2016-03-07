//
//  main.m
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "testObject.h"
#import "TestRecordCase.h"

int main(int argc, char * argv[]) {
    testObject* test1 = [[testObject alloc]init];
    [test1 test];
    
    TestRecordCase * recordcase = [[TestRecordCase alloc]init];
    [recordcase test];
//    @autoreleasepool {
//        
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
}
