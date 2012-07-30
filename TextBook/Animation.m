//
//  Animation.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-1.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "Animation.h"

@implementation Animation
@synthesize swSmile;
@synthesize test;


- (void)setTest:(NSString *)test{
    NSLog(@"\n\n\n\n sw-2-Test-设置方法\n\n\n \n");
}

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.swSmile.frame = CGRectMake(0, 0, 80, 80);
//    self.swSmile.center = self.view.center;
    
    NSLog(@"uniqueIdentifier:%@\n",[UIDevice currentDevice].uniqueIdentifier);
}

- (void)viewDidUnload
{
    [self setSwSmile:nil];
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
    [test release];
    [swSmile release];
    [super dealloc];
}

#pragma mark - 自定义方法

- (void)animationFirst{
    [UIView animateWithDuration:3.0f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
//                         [UIView setAnimationRepeatAutoreverses:YES];
                         self.swSmile.center = CGPointMake(100.0f, 400.0f);
                         [UIView setAnimationsEnabled:NO];
                        }
                     completion:^(BOOL finished) {
                         NSLog(@"1111111111-animation\n");
                     }];
    
//    [self performSelector:@selector(tt) withObject:nil afterDelay:1.0f];
    
    
    
}

- (void)tt{
    [UIView animateWithDuration:8.0f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut |UIViewAnimationOptionOverrideInheritedDuration
                     animations:^{
                         //                         [UIView setAnimationRepeatAutoreverses:YES];
                         self.swSmile.center = CGPointMake(100.0f, 400.0f);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}





- (IBAction)startAnimation:(id)sender {
    NSLog(@"width:%f,height:%f\n",self.swSmile.frame.size.width,self.swSmile.frame.size.height);
    [self animationFirst];
}

- (IBAction)endAnimation:(id)sender {
    self.swSmile.center = self.view.center;
    
}
@end
