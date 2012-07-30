//
//  alertController.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-11-23.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "alertController.h"

@implementation alertController

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

- (IBAction)alertTest{
    if (av.visible) {
        NSLog(@"alert-111\n");
        [av dismissWithClickedButtonIndex:0 animated:NO];
        
    }
    avInt++;
    av.message = [NSString stringWithFormat:@"%d",avInt%4];
    //    switch (avInt%4) {
    //        case 1:
    //            av.alertViewStyle = UIAlertViewStyleDefault;
    //            break;
    //        case 2:
    //            av.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    //            break;
    //        case 3:
    //            av.alertViewStyle = UIAlertViewStylePlainTextInput;
    //            break;
    //        case 0:
    //            av.alertViewStyle = UIAlertViewStyleSecureTextInput;
    //            break;
    //            
    //        default:
    //            break;
    //    }
    [av show];
    [fhl removeFromSuperview];
    [fhl release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    fhl = [[FHL alloc] initWithFrame:self.view.frame andTextString:@"少尉少尉少尉少尉少尉少尉   少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉少尉"];
    
    [self.view addSubview:fhl];
    avInt = 0;
    av = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(alertTest) userInfo:nil repeats:NO];
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
