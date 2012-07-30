//
//  LookText.m
//  TextBook
//
//  Created by zhihuiguan on 11-7-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LookText.h"


@implementation LookText
@synthesize lLableTime;
@synthesize lTitle;
@synthesize lContent;
@synthesize lookTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [lookTableView release];
    [lLableTime release];
    [lTitle release];
    [lContent release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - 我的方法

//触摸全屏 关闭弹窗
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.lTitle resignFirstResponder];
    [self.lContent resignFirstResponder];
}

//删除 日志
- (IBAction)deleteText:(id)sender {
    NSString *pKey = [self.lLableTime.text stringByAppendingString:self.lTitle.text];
    
    NSString *path = @"/Users/zhihuiguan/Desktop/workspace/atest110/TextBook/TextBook/output.xml";
    NSMutableDictionary *allTextSave = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [allTextSave removeObjectForKey:pKey];
    [allTextSave writeToFile:path atomically:YES];
    [allTextSave release];
    
    [self.lookTableView reloadData];
    
    UIAlertView *aalert=[[UIAlertView alloc] initWithTitle:@"YOUR‘S NOTE" 
                                                   message:@"已经删除"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil, nil];
    [aalert show];
    
    [aalert release];
}


// 重新 保存日志
- (IBAction)saveText:(id)sender {
    [self.lTitle resignFirstResponder];
    [self.lContent resignFirstResponder];
    
    NSString *pTitle = [self.lLableTime.text stringByAppendingString:self.lTitle.text];
    
    NSString *path = @"/Users/zhihuiguan/Desktop/workspace/atest110/TextBook/TextBook/output.xml";
    NSMutableDictionary *allTextSave = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
  //  [allTextSave removeObjectForKey:pTitle];
    NSDate *pTime = [[NSDate alloc] init];
    NSString *pTimestr = [NSString stringWithFormat:@"%@",pTime];
    NSString *pContent = [self.lContent.text stringByAppendingFormat:@"\n\n上次修改时间：%@",[pTimestr substringToIndex:19]];
    [pTime release];
    

    [allTextSave setObject:pContent forKey:pTitle];
    [allTextSave writeToFile:path atomically:YES];
    [allTextSave release];
    
    [self.lookTableView reloadData];
    
    UIAlertView *aalert=[[UIAlertView alloc] initWithTitle:@"YOUR‘S NOTE" 
                                                   message:@"保存完成"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil, nil];
    [aalert show];
    [aalert release];
}



#pragma mark - 初始化

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLLableTime:nil];
    [self setLTitle:nil];
    [self setLContent:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
