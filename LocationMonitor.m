//
//  LocationMonitor.m
//  LocationSW
//
//  Created by Zhihuiguan Zhihuiguan on 12-3-27.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//


//31.279835,120.66473  高村

#import "LocationMonitor.h"



@interface LocationMonitor()

- (void)availableOfRegionMonitor;
- (void)startMonitorRegion;
- (void)addMonitorOverLayer;

@end

@implementation LocationMonitor
@synthesize delegate;


- (id)init {
    self = [super init];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
    }
    return self;
}


- (void)dealloc {
    [self setDelegate:nil];
    [locationManager setDelegate:nil];
    [locationManager release];
    [super dealloc];
}

#pragma mark - 私有方法

//入口-important
- (void)startLocation{
    [self availableOfRegionMonitor];
   
}

- (void)availableOfRegionMonitor{
    if (![CLLocationManager regionMonitoringAvailable]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您的设备不支持定位服务"
                                                        message:@"您将不能使用自动签到功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您禁止了定位服务"
                                                        message:@"将不能使用自动签到功能！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }else if(! [CLLocationManager regionMonitoringEnabled]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您关闭了定位服务"
                                                        message:@"将不能使用自动签到功能！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }else{
        locationManager.distanceFilter = 30;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [self startMonitorRegion];
    }
}

- (void)startMonitorRegion{
    CLRegion *region = [[CLRegion alloc] 
                        initCircularRegionWithCenter:kZHGCoordinate radius:800 identifier:@"zhihuiguan"];
    [locationManager startMonitoringForRegion:region desiredAccuracy:100];
    [region release];
    
    region = [[CLRegion alloc] 
                        initCircularRegionWithCenter:kYXCCoordinate radius:800 identifier:@"yinxiangcheng"];
    [locationManager startMonitoringForRegion:region desiredAccuracy:100];
    [region release];
    
    [self addMonitorOverLayer];
    
   
    
}

//- (void)test{
//    CLLocationCoordinate2D cc = locationManager.location.coordinate;
//    NSLog(@"sw-2- la:%lf,lon:%lf\n",cc.latitude,cc.longitude);
//}

- (void)addMonitorOverLayer{
    NSArray *arr = [[locationManager monitoredRegions] allObjects];
    for (CLRegion *region in arr) {
        [delegate performSelector:@selector(LocationMonitorOverLayer:) withObject:region];
    }
}


#pragma mark - CLLocation - Delegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    [MobClick event:UM_LOCATION_ENTER];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"高村，请截图"
                                                    message:@"Test-success"
                                                   delegate:nil
                                          cancelButtonTitle:@"确认"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    [MobClick event:UM_LOCATION_EXIT];
}

- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error{
    [MobClick event:UM_LOCATION_MONITOR_FAIL];
    NSLog(@"sw-2-error %@\n",error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"检测区域错误"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"确认"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

@end
