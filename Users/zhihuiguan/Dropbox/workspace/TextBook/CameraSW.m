//
//  CameraSW.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-2.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "CameraSW.h"

@implementation CameraSW

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
    
    
    pickers = [[UIImagePickerController alloc]init];
    pickers.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    pickers.showsCameraControls = NO;
    pickers.delegate = self;
    
    [pickers viewWillAppear:YES];
    [pickers viewDidAppear:YES];
//    pickers.allowsEditing = NO;
    [self.view insertSubview:pickers.view atIndex:0];
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

- (void)dealloc{
    [pickers release];
    [super release];
}

@end
