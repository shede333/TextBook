//
//  fengHuoLun.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-11-18.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "fengHuoLun.h"
#import <QuartzCore/QuartzCore.h>

@implementation fengHuoLun

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc{
    [dfhl release];
    [super dealloc];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.alpha = 0.1f;
    self.view.backgroundColor = [UIColor clearColor];
//    CGRect frame = self.view.frame;
//    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2, frame.size.height/2, 80, 80)];
//    subView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
//    subView.backgroundColor = [UIColor blackColor];
//    subView.layer.cornerRadius = 10;
//    subView.alpha = 1.0f;
//    [self.view addSubview:subView];

    
    //    dfhl = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //    dfhl.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);  
    //    //activityIndicator.center = self.view.center;  
    //    dfhl.center = CGPointMake(160.0f, 500.0f);  
    //    [self.myScrollView addSubview: dfhl];
    
    //    [dfhl startAnimating];   
    
    
    CALayer *subLayer = [CALayer layer];
    subLayer.backgroundColor = [UIColor blackColor].CGColor;
    subLayer.cornerRadius = 10;
    CGRect frame = self.view.frame;
    subLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    subLayer.bounds = CGRectMake(frame.size.width/2, frame.size.height/2, 80, 80);
    subLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
    [self.view.layer addSublayer:subLayer];
    
    dfhl = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    dfhl.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);  
    dfhl.center = subLayer.position;
    [self.view addSubview:dfhl];
    [dfhl startAnimating]; 
    
    
    
//    CALayer *sublayer = [CALayer layer];
//    sublayer.backgroundColor = [UIColor blueColor].CGColor;
//    sublayer.shadowOffset = CGSizeMake(0, 93);
//    sublayer.shadowRadius = 15.0;
//    sublayer.shadowColor = [UIColor blackColor].CGColor;
//    sublayer.shadowOpacity = 0.8;
//    sublayer.frame = CGRectMake(130, 30, 128, 192);
//    //    layer1 .frame=CGRectMake (0 ,0 ,320 ,240 );  
//    sublayer . position= CGPointMake(self.view.layer.frame. size. width/ 2 , self.view.layer.frame. size. height/2);
//    [self.viewTest.layer addSublayer:sublayer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
