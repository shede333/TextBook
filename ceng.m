//
//  ceng.m
//  TextBook
//
//  Created by Zhihuiguan on 11-10-19.
//  Copyright 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "ceng.h"
#import <QuartzCore/QuartzCore.h>


@implementation ceng
@synthesize viewTest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [viewTest release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    lable.text = @"test";
    [self.view addSubview: lable];
    lable.backgroundColor = [UIColor clearColor];
    [lable release];
    NSLog(@"self.view.layer.frame:%f,%f,%f,%f\n",self.view.layer.frame.origin.x,self.view.layer.frame.origin.y,self.view.layer.frame.size.width,self.view.layer.frame.size.height);
    // 设定CALayer
    viewTest = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 318.0f, 414.0f)];
    [self.view addSubview:self.viewTest];
    self.viewTest.layer.backgroundColor =[UIColor orangeColor].CGColor;
    self.viewTest.layer.cornerRadius =20.0;
    self.viewTest.layer.frame = CGRectInset(self.viewTest.layer.frame, 10.0, 10.0);
    
    
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor blueColor].CGColor;
    sublayer.shadowOffset = CGSizeMake(0, 93);
    sublayer.shadowRadius = 15.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 0.8;
    sublayer.frame = CGRectMake(130, 30, 128, 192);
//    layer1 .frame=CGRectMake (0 ,0 ,320 ,240 );  
    sublayer . position= CGPointMake(self.view.layer.frame. size. width/ 2 , self.view.layer.frame. size. height/2);
    [self.viewTest.layer addSublayer:sublayer];
    
    NSString *filename = [[NSBundle mainBundle] pathForResource:@"smiley" ofType:@"png"];
    UIImage *im = [[[UIImage alloc] initWithContentsOfFile:filename] autorelease] ;
    sublayer.contents = (id)im.CGImage;
    sublayer.borderColor = [UIColor redColor].CGColor;
    sublayer.borderWidth = 10.0f;
    sublayer.cornerRadius = 20;
    
    
    //旋转
    [ CATransaction setValue:[ NSNumber numberWithFloat: 1.0 ] forKey: kCATransactionAnimationDuration];  
    
    CABasicAnimation *FlipAnimation=[ CABasicAnimation animationWithKeyPath: @"transform.rotation.y" ];  
    
    FlipAnimation.timingFunction= [ CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];  
    
    FlipAnimation.toValue= [NSNumber numberWithFloat :M_PI ];   
    
    FlipAnimation.duration=3 ;  
    
    FlipAnimation.fillMode=kCAFillModeForwards ;  
    
    FlipAnimation.removedOnCompletion=NO ;  
    
    [sublayer addAnimation :FlipAnimation forKey :@"flip" ];  
    
    [ CATransaction commit]; 
    
    
    //怪物图鉴
    UIImageView *imageViewTest = [[UIImageView alloc] initWithImage:im];
    imageViewTest.frame = CGRectMake(10, 10, 55, 55);
    
    //怪物图鉴--背景
    imageViewTest.layer.backgroundColor = [UIColor colorWithRed:0.7f green:0.57f blue:0.4f alpha:0.8f].CGColor;
    imageViewTest.layer.cornerRadius = 10.0f;
    
    [self.viewTest addSubview:imageViewTest];
    
    
    
//    NSString *filename = [[NSBundle mainBundle] pathForResource:@"密语机_通讯录_黑名单_03" ofType:@"png"];
//    UIImage *img = [[UIImage alloc] initWithContentsOfFile:filename];
//    UIImageView *imageBlack = [[UIImageView alloc] initWithFrame:CGRectMake(labelNickname.frame.origin.x+labelNickname.frame.size.width+5,20,80,14)];
//    imageBlack.image = img;
//    [cell addSubview:imageBlack];
//    [img release];
//    [imageBlack release];
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
