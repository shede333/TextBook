//
//  LocationMonitor.h
//  LocationSW
//
//  Created by Zhihuiguan Zhihuiguan on 12-3-27.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol LocationMonitorDelegate <NSObject>

@required

- (void)LocationMonitorOverLayer:(CLRegion *)region;

@end


@interface LocationMonitor : NSObject<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (assign, nonatomic) id<LocationMonitorDelegate>delegate; 


- (void)startLocation;

@end
