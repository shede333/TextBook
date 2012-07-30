//
//  BiaoQingView.m
//  TextBook
//
//  Created by shaowei on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "BiaoQingView.h"

static float kScrollViewBottomHeight = 0.0f; //


@implementation BiaoQingView

- (id)initWithFrame:(CGRect)frame andScreenNum:(int)screenNum{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self setPagingEnabled:YES];
    [self setBackgroundColor:[UIColor blueColor]];
    
    float subHeight = frame.size.height - kScrollViewBottomHeight;
    
    self.contentSize = CGSizeMake(320 * screenNum,
                                  subHeight);
    
    [self setBackgroundColor:[UIColor blackColor]];
	[self setCanCancelContentTouches:NO];
	self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	self.clipsToBounds = YES;		// default is NO, we want to restrict drawing within our scrollview
	self.scrollEnabled = YES;
	
	// pagingEnabled property default is NO, if set the scroller will stop or snap at each photo
	// if you want free-flowing scroll, don't set this property.
	self.pagingEnabled = YES;
    
    
    int i = 0;
    for (i = 0; i < 4; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + i*(39 +40), 10, 39, 39);
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"00%d",i] ofType:@"png"];
        UIImage *btnImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
        [btn setImage:btnImage forState:UIControlStateNormal];
        [btnImage release];
        [self addSubview:btn];
        
    }
    
    
    
    return self;
}

@end
