//
//  MediaPlayerSW.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-10.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "MediaPlayerSW.h"

@implementation MediaPlayerSW

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
    [mediaPlayer release];
    [super dealloc];
}

- (IBAction)actionPlay:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iPhone" ofType:@"mov"];
    NSURL *movieURL = [NSURL fileURLWithPath:path];
    mediaPlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    mediaPlayer.scalingMode = MPMovieScalingModeFill;
//    mediaPlayer.movieMediaTypes = MPMovieMediaTypeMaskVideo;
    mediaPlayer.view.frame = CGRectMake(20, 20, 280, 350);
    [self.view addSubview:mediaPlayer.view];
    [mediaPlayer play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(callBack:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:mediaPlayer];
    
}

- (void)callBack:(NSNotification *)nofification{
    [[NSNotificationCenter defaultCenter]  removeObserver:self
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:mediaPlayer];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"确认"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}


@end
