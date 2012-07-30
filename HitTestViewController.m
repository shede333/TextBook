//
//  HitTestViewController.m
//  TextBook
//
//  Created by ZhiHuiGuan001 舍得 on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HitTestViewController.h"

@interface HitTestViewController ()

@end

@implementation HitTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SubHitTestView1 *viewOfTemp1 = [[SubHitTestView1 alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [viewOfTemp1 setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:viewOfTemp1];
    [viewOfTemp1 release];
    
    
    SubHitTestView2 *viewOfTemp2 = [[SubHitTestView2 alloc] initWithFrame:CGRectMake(150, 150, 100, 100)];
    [viewOfTemp2 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:viewOfTemp2];
    [viewOfTemp2 release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)actionHitTest:(id)sender {
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    UIView *subView =  [self.view hitTest:[touch locationInView:self.view] withEvent:event];
    NSLog(@"SW3-View Class: %@",NSStringFromClass([subView class]));
}




@end
