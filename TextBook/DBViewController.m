//
//  DBViewController.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-8.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "DBViewController.h"

@implementation DBViewController
@synthesize textFieldTest;
@synthesize popover;
@synthesize personalAddressPicker;

@synthesize pickerAddressPro;
@synthesize pickerAddressCity;
@synthesize pickerAddressZone;

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
}

- (void)viewDidUnload
{
    [self setTextFieldTest:nil];
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
    [pickerAddressZone release];
    [pickerAddressPro release];
    [pickerAddressCity release];
    
    [popover release];
    [personalAddressPicker release];
    [textFieldTest release];
    [super dealloc];
}

#pragma mark - UITextField Delegate method (self.textFieldAge only)
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
        
        if (personalAddressPicker) {
            [personalAddressPicker release];
            personalAddressPicker = nil;
        }
        self.personalAddressPicker = [[PersonalCenterModifyAddressPicker alloc] initWithNibName:@"PersonalCenterModifyAddressPicker" bundle:nil];
        self.personalAddressPicker.target = self;
        self.personalAddressPicker.callback = @selector(dismissAddress:andCity:andZone:);
        self.personalAddressPicker.initProvince = self.pickerAddressPro;
        self.personalAddressPicker.initCity = self.pickerAddressCity;
        self.personalAddressPicker.initZone = self.pickerAddressZone;
        
        if (popover) {
            [popover release];
            popover = nil;
        }
        popover = [[UIPopoverController alloc] initWithContentViewController:self.personalAddressPicker];
        [popover setDelegate:self];
        [popover setPopoverContentSize:CGSizeMake(320.0, 260.0)];
        
//        CGRect frame_4 = self.textFieldTest.frame;
//        CGFloat y = frame_4.origin.y;
//        frame_4.origin.y = y - self.scrollView.contentOffset.y;
//        NSLog(@"frame :%f,y:%f,scroll:%f\n",frame_4.origin.y,self.scrollView.contentOffset.y,y);
        personalAddressPicker.contentSizeForViewInPopover = self.personalAddressPicker.view.bounds.size;
        
        //popoverContentViewController.contentSizeForViewInPopover = popoverContentViewController.view.bounds.size;
        [popover presentPopoverFromRect:self.textFieldTest.frame
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        UIPickerView *addressPicker = personalAddressPicker.pickerAddress;
        CGRect frame = addressPicker.frame;
        frame.size.height = 216.0;
        addressPicker.frame = frame;
        return NO;

}// return NO to disallow editing.

- (void)dismissAddress:(NSString *)province andCity:(NSString *)city andZone:(NSString *)zone{

    self.pickerAddressPro = province;
    self.pickerAddressCity = city;
    self.pickerAddressZone = zone;
    NSLog(@"self.pickerAddressPro :%d, province:%d\n",[self.pickerAddressPro retainCount] , [province retainCount]);
    
    if (([self.pickerAddressPro length] == 0) && ([self.pickerAddressCity length] == 0) && ([self.pickerAddressZone length] == 0)) {
        self.textFieldTest.text = nil;
    }else{
        self.textFieldTest.text = [NSString stringWithFormat:@"%@ %@ %@",
                                         self.pickerAddressPro,
                                         self.pickerAddressCity,
                                         self.pickerAddressZone];
    }
    
    
    
    
    [popover dismissPopoverAnimated:YES];
    [popover release];
    popover = nil;
    if (personalAddressPicker) {
        [personalAddressPicker release];
        personalAddressPicker = nil;
    }
}











@end
