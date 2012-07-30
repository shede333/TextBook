//
//  SWAccelerometer.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-30.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "SWAccelerometer.h"

@implementation SWAccelerometer
@synthesize accelerometer;
@synthesize compassView;
@synthesize contentView;

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
//    contentView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    NSLog(@"contentView.frame.size.height:%f,%f\n\n",contentView.frame.size.height,contentView.frame.origin.y);
    contentView.image = [UIImage imageNamed:@"compass.png"];
    [self.view addSubview: contentView];
    [contentView release];
    
    compassView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pointer.png"]];
    [compassView setCenter:CGPointMake(160.0f, 240.0f)];
    [contentView addSubview:compassView];
    [compassView release];
    
    accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.delegate = self;
    accelerometer.updateInterval = 1/30.0f;
    
    angleNew = 0;
    angleOld = 0;
    
    
}

//__OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_5_0);
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    angleNew = atan2([acceleration x],[acceleration y]);
    NSLog(@"angleNew:%f\n",angleNew);
    [compassView setTransform:CGAffineTransformMakeRotation(angleNew)];
//    angleOld = angleNew;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setAccelerometer:nil];
    [self setContentView:nil];
    [self setCompassView:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc{
    [accelerometer setDelegate:nil];
    [accelerometer release];
    [contentView release];
    [compassView release];
    [super dealloc];
}

@end
