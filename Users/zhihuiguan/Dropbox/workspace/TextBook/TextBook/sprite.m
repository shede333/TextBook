//
//  sprite.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-11-23.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "sprite.h"


@implementation sprite
@synthesize x,y,speed,angle,width,height,scale,frame,box,rotation,wrap,render,type;
@synthesize r,g,b,alpha,offScreen;

- (id)init{
    self = [super init];
    if (self) {
        wrap = NO;
		x = y = 0.0;
		width = height = 1.0;
		scale = 1.0;
		speed = 0.0;
		angle = 0.0;
		rotation = 0;
		cosTheta = 1.0;
		sinTheta = 0.0;
		r = 1.0;
		g = 1.0;
		b = 1.0;
		alpha = 1.0;
		offScreen = NO;
		box = CGRectMake(0,0,0,0);
		frame = 0;
		render = YES;
		type = kSpriteType;
    }
    return self;
}

- (void)outlinePath:(CGContextRef)context{
    CGFloat w2 = box.size.width/2;
    CGFloat h2 = box.size.height/2;
    
    CGContextBeginPath(context);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextMoveToPoint(context, -w2, h2);
    CGContextAddLineToPoint(context, w2, -h2);
	CGContextAddLineToPoint(context, w2, -h2);
	CGContextAddLineToPoint(context, -w2, -h2);
	CGContextAddLineToPoint(context, -w2, h2);
    CGContextClosePath(context);
}

- (void)drowBody:(CGContextRef)context{
    CGContextSetRGBFillColor(context, r,g,b,alpha);
    [self outlinePath:context];
    CGContextDrawPath(context, kCGPathFill);
}

- (void)drow:(CGContextRef)context{
    CGContextSaveGState(context);
    CGAffineTransform t = CGAffineTransformIdentity;
//    UIDeviceOrientation *device = [[UIDevice currentDevice] orientation];
//    if (device == UIInterfaceOrientationLandscapeLeft) {
//        
//    }
//    
//    if (device == UIInterfaceOrientationLandscapeRight) {
//        
//    }
    
}


















@end
