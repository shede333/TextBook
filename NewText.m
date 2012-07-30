//
//  NewText.m
//  TextBook
//
//  Created by zhihuiguan on 11-7-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NewText.h"


@implementation NewText
@synthesize textContent;
@synthesize titleText;
@synthesize lableDate;
@synthesize dataPicker;
@synthesize newTableView;
@synthesize biaoQingLable;

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
    [newTableView release];
    [dataPicker release];
    [lableDate release];
    [textContent release];
    [titleText release];
    [biaoQingLable release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - 点击时间事件

//点击 时间滚轮
- (IBAction)clickDatePicker:(id)sender {
//    NSLog(@"xxxxx");
    self.lableDate.text = [[NSString stringWithFormat:@"%@",[self.dataPicker date]] substringToIndex:19];
}

//弹出 时间滚轮
- (IBAction)getTime:(id)sender {
    [self.titleText resignFirstResponder];
    [self.textContent resignFirstResponder];
    [self.dataPicker setHidden:NO];
}

//触摸全屏 关闭弹窗
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.dataPicker setHidden:YES];
    [self.titleText resignFirstResponder];
    [self.textContent resignFirstResponder];
}

//点击 保存
- (IBAction)saveText:(id)sender {
    
    [self.dataPicker setHidden:YES];
    [self.titleText resignFirstResponder];
    [self.textContent resignFirstResponder];
    
    NSString *pTitle = [self.lableDate.text stringByAppendingString:self.titleText.text];
    NSString *pContent = self.textContent.text;
    
    //输出路径
    NSString *path111 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MCode.sqlite"];
    NSLog(@"path111:%@\n",path111);
    [path111 release];
    
    NSString *path222 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MonsterBrand.db"];
    NSLog(@"path222:%@\n",path222);
    [path222 release];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *dcoumentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
//    NSString* path = [dcoumentpath stringByAppendingString:@"/m"] ;
//    
    
//    NSString *path = @"/Users/zhihuiguan/Desktop/workspace/atest110/TextBook/TextBook/output.xml";
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"output.xml"];
    NSLog(@"path:\n%@",path);
    
    //验证文件是否存在
    NSMutableDictionary *allTextSave = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:path]) {
        allTextSave = [allTextSave initWithContentsOfFile:path];
    }
    
    
    NSLog(@"dic:\n%@",allTextSave);
    [allTextSave setObject:pContent forKey:pTitle];
    [allTextSave writeToFile:path atomically:YES];
    [allTextSave release];
    
    [self.newTableView reloadData];
    
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
    NSDate *now = [[NSDate alloc] init];
    [dataPicker setDate:now animated:YES];
    [now release];
    self.lableDate.text = [[NSString stringWithFormat:@"%@",[self.dataPicker date]] substringToIndex:19];
    [self.dataPicker setHidden:YES];
    
    self.titleText.placeholder = @"  请输入标题 <img src=\"bundle://smiley.png\"/> ";
    self.textContent.text =@"shvdk  \ue415 face  \ue207  ";
    self.biaoQingLable.text = @"sdv  \ue133 face ";
    
    
    
//    self.biaoQingLable.text = @"\
//    This is a test of styled labels.  Styled labels support \
//    <b>bold text</b>, <i>italic text</i>, <span class=\"blueText\">colored text</span>, \
//    <span class=\"largeText\">font sizes</span>, \
//    <span class=\"blueBox\">spans with backgrounds</span>, inline images \
//    <img src=\"bundle://smiley.png\"/>, and <a href=\"http://www.google.com\">hyperlinks</a> you can \
//    actually touch. URLs are automatically converted into links, like this: http://www.foo.com\
//    <div>You can enclose blocks within an HTML div.</div>\
//    Both line break characters\n\nand HTML line breaks<br/>are respected.";
//    
//    TTStyledTextLabel * label1 = [[[TTStyledTextLabel alloc] initWithFrame:self.view.bounds] autorelease];
//    label1.font = [UIFont systemFontOfSize:17];
//    label1.text = [TTStyledText textFromXHTML:kText lineBreaks:YES URLs:YES];
//    label1.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    //label1.backgroundColor = [UIColor grayColor];
//    [label1 sizeToFit];
    
    
//    NSDate *date = [self.dataPicker date];
   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setDataPicker:nil];
    [self setLableDate:nil];
    [self setTextContent:nil];
    [self setTitleText:nil];
    [self setBiaoQingLable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"qwe\n");
}



@end
