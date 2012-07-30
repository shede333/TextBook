//
//  Transform3DSW.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-3-23.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "Transform3DSW.h"
#import <QuartzCore/QuartzCore.h>

@interface Transform3DSW()

- (void)testOfImage;
@end

@implementation Transform3DSW
@synthesize imageOfShow;

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

#pragma mark - image

- (void)testOfImage{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"transform3d" ofType:@"jpg"];
    UIImage *imageTmp = [[UIImage alloc] initWithContentsOfFile:path];
    self.imageOfShow.layer.contents = (id)imageTmp.CGImage;
    [imageTmp release];
    
    CATransform3D dd3 = CATransform3DMakeRotation(M_PI_4, 0, 0.1, 0);
    
    [UIView animateWithDuration:3 animations:^{
        self.imageOfShow.layer.transform = dd3;
    }];
    
    [UIView transitionWithView:self.view
                      duration:3
                       options:0
                    animations:^{
                        self.imageOfShow.layer.transform = dd3;
                    } completion:^(BOOL finished) {
                        
                    }];
    
    

}

//CALayer *sublayer = [CALayer layer];
//sublayer.backgroundColor = [UIColor blueColor].CGColor;
//sublayer.shadowOffset = CGSizeMake(0, 93);
//sublayer.shadowRadius = 15.0;
//sublayer.shadowColor = [UIColor blackColor].CGColor;
//sublayer.shadowOpacity = 0.8;
//sublayer.frame = CGRectMake(130, 30, 128, 192);
////    layer1 .frame=CGRectMake (0 ,0 ,320 ,240 );  
//sublayer . position= CGPointMake(self.view.layer.frame. size. width/ 2 , self.view.layer.frame. size. height/2);
//[self.viewTest.layer addSublayer:sublayer];
//
//NSString *filename = [[NSBundle mainBundle] pathForResource:@"smiley" ofType:@"png"];
//UIImage *im = [[[UIImage alloc] initWithContentsOfFile:filename] autorelease] ;
//sublayer.contents = (id)im.CGImage;
//sublayer.borderColor = [UIColor redColor].CGColor;
//sublayer.borderWidth = 10.0f;
//sublayer.cornerRadius = 20;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self performSelector:@selector(testOfImage) withObject:nil afterDelay:1];
//    [self testOfImage];
}

- (void)viewDidUnload
{
    [self setImageOfShow:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imageOfShow release];
    [super dealloc];
}
@end
