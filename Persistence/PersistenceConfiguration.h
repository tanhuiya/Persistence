//
//  PersistenceConfiguration.h
//  Persistence
//
//  Created by tanhui on 16/3/6.
//  Copyright © 2016年 tanhui. All rights reserved.
//

#ifndef PersistenceConfiguration_h
#define PersistenceConfiguration_h

#import <Foundation/Foundation.h>
static NSString * PersistenceErrorDomain = @"PersistenceErrorDomain";

typedef NS_ENUM(NSUInteger,PersistentceErrorCode){
    /**
     *  failed to open database file
     */
    PersistanceErrorCodeOpenError,
    /**
     *  failed to create database file
     */
    PersistanceErrorCodeCreateError,
    /**
     *  failed to execute SQL
     */
    PersistanceErrorCodeQueryStringError,
    /**
     *  record is not available to INSERT
     */
    PersistanceErrorCodeRecordNotAvailableToInsert,
    /**
     *  record is not available to UPDATE
     */
    PersistanceErrorCodeRecordNotAvailableToUpdate,
    /**
     *  failed to set key for value in record
     */
    PersistanceErrorCodeFailedToSetKeyForValue,
};

#endif /* PersistenceConfiguration_h */
