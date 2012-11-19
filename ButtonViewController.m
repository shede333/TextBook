//
//  ButtonViewController.m
//  TextBook
//
//  Created by shaowei on 12-11-19.
//
//

#import "ButtonViewController.h"

@interface ButtonViewController ()

@end

@implementation ButtonViewController
@synthesize btn;
@synthesize btnOfBig;

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
//    UIImage *img = [UIImage imageNamed:@"btn_Bgd"];
//    [btn setImage:img forState:UIControlStateNormal];
//    [btn setTitle:@"myTitle" forState:UIControlStateNormal];
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(10,10,10,30)];
    
    [btnOfBig setTitleEdgeInsets:UIEdgeInsetsMake(0, (-btnOfBig.frame.size.width), 0, 0)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [btn release];
    [btnOfBig release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBtn:nil];
    [self setBtnOfBig:nil];
    [super viewDidUnload];
}
@end
