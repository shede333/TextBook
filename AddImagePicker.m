//
//  AddImagePicker.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-28.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "AddImagePicker.h"


@interface AddImagePicker()
- (void)addImage;

@end

@implementation AddImagePicker
@synthesize imagePicker;

- (void)dealloc{
    
    [imagePicker release];
    [super dealloc];
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
    [self addImage];
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


#pragma mark - 自定义方法

- (void)addImage{
    UIImagePickerController *tmpImagePicker = [[UIImagePickerController alloc] init];
    tmpImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    tmpImagePicker.showsCameraControls = YES;
    tmpImagePicker.delegate = self;
    
    self.imagePicker  = tmpImagePicker;
    [tmpImagePicker release];
    
    [self.view insertSubview:imagePicker.view atIndex:0];
    [imagePicker viewWillAppear:YES];
    [imagePicker viewDidAppear:YES];
    
    UIImageView *tmpview1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SW"]];
    
    [self.view insertSubview:tmpview1 aboveSubview:imagePicker.view];
    [tmpview1 release];
    
    
//    [self presentViewController:imagePicker animated:YES completion:^{
//        
//    }];
}













@end
