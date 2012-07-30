//
//  SubAnnotation.h
//  MapTest
//
//  Created by Zhihuiguan Zhihuiguan on 12-3-3.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SubAnnotation: NSObject<MKAnnotation> 


@property (nonatomic,assign) CLLocationCoordinate2D coordinateSub;
@property (nonatomic,retain) NSString *upTitle;
@property (nonatomic,retain) NSString *downTitle;
@property (nonatomic,assign) int annotationType; //1代表起点，2代表终点
//@property (nonatomic,assign) float 





//// Center latitude and longitude of the annotion view.
//// The implementation of this property must be KVO compliant.
//@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
//
////@optional
//
//// Title and subtitle for use by selection UI.
//@property (nonatomic, readonly, copy) NSString *title;
//@property (nonatomic, readonly, copy) NSString *subtitle;
//
//// Called as a result of dragging an annotation view.
//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate NS_AVAILABLE(NA, 4_0);

@end
