//
//  SubAnnotation.m
//  MapTest
//
//  Created by Zhihuiguan Zhihuiguan on 12-3-3.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "SubAnnotation.h"

@implementation SubAnnotation
@synthesize coordinateSub;
@synthesize upTitle;
@synthesize downTitle;
@synthesize annotationType;


//  返回该位置信息
- (CLLocationCoordinate2D)coordinate;
{
    return coordinateSub; 
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
// 返回　上半部信息
- (NSString *)title
{
	return upTitle;
}

// optional
// 返回　下半部信息
- (NSString *)subtitle
{
	return downTitle;
}

// Called as a result of dragging an annotation view.
//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate

- (void)dealloc
{
	[upTitle release];
	[downTitle release];
    [super dealloc];
}



@end
