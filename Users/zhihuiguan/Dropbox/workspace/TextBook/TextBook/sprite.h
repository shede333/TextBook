//
//  sprite.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-11-23.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defs.h"

@interface sprite : NSObject{
	uint type;						// type of our sprite
	
	CGFloat x;						// x location
	CGFloat y;						// y location
	CGFloat r;						// red tint
	CGFloat g;						// green tint
	CGFloat b;						// blue tint
	CGFloat alpha;					// alpha value, for transparency
	CGFloat speed;					// speed of movement in pixels/frame
	CGFloat angle;					// angle of movement in degrees
	CGFloat rotation;				// rotation of our sprite in degrees, about the center
	CGFloat width;					// width of sprite in pixels
	CGFloat height;					// height of sprite in pixels
	CGFloat scale;					// uniform scaling factor for size
	int frame;						// from 0 to (rows*cols - 1)
	
	CGFloat cosTheta;				// pre-computed for speed
	CGFloat sinTheta;
	CGRect box;						// our bounding box
	
	BOOL render;					// true when we're rendering
	BOOL offScreen;					// true when we're off the screen
	BOOL wrap;						// true if you want the motion to wrap on the screen
}

@property (assign) BOOL wrap, render, offScreen;
@property (assign) CGFloat x, y, r, g, b, alpha;
@property (assign) CGFloat speed, angle, rotation;
@property (assign) CGFloat width, height, scale;
@property (assign) CGRect box;
@property (assign) int frame;
@property (assign) uint type;

- (void)outlinePath:(CGContextRef)context;


@end
