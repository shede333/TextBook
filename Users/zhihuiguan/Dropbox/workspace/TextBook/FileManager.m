//
//  FileManager.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-14.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager
@synthesize textField;

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
    [self fileText];
}

- (void)viewDidUnload
{
    [self setTextField:nil];
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
    [textField release];
    [super dealloc];
}



- (void)fileText{
//    [self fileTest1];
//    [self performSelector:@selector(fileTest2)];
//    [self performSelector:@selector(fileTest3)];
    [self performSelector:@selector(fileTest4)];

}

- (void)fileTest4{
    NSFileManager *file = [NSFileManager defaultManager];
    NSString *pathFrom = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSString *pathTo = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/creat"];
    
    NSDictionary *fileAttribute = [[NSDictionary alloc] initWithObjectsAndKeys:@"时间",NSFileCreationDate, nil];
    if ([file createDirectoryAtPath:pathTo withIntermediateDirectories:YES attributes:fileAttribute error:nil]) {
        NSLog(@"yes:%@\n",[file attributesOfItemAtPath:pathTo error:nil]);
    }
    NSLog(@"no:%@\n",[file attributesOfItemAtPath:pathTo error:nil]);
}

- (void)fileTest3{
    NSFileManager *file = [NSFileManager defaultManager];
    NSString *pathFrom = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSString *pathTo = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tt"];
    NSError *error;
    if ([file copyItemAtPath:pathFrom toPath:pathTo error:&error]) {
        NSLog(@"复制目录成功\n");
    }
    
    NSLog(@"error:%@\n\n,[error description]:%@",error,[error description]);
    BOOL bb;
    NSString *pathTmp = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/11"];
    BOOL result = [file fileExistsAtPath:pathTmp isDirectory:&bb];
    NSLog(@"result:%@\n",[NSNumber numberWithBool:result]);
    NSLog(@"bb:%@\n",[NSNumber numberWithBool:bb]);
    
   
}

- (void)fileTest2{
    NSFileManager *file = [NSFileManager defaultManager];
    NSString *pathFrom = [[NSBundle mainBundle] pathForResource:@"shaowei-疑问替身" ofType:@""];
    NSString *pathTo = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/110.text"];
    if ([file copyItemAtPath:pathFrom toPath:pathTo error:nil]) {
        NSLog(@"复制成功\n");
    }
    
    NSString *pathDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *arrDirectory = [file contentsOfDirectoryAtPath:pathDirectory error:nil];
    NSLog(@"arrDirectory:%@\n",arrDirectory);
    
    NSLog(@"pathFrom:%@",pathFrom);
    //    NSDictionary *fileDic = [file ];
    
    NSLog(@"[file currentDirectoryPath]11:%@\n",[file currentDirectoryPath]);
    
    [file changeCurrentDirectoryPath:NSHomeDirectory()];
    
    NSLog(@"[file currentDirectoryPath]22:%@\n",[file currentDirectoryPath]);
}

- (void)fileTest1{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSString *displayNameAtPath = [fileManager displayNameAtPath:documentsDirectory];
        NSLog(@"displayNameAtPath:%@", displayNameAtPath);
        [fileManager release];
    }
}













@end
