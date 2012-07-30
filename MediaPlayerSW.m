//
//  MediaPlayerSW.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-10.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "MediaPlayerSW.h"

@implementation MediaPlayerSW
@synthesize mediaPlayer;

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"sw-2-touch:\n%@,\n %@\n",touches,event);
}

- (IBAction)actionPlay:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iPhone" ofType:@"mov"];
    NSURL *movieURL = [NSURL fileURLWithPath:path];
    MPMoviePlayerController *tmp = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    self.mediaPlayer = tmp;
    [tmp release];
    mediaPlayer.scalingMode = MPMovieScalingModeFill;
//    mediaPlayer.movieMediaTypes = MPMovieMediaTypeMaskVideo;
    NSLog(@"sw-2-mediaPlayer.movieMediaTypes %d\n",mediaPlayer.movieMediaTypes);
    mediaPlayer.movieSourceType = MPMovieSourceTypeFile;
    mediaPlayer.scalingMode = MPMovieScalingModeAspectFit;
    mediaPlayer.controlStyle = MPMovieControlStyleFullscreen;
    mediaPlayer.useApplicationAudioSession = YES;
    mediaPlayer.initialPlaybackTime = 10;
    NSLog(@"sw-2- %@\n",mediaPlayer.timedMetadata);
    

    
    
    mediaPlayer.view.frame = CGRectMake(20, 20, 280, 340);
    [self.view addSubview:mediaPlayer.view];
//    [mediaPlayer play];
    
    
    
//    UIImage *tmpImage = [mediaPlayer thumbnailImageAtTime:3 timeOption:MPMovieTimeOptionNearestKeyFrame];
//    CGImageRef ref = tmpImage.CGImage;
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGImageGetWidth(ref), CGImageGetHeight(ref))];
//    [imageView setImage:tmpImage];
//    [self.view addSubview:imageView];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(callBack:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:mediaPlayer];
    
}

- (IBAction)actionStream:(id)sender {
    NSString *path = @"http://192.168.1.104/MonsterServer/upload/7M.mp4";
//    NSString *path = @"http://114.255.205.191:80//movie//gbjs//1d8289ab-69d7-41cc-a412-aa2e8b7a209fdyd.mp4";
    
//     NSString *path = @"http://v.youku.com/player/getM3U8/vid/69210751/type/mp4/v.m3u8 ";
    
    NSURL *url = [NSURL URLWithString:path];
    MPMoviePlayerController *tmp = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.mediaPlayer = tmp;
    [tmp release];
    
//    mediaPlayer.movieSourceType = MPMovieSourceTypeStreaming;
//    mediaPlayer.movieMediaTypes = MPMovieMediaTypeMaskVideo;
    NSLog(@"sw-2-mediaPlayer.movieMediaTypes %d\n",mediaPlayer.movieMediaTypes);
    mediaPlayer.scalingMode = MPMovieScalingModeAspectFit;
    mediaPlayer.controlStyle = MPMovieControlStyleNone;
    mediaPlayer.allowsAirPlay = NO;
    mediaPlayer.shouldAutoplay = YES;
    mediaPlayer.useApplicationAudioSession = YES;
    [mediaPlayer prepareToPlay];

    
    mediaPlayer.repeatMode = MPMovieRepeatModeNone;
    
    mediaPlayer.view.frame = CGRectMake(20, 20, 280, 340);
    [self.view addSubview:mediaPlayer.view];
    
    [mediaPlayer play];
    
}

- (IBAction)actionFinal:(id)sender {
    
    
    NSLog(@"sw-2-m: %d,s:%d\n",mediaPlayer.movieMediaTypes,mediaPlayer.movieSourceType);
    
    
    
    
    
    
    
    
//    NSURL *theMovieURL = [NSURL URLWithString:@"http://114.255.205.191:80//movie//gbjs//1d8289ab-69d7-41cc-a412-aa2e8b7a209fdyd.mp4"];
//    mediaPlayer=[[MPMoviePlayerController alloc] initWithContentURL:theMovieURL];//用url初始化对象
//    //开始播放
//    
//    
//    
//    
//   
//    //设置视频显示区域
////    [[mediaPlayer view] setFrame:[self.view bounds]]; 
//    //     moviePlayer.playableDuration
//    mediaPlayer.view.frame=CGRectMake(10, 10, 320, 360);//一共有四种，可参考文档，设计播放控制样式
////    [mediaPlayer setFullscreen:YES animated:NO];//全屏
//    mediaPlayer.scalingMode=MPMovieScalingModeAspectFill;//窗口模式设置
//    mediaPlayer.controlStyle=MPMovieControlStyleDefault;
//    mediaPlayer.repeatMode = MPMovieRepeatModeNone;
//    mediaPlayer.useApplicationAudioSession = NO; 
//    /* Indicate the movie player allows AirPlay movie playback. */
//    mediaPlayer.allowsAirPlay = YES;
//    
//    [self.view addSubview:mediaPlayer.view];
//    
//    [mediaPlayer play];
    
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
