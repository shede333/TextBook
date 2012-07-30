//
//  DBManager.h
//  MonsterHunt
//
//  Created by zhiguihuan on 11-9-15.
//  Copyright 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DBManager : NSObject {
    
}
//-------------------------------------------
// 聊天相关数据
//-------------------------------------------
//聊天的数据库实例化
+ (sqlite3 *) getChatDBInstance;

//关闭聊天数据库
+ (void) closeChatDBInstance;

// 收货人信息-省
+ (NSMutableDictionary *) getReceiverProvDataSource;

// 收货人-城市
+ (NSMutableDictionary *) getReceiverCityDataSourceWithProvCode:(NSString *)provCode;

// 收货人 区
+ (NSMutableDictionary *) getReceiverZoneDataSourceWithCityCode:(NSString *)cityCode;

+ (NSArray *) getProvince;

+ (NSArray *) getCityWithProvinceID:(NSString *)parentAddressID;

+ (NSArray *) getZoneWithCityID:(NSString *)parentAddressID;

+ (NSMutableArray *) getAddressType:(NSInteger)type andSort:(NSString *)parentAddressID;

@end
