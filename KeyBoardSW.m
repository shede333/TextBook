//
//  KeyBoardSW.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-28.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "KeyBoardSW.h"

@interface KeyBoardSW()

- (void)addNotification;


@end

@implementation KeyBoardSW
@synthesize inputTextField;
@synthesize imageInputView;
@synthesize tabbarView;

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

- (void)addImage{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tabBar" ofType:@"png"];
    UIImage *tmpImage = [[UIImage alloc] initWithContentsOfFile:path];
    UIImageView *tmpView = [[UIImageView alloc] initWithImage:tmpImage];
    tmpView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    //    tmpView.frame = CGRectMake(10, 10, 30, 30);
    [self.view insertSubview:tmpView atIndex:0];
    [tmpImage release];
    [tmpView release];
    
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"KeyBoardNormal" ofType:@"png"];
    UIImage *tmpImage2= [[UIImage alloc] initWithContentsOfFile:path2];
    UIImageView *tmpView2 = [[UIImageView alloc] initWithImage:tmpImage2];
    tmpView2.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    //    tmpView.frame = CGRectMake(10, 10, 30, 30);
    [self.view insertSubview:tmpView2 atIndex:0];
    [tmpImage2 release];
    [tmpView2 release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // inputAccessoryView
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"tabBar" ofType:@"png"];
    UIImage *tmpImage2 = [[UIImage alloc] initWithContentsOfFile:path2];
    UIImageView *tmpView2 = [[UIImageView alloc] initWithImage:tmpImage2];
    tmpView2.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    self.inputTextField.inputAccessoryView = self.tabbarView;
    [tmpImage2 release];
    [tmpView2 release];
    
    
    [self addNotification];
    
//    [self addImage];
    
//    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:10];
//    [arr addObject:@"123"];
//    NSMutableArray *arrTmp = [arr copy];
//    NSLog(@"sw-2-arr %@\n",arrTmp);
//    [arr addObject:@"456"];
//    
//    NSLog(@"sw-2-arr %@\n",arrTmp);
//    NSLog(@"sw-2- \n");
}



- (void)viewDidUnload
{
    [self setImageInputView:nil];
    [self setInputTextField:nil];
    [self setTabbarView:nil];
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
    [imageInputView release];
    [inputTextField release];
    [tabbarView release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"sw-2-touches:\n %@\n",touches);
    [self.inputTextField resignFirstResponder];
    
    self.inputTextField.text = @"default";
    self.inputTextField.inputView = nil;
}

#pragma mark - action
- (IBAction)actionNormal:(id)sender {
    // inputView
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KeyBoardNormal" ofType:@"png"];
    UIImage *tmpImage = [[UIImage alloc] initWithContentsOfFile:path];
    UIImageView *tmpView = [[UIImageView alloc] initWithImage:tmpImage];
    tmpView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    //    tmpView.frame = CGRectMake(10, 10, 30, 30);
    self.inputTextField.inputView = tmpView;
    [tmpImage release];
    [tmpView release];
    
    self.inputTextField.text = @"normal";
}

- (IBAction)actionSimple:(id)sender {
    // inputView
    NSString *path = [[NSBundle mainBundle] pathForResource:@"KeyBoardSimple" ofType:@"png"];
    UIImage *tmpImage = [[UIImage alloc] initWithContentsOfFile:path];
    UIImageView *tmpView = [[UIImageView alloc] initWithImage:tmpImage];
    tmpView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    //    tmpView.frame = CGRectMake(10, 10, 30, 30);
    self.inputTextField.inputView = tmpView;
    [tmpImage release];
    [tmpView release];
    
    self.inputTextField.text = @"simple";
}

- (IBAction)actionScaleImage:(id)sender {
    
    CGRect frame = self.tabbarView.frame;
    frame.size.height = 100;
    self.tabbarView.frame = frame;
    
}

- (void)keyboardWillShow:(id)sender{
    NSLog(@"sw-2-notification\n%@ \n\n",(NSNotification *)sender);
    
    CGRect keyboardFrame;
    NSDictionary *userInfo = [((NSNotification *)sender) userInfo];
     NSLog(@"sw-2-userInfo\n%@ \n\n",userInfo);
    
    [[userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] getValue:&keyboardFrame];
    float keyboardHeight = CGRectGetHeight(keyboardFrame);
    UIViewAnimationCurve animationCurve;
    NSTimeInterval animationDuration;
    
    // Get animation info from userInfo
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    id string;
    
//    string getValue:<#(void *)#>
}

- (void)addNotification{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(frameChange:)
//                                                 name:UIKeyboardWillChangeFrameNotification
//                                               object:@"UIKeyboardWillChangeFrameNotification"];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(frameChange:)
//                                                 name:UIWindowDidBecomeVisibleNotification
//                                               object:@"UIKeyboardWillChangeFrameNotification"];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(frameChange:)
//                                                 name:UIWindowDidBecomeHiddenNotification
//                                               object:@"UIKeyboardWillChangeFrameNotification"];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(frameChange:)
//                                                 name:UIWindowDidBecomeKeyNotification
//                                               object:@"UIKeyboardWillChangeFrameNotification"];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(frameChange:)
//                                                 name:UIWindowDidResignKeyNotification
//                                               object:@"UIKeyboardWillChangeFrameNotification"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(frameChange:)
                                                 name:UIKeyboardDidShowNotification
                                               object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

}

- (void)frameChange:(id)sender{
    NSLog(@"sw-2-frameChange \n");
}












@end
