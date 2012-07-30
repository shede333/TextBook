//
//  MediaPlayerSW.h
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 12-2-10.
//  Copyright (c) 2012年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MediaPlayerSW : UIViewController{
    MPMoviePlayerController *mediaPlayer;
    
}

@property (nonatomic, retain) MPMoviePlayerController *mediaPlayer;

- (IBAction)actionPlay:(id)sender;

- (IBAction)actionStream:(id)sender;
- (IBAction)actionFinal:(id)sender;

@end
