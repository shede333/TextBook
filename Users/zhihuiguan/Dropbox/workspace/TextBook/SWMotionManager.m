//
//  SWMotionManager.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-1-31.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "SWMotionManager.h"


@implementation SWMotionManager
@synthesize motionManager;
@synthesize accX;
@synthesize accY;
@synthesize accZ;
@synthesize gyX;
@synthesize gyY;
@synthesize gyZ;
@synthesize magX;
@synthesize magY;
@synthesize magZ;

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
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1/10.0f;
    
    motionManager.gyroUpdateInterval = 1/10.0f;
    
    motionManager.magnetometerUpdateInterval = 0.1f;
    
    motionManager.showsDeviceMovementDisplay = YES;
   
    
    
//    [UIView animateWithDuration:0 animations:^{
//        CGAffineTransform oldT = self.view.transform;
//        self.view.transform = CGAffineTransformRotate(oldT, 3.14);
//        
//    } ];
 
}

- (void)viewDidUnload
{
    [self setAccX:nil];
    [self setAccY:nil];
    [self setAccZ:nil];
    [self setGyX:nil];
    [self setGyY:nil];
    [self setGyZ:nil];
    [self setMagX:nil];
    [self setMagY:nil];
    [self setMagZ:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)startAccelerometer:(id)sender {
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        self.accX.text = [NSString stringWithFormat:@"%0.2f",accelerometerData.acceleration.x];
        self.accY.text = [NSString stringWithFormat:@"%0.2f",accelerometerData.acceleration.y];
        self.accZ.text = [NSString stringWithFormat:@"%0.2f",accelerometerData.acceleration.z];
        
    }];
}

- (IBAction)stopAccelerometer:(id)sender {
    [motionManager stopAccelerometerUpdates];
}

- (IBAction)startGyroscope:(id)sender {
    [motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
        self.gyX.text = [NSString stringWithFormat:@"%0.2f",gyroData.rotationRate.x];
        self.gyY.text = [NSString stringWithFormat:@"%0.2f",gyroData.rotationRate.y];
        self.gyZ.text = [NSString stringWithFormat:@"%0.2f",gyroData.rotationRate.z];
    }];
}

- (IBAction)stopGyroscope:(id)sender {
    [motionManager stopGyroUpdates];
}

- (IBAction)startMagnetometer:(id)sender {
    [motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMagnetometerData *magnetometerData, NSError *error) {
        self.magX.text = [NSString stringWithFormat:@"%0.2f",magnetometerData.magneticField.x];
        self.magY.text = [NSString stringWithFormat:@"%0.2f",magnetometerData.magneticField.y];
        self.magZ.text = [NSString stringWithFormat:@"%0.2f",magnetometerData.magneticField.z];
    }];
}

- (IBAction)stopMagnetometer:(id)sender {
    [motionManager stopMagnetometerUpdates];
}
- (void)dealloc {
    [accX release];
    [accY release];
    [accZ release];
    [gyX release];
    [gyY release];
    [gyZ release];
    [magX release];
    [magY release];
    [magZ release];
    [super dealloc];
}
@end
