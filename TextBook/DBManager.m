//
//  DBManager.m
//  MonsterHunt
//
//  Created by zhiguihuan on 11-9-15.
//  Copyright 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "DBManager.h"


static sqlite3 * databaseInstanceOfChatData = nil;
static sqlite3 * databaseInstanceOfMonsterInfo = nil;
//static NSCondition *condition = nil;

@implementation DBManager



//聊天的数据库实例化
+ (sqlite3 *) getChatDBInstance{ 
//    if (condition == nil) {
//        condition = [[[NSCondition alloc] init] autorelease];
//    }
    if (databaseInstanceOfChatData != nil) {
        return databaseInstanceOfChatData;
    }else{
        NSString *dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MonsterChat.sqlite"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL find = [fileManager fileExistsAtPath:dbPath];
        
        if (find == NO) {
            return nil;
        }
        
        int result = sqlite3_open([dbPath UTF8String], &databaseInstanceOfChatData);
        if (result != SQLITE_OK) {
            sqlite3_close(databaseInstanceOfChatData);
            return nil;
        }
        NSLog(@"打开数据库-成功\n");
    
        
        return databaseInstanceOfChatData;
    }
}

//关闭聊天数据库
+ (void) closeChatDBInstance{
    if (databaseInstanceOfChatData != nil) {
        sqlite3_close(databaseInstanceOfChatData);
        databaseInstanceOfChatData = nil;
        
//        if (condition) {
//            [condition release];
//            condition = nil;
//        }
    }
}


#pragma mark - 获取地址
// 收货人信息 省
+ (NSMutableDictionary *) getReceiverProvDataSource{
    
    NSString *sql = [NSString stringWithFormat:
                     @"select city_id,city_name from address_province_city where province_id = '0'  order by city_id"];
    NSLog(@"省-sql:%@\n",sql);
    sqlite3 *db = [DBManager getChatDBInstance];
    
    sqlite3_stmt *stmt;
    // 查询
    NSMutableDictionary *dicAddressProv = [[[NSMutableDictionary alloc] initWithCapacity:40] autorelease];
    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    NSMutableArray *dicArray = [[[NSMutableArray alloc] initWithCapacity:50] autorelease];
    
    if (success == SQLITE_OK) {
        NSLog(@"读取数据成功\n");
        // 遍历
        while(sqlite3_step(stmt) == SQLITE_ROW){
            NSString *code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
            NSString *value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            [dicAddressProv setObject:code forKey:value];
            //            [arrReceiverProvCode addObject:code];
        }
    }
    
    // 释放
    sqlite3_finalize(stmt);
    
    return dicAddressProv;
}

// 收货人 城市
+ (NSMutableDictionary *) getReceiverCityDataSourceWithProvCode:(NSString *)provCode{
    NSString *sql = [NSString stringWithFormat:
                     @"select city_id,city_name from address_province_city where province_id = '%@' order by city_id", provCode];
    NSLog(@"市-sql:%@\n",sql);
    sqlite3 *db = [DBManager getChatDBInstance];
    
    sqlite3_stmt *stmt;
    // 查询
    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    if (success != SQLITE_OK) {
        return nil;
    }
    
    NSMutableDictionary *dicAddressCity = [[[NSMutableDictionary alloc] initWithCapacity:20] autorelease];
    // 遍历
    while(sqlite3_step(stmt) == SQLITE_ROW){
        
        NSString *code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
        NSString *value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
        
        [dicAddressCity setObject:code forKey:value];
        //        [arrReceiverCityCode addObjectbv:code];
        
    }
    // 释放
    sqlite3_finalize(stmt);
    
    return dicAddressCity;
}

// 收货人 区
+ (NSMutableDictionary *) getReceiverZoneDataSourceWithCityCode:(NSString *)cityCode{
    NSString *sql = [NSString stringWithFormat:
                     @"select zone_id,zone_name from address_zone where city_id = '%@' order by zone_id", cityCode];
    NSLog(@"区-sql:%@\n",sql);
    sqlite3 *db = [DBManager getChatDBInstance];
    sqlite3_stmt *stmt;
    // 查询
    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    if (success != SQLITE_OK) {
        return nil;
    }
    
    
    NSMutableDictionary *dicAddressZone = [[[NSMutableDictionary alloc] initWithCapacity:50] autorelease];
    // 遍历
    while(sqlite3_step(stmt) == SQLITE_ROW){
        
        NSString *code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
        NSString *value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
        
        [dicAddressZone setObject:code forKey:value];
    }
    // 释放
    sqlite3_finalize(stmt);
//    NSLog(@"arrReceiverZone:%@\n",arrReceiverZone);
    return dicAddressZone;
}

#pragma mark - new-省市区
//省-资料
+ (NSMutableArray *) getProvince{
    NSString *sql = [NSString stringWithFormat:
                     @"select ProName,ProSort from T_Province "];
    NSLog(@"区-sql:%@\n",sql);
    sqlite3 *db = [DBManager getChatDBInstance];
    sqlite3_stmt *stmt;
    // 查询
    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    if (success != SQLITE_OK) {
        return nil;
    }
    
    NSMutableArray *dbArrPro_Name = [[NSMutableArray alloc] initWithCapacity:40];
    NSMutableArray *dbArrPro_Sort = [[NSMutableArray alloc] initWithCapacity:40];
    
    
    // 遍历
    while(sqlite3_step(stmt) == SQLITE_ROW){
        
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
        NSString *sort = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
        
        [dbArrPro_Name addObject:name];
        [dbArrPro_Sort addObject:sort];
    }
    NSMutableArray *dbArrPro = [[[NSMutableArray alloc] initWithObjects:dbArrPro_Name,dbArrPro_Sort, nil] autorelease];
    [dbArrPro_Sort release];
    [dbArrPro_Name release];
    
    // 释放
    sqlite3_finalize(stmt);
    //    NSLog(@"arrReceiverZone:%@\n",arrReceiverZone);
    return dbArrPro;
}

//市-资料
+ (NSArray *) getCityWithProvinceID:(NSString *)parentAddressID{
    NSString *sql = [NSString stringWithFormat:
                     @"select CityName,CitySort from T_City where ProID = '%@'",parentAddressID];
    NSLog(@"区-sql:%@\n",sql);
    sqlite3 *db = [DBManager getChatDBInstance];
    sqlite3_stmt *stmt;
    // 查询
    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    if (success != SQLITE_OK) {
        return nil;
    }
    
    NSMutableArray *dbArrCity_Name_Tmp = [[NSMutableArray alloc] initWithCapacity:20];

    
    
    // 遍历
    while(sqlite3_step(stmt) == SQLITE_ROW){
        
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
//        NSString *sort = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
        
        [dbArrCity_Name_Tmp addObject:name];
       
    }
    NSArray *dbArrCity = [[[NSMutableArray alloc] initWithObjects:@"", nil] autorelease];


    
    // 释放
    sqlite3_finalize(stmt);
    //    NSLog(@"arrReceiverZone:%@\n",arrReceiverZone);
    return dbArrCity;
}

//区-资料
+ (NSArray *) getZoneWithCityID:(NSString *)parentAddressID{
    NSString *sql = [NSString stringWithFormat:
                     @"select ZoneName from T_Zone where CityID = '%@'",parentAddressID];
    NSLog(@"区-sql:%@\n",sql);
    sqlite3 *db = [DBManager getChatDBInstance];
    sqlite3_stmt *stmt;
    // 查询
    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    if (success != SQLITE_OK) {
        return nil;
    }
    
   NSMutableArray *dbArrZoneTmp = [[NSMutableArray alloc] initWithCapacity:20];
 
    // 遍历
    while(sqlite3_step(stmt) == SQLITE_ROW){
        
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];

        [dbArrZoneTmp addObject:name];
    }
    
    NSArray *dbArrZone = [[[NSArray alloc] initWithArray:
                           [dbArrZone sortedArrayUsingSelector:
                            @selector(localizedCaseInsensitiveCompare:)]] autorelease];
    [dbArrZoneTmp release];
    
    // 释放
    sqlite3_finalize(stmt);
    //    NSLog(@"arrReceiverZone:%@\n",arrReceiverZone);
    return dbArrZone;
}

// type:0 获取 省 资料
// type:1 获取 市 资料
// type:2 获取 区 资料
+ (NSMutableArray *) getAddressType:(NSInteger)type andSort:(NSString *)parentAddressID{
    NSString *sql;
    switch (type) {
        case 0:
            sql = [NSString stringWithFormat:
                             @"select ProName,ProSort from T_Province "];
            break;
        case 1:
            sql = [NSString stringWithFormat:
                             @"select CityName,CityID from T_City where ProID = '%@'",parentAddressID];
            break;
        case 2:
            sql = [NSString stringWithFormat:
                             @"select ZoneName,ZoneID from T_Zone where CityID = '%@'",parentAddressID];
            break;
            
        default:
            return nil;
            break;
    }

    NSLog(@"区-sql:%@\n",sql);
    sqlite3 *db = [DBManager getChatDBInstance];
    sqlite3_stmt *stmt;
    // 查询
    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    if (success != SQLITE_OK) {
        return nil;
    }
    
    NSMutableArray *dbArrPro_Name = [[NSMutableArray alloc] initWithCapacity:40];
    NSMutableArray *dbArrPro_Sort = [[NSMutableArray alloc] initWithCapacity:40];
    
    
    // 遍历
    while(sqlite3_step(stmt) == SQLITE_ROW){
        
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
        NSString *sort = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
        
        [dbArrPro_Name addObject:name];
        [dbArrPro_Sort addObject:sort];
    }
    NSMutableArray *dbArrPro = [[[NSMutableArray alloc] initWithObjects:dbArrPro_Name,dbArrPro_Sort, nil] autorelease];
    [dbArrPro_Sort release];
    [dbArrPro_Name release];
    
    // 释放
    sqlite3_finalize(stmt);
    //    NSLog(@"arrReceiverZone:%@\n",arrReceiverZone);
    return dbArrPro;
}

//// 收货人信息 省
//+ (NSMutableArray *) getReceiverProvDataSource{
//    
//    NSString *sql = [NSString stringWithFormat:@"select value, code, parentCode from t_basedata where type = 'PLACE' and level = '21' order by id"];
//    sqlite3 *db = [DBManager getChatDBInstance];
//    
//    sqlite3_stmt *stmt;
//    // 查询
//    NSMutableArray *arrReceiverProv = [[[NSMutableArray alloc] initWithCapacity:50] autorelease];
//    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    NSMutableArray *dicArray = [[[NSMutableArray alloc] initWithCapacity:50] autorelease];
//    
//    if (success == SQLITE_OK) {
//        NSLog(@"读取数据成功\n");
//        // 遍历
//        while(sqlite3_step(stmt) == SQLITE_ROW){
//            NSString *value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
////            NSString *code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
//            [arrReceiverProv addObject:value];
////            [arrReceiverProvCode addObject:code];
//        }
//    }
//    
//        
//        
//    // 释放
//    sqlite3_finalize(stmt);
//    
//    return arrReceiverProv;
//}
//
//// 收货人 城市
//+ (NSMutableArray *) getReceiverCityDataSourceWithProvCode:(NSString *)provCode{
//    NSString *sql = [NSString stringWithFormat:@"select value, code from t_basedata where type = 'PLACE' and level = '22' and parentCode = '%@' order by id", provCode];
//    sqlite3 *db = [DBManager getChatDBInstance];
//    
//    sqlite3_stmt *stmt;
//    // 查询
//    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    
//    if (success != SQLITE_OK) {
//        return nil;
//    }
//    
//    NSMutableArray *arrReceiverCity = [[[NSMutableArray alloc] initWithCapacity:50] autorelease];
//    // 遍历
//    while(sqlite3_step(stmt) == SQLITE_ROW){
//        
//        NSString *value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
//        NSString *code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
//        
//        [arrReceiverCity addObject:value];
////        [arrReceiverCityCode addObjectbv:code];
//        
//    }
//    // 释放
//    sqlite3_finalize(stmt);
//    
//    return arrReceiverCity;
//}
//
//// 收货人 区
//+ (NSMutableArray *) getReceiverZoneDataSourceWithCityCode:(NSString *)cityCode{
//    NSString *sql = [NSString stringWithFormat:@"select value, code, parentCode from t_basedata where type = 'PLACE' and level = '23' and parentCode = '%@' order by id", cityCode];
//    NSLog(@"区-sql:%@\n",sql);
//    sqlite3 *db = [DBManager getChatDBInstance];
//    sqlite3_stmt *stmt;
//    // 查询
//    int success = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    
//    if (success != SQLITE_OK) {
//        return nil;
//    }
//    
//
//    NSMutableArray *arrReceiverZone = [[[NSMutableArray alloc] initWithCapacity:50] autorelease];
//    // 遍历
//    while(sqlite3_step(stmt) == SQLITE_ROW){
//        
//        NSString *value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 0)];
////        NSString *code = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
//        
//        [arrReceiverZone addObject:value];
////        [arrReceiverZoneCode addObject:code];
//    }
//    // 释放
//    sqlite3_finalize(stmt);
//    NSLog(@"arrReceiverZone:%@\n",arrReceiverZone);
//    return arrReceiverZone;
//}



@end
