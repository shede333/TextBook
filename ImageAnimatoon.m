//
//  ImageAnimatoon.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-21.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "ImageAnimatoon.h"

@implementation ImageAnimatoon
@synthesize imageViewTest;

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

- (void)testimageview{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 220, 90, 90)];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:12];
    for (int i = 1; i<10; i++) {
        UIImage *tmpImage = [UIImage imageNamed:[NSString stringWithFormat:@"P000%d_normal.png",i]];
        [arr addObject:tmpImage];
    }
    imageView.animationImages = arr;
    [arr release];
    imageView.animationDuration = 2;
    imageView.animationRepeatCount = 0;
    [self.view addSubview:imageView];
    [imageView startAnimating];
}

- (void)imageResize{
    UIImage *imageTmp = [UIImage imageNamed:@"rightSign"];
    CGSize size = imageTmp.size;
    UIImage *imageRe = [imageTmp resizableImageWithCapInsets:UIEdgeInsetsMake(size.height/2, 20, size.height/2, 20)];
    
    [imageViewTest setImage:imageRe];
    
//    UIImage *imageCon = [imageTmp ];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self testimageview];
    [self imageResize];
}

- (void)viewDidUnload
{
    [self setImageViewTest:nil];
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
    [imageViewTest release];
    [super dealloc];
}
@end
