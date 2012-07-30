//
//  FaceView.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-27.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceView : UIViewController<UIScrollViewDelegate>


@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet UIPageControl *pageController;



- (void)initPageController;
- (void)initScrollView;

@end
