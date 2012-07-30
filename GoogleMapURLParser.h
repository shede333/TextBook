//
//  GoogleMapURLParser.h
//  mapTest
//
//  Created by Zhihuiguan Zhihuiguan on 12-3-8.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#define GM_BASE_URL @"http://maps.googleapis.com/maps/api/directions/json?"
#define GM_BASE_URL_SAFE @"https://maps.googleapis.com/maps/api/directions/json?"

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "math.h"
#import "SubAnnotation.h"
#import <MapKit/MapKit.h>



@interface GoogleMapURLParser : NSObject






+ (id) getDataInJsonWithURL:(NSString *)URL ;



//网络链接、获取数据
+ (void)showAlert:(NSString *)message;
+ (NSString *)creatURLWithSafe:(BOOL)isSafe 
                     andOrigin:(NSString *)origin 
                andDestination:(NSString *)destination 
                       andMode:(NSString *)mode 
               andAlternatives:(NSString *)alternatives 
                      andUnits:(NSString *)units 
                     andRegion:(NSString *)region 
                   andLanguage:(NSString *)language 
                     andSensor:(NSString *)sensor;
+ (id) getDataInJsonWithURL:(NSString *)URL ;
+ (NSString *)getStatus:(NSDictionary *)dic;

//routes-各个状态
+ (NSString *)getRoutesValue:(NSDictionary *)dic andKey:(NSString *)key andIndex:(int)index;
+ (NSDictionary *)getRoutesBounds:(NSDictionary *)dic andIndex:(int)index;
+ (NSArray *)getRoutesArr:(NSDictionary *)dic andKey:(NSString *)key andIndex:(int)index;

//legs各个字段信息
+ (NSDictionary *)getLegsDic:(NSDictionary *)dic andKey:(NSString *)key andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes;
+ (NSString *)getLegsString:(NSDictionary *)dic andKey:(NSString *)key andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes;
+ (NSArray *)getLegsStep:(NSDictionary *)dic andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes;

//用于绘制地图路线的数据
+ (MKPolyline *)getPolyline:(NSDictionary *)dic andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes;
+ (SubAnnotation *)getSubAnnotation:(NSDictionary *)subDic andKey:(NSString *)key;
+ (NSArray *)getAnnotation:(NSDictionary *)dic andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes;
+ (MKMapRect)getVisibleMapRect:(NSDictionary *)dic andIndexOfLegs:(int)indexOfLegs andIndexOfRoutes:(int)indexOfRoutes;

//用于OurCity的接口

+ (id)OCGetPathFrom:(NSString *)coordianteOfFrom andTO:(NSString *)coordianteOfTo;
+ (MKMapRect)OCGetVisibleMapRect:(NSDictionary *)dic;
+ (NSArray *)OCTEst:(NSDictionary *)dic;

//+(GoogleMapURLParser *)shareParser;

@end
