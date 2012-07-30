//
//  chatWindow.m
//  TextBook
//
//  Created by Zhihuiguan Zhihuiguan on 11-12-15.
//  Copyright (c) 2011年 苏州知惠馆信息系统有限公司. All rights reserved.
//

#import "ChatWindow.h"
#import "ChatTableViewCell.h"
#import "BiaoQingView.h"


//static CGRect kTextRec = {0.0f, 0.0f, 226.0f, 30.0f};  //文本输入框---默认尺寸
static CGFloat kMessageFontSize = 22.0f;     //气泡字体
static CGFloat kInputMessageFontSize = 15.0f; 
//输入框字体-  更改字体的同时，也要更改输入框和背景的大小，具体大小，可再delegate找到
//15号字体对应的3行高度为35，54，73
static CGFloat kViewHeight = 416.0f;

static CGFloat kChatContentTextSize = 13.0f;


static CGFloat kCellOriginImageLeftX = 68.0f;
static CGFloat kCellOriginImageRightX = 240.0f;
static CGFloat kCellOriginImageY = 28.0f;

static CGFloat kScrollHeight = 212.0f;//注意这个地方后面要写活咯




static CGFloat kCellImageAddwitch = 10;



@implementation ChatWindow
@synthesize textInput;
@synthesize imageBottom;
@synthesize tableView;
@synthesize imageBottomInput;
@synthesize arrTableView;




- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [faceScroll release];
    [arrTableView release];
    [textInput release];
    [imageBottom release];
    [tableView release];
    [imageBottomInput release];
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
    isFaceFlag = NO;
    
    arrTableView = [[NSMutableArray alloc] init];
    
   //shaowei-delete  start
    int i = 0;
    for (i = 0; i < 5;i ++ ) {
        [arrTableView addObject:@"wergjpeorjgpojeriohseoiwei我饿饭wehio"];
    }
    for (i = 0; i < 11;i ++ ) {
        [arrTableView addObject:@"wergjpeorjgpojeriohseoiwei我饿饭wehiofhweof为io 万恶好烦为发我饿饭为foihwe哦服务饿哦佛我饿饭为wiow俄方还哦为佛问发我饿哦服务efoi我饿饭oiwe范围非oi万恶范围发weoifoiwe覅weiofoi我饿饭哦我饿饭oiwe佛为 wfeiowehfoiwe发我饿哦范围哦哈佛威海foi为ofwioef哦我饿哈佛为发 "];
    }
    NSLog(@"arrTableView:%@\n",arrTableView);
    
    //shaowei-delete  end
    
    //初始化，键盘和表情view 的高度,普通键盘高度212，汉字键盘252
    keyboardHeight = 212.0f; 
    
    //Navigation 添加右边按钮
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(itemTest)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem animated:YES];
    [rightBarButtonItem release];

    
    //定义底框背景 chat_bgd_freeTime
    NSString *pathBottom = [[NSBundle mainBundle] pathForResource:@"chat_底部bgd2@2x" ofType:@"png"];
    UIImage *imageBottomTmp = [[UIImage alloc] initWithContentsOfFile:pathBottom];
    [self.imageBottom setBackgroundColor:[UIColor colorWithPatternImage:imageBottomTmp]];
    [imageBottomTmp release];
    
    //定义输入框背景图；
    NSString *pathInput = [[NSBundle mainBundle] pathForResource:@"chat_输入框" ofType:@"png"];
    UIImage *imageInputTmp = [[UIImage alloc] initWithContentsOfFile:pathInput];
    UIImage *imageInputChange = [imageInputTmp stretchableImageWithLeftCapWidth:226
                                                                   topCapHeight:31];
    [imageInputTmp release];
    self.imageBottomInput.image = imageInputChange;
//    imageBottomInputOriginHeight = self.imageBottomInput.frame.size.height;
    
    //定义输入框
    CGRect textInputFrame = self.imageBottomInput.frame;
    textInputFrame.origin = CGPointZero;
    
    //输入框size取决于 输入框背景的大小
    textInput = [[HPGrowingTextView alloc] initWithFrame:textInputFrame]; 
    textInput.backgroundColor = [UIColor clearColor];
    textInput.minNumberOfLines = 1;
    textInput.maxNumberOfLines = 3;
    textInput.returnKeyType = UIReturnKeySend;
    textInput.font = [UIFont boldSystemFontOfSize:kInputMessageFontSize];
    textInput.delegate = self;
    [textInput sizeToFit];
    [self.imageBottomInput addSubview:textInput];
    [textInput setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    
    //tableView- 设置 + 背景图
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    NSString *pathTableView = [[NSBundle mainBundle] pathForResource:@"bgd" ofType:@"png"];
//    UIImage *imageTableViewBg = [[UIImage alloc] initWithContentsOfFile:pathTableView];
//    UIImageView *imageViewTableViewBg = [[[UIImageView alloc] initWithImage:imageTableViewBg] autorelease];
//    [self.tableView setBackgroundView:imageViewTableViewBg];
//    [imageTableViewBg release];
    
//    [self.tableView setContentInset:UIEdgeInsetsMake(100, 0, 100, 0)];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"chat_logo" ofType:@"png"];
    UIImage *imageTableHead = [[UIImage alloc] initWithContentsOfFile:imagePath];
    UIImageView *imageViewTableHead = [[UIImageView alloc] initWithImage:imageTableHead];
    imageViewTableHead.frame = CGRectMake(0.0f, -200.0f, 320.0f, 200.0f);
    [self.tableView addSubview:imageViewTableHead];
    [imageTableHead release];
    [imageViewTableHead release];
    
    
   
    
    
    
    //键盘通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)viewDidUnload
{
    [self setImageBottom:nil];
    [self setTableView:nil];
    [self setImageBottomInput:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [textInput resignFirstResponder];
}

#pragma mark - 自定义方法

- (void)itemTest{
    NSLog(@"scrollIndicatorInsets\n");
    [self.tableView scrollIndicatorInsets];
}

//点击表情按钮
- (IBAction)actionFace:(id)sender {
    isFaceFlag = !isFaceFlag;
    if (!faceScroll) {
        CGRect frame = self.view.frame;
        faceScroll = [[BiaoQingView alloc] initWithFrame:
                      CGRectMake(frame.size.width, 
                                 frame.size.height,
                                 frame.size.width,
                                 keyboardHeight)];
        [self.view addSubview:faceScroll];
    }
    
    //shaowei-  这只是测试代码，有待改进
    if (isFaceFlag) {
        [self.textInput resignFirstResponder];
    }else{
        
    }
    
}

//点击发送按钮
- (IBAction)actionSend:(id)sender {
    
    if ([self.textInput.text length] == 0) {
        //如果输入框为空，禁止发送
        return;
    }
    
    [arrTableView addObject:self.textInput.text];
    [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                     withObject:nil
                                  waitUntilDone:NO];
    
    self.textInput.text = @"";
    [self moveTableviewToEnd];
}


#pragma mark - 键盘滑动

- (void)keyboardWillShow:(id)sender{
    CGRect keyboardFrame;
    NSDictionary *userInfo = [((NSNotification *)sender) userInfo];
    [[userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] getValue:&keyboardFrame];
    keyboardHeight = CGRectGetHeight(keyboardFrame);
    NSLog(@"keyboard height :%g", keyboardHeight);
    
    tableViewOffset = self.tableView.contentOffset;
    
    // Get animation info from userInfo
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    // 收起主视图
    [self slideFrame:YES 
               curve:animationCurve 
            duration:animationDuration
                face:NO];
}

- (void)keyboardWillHide:(id)sender{
    if (isFaceFlag) {
        //此时打开了 表情按钮
        [self slideFrame:YES 
                   curve:animationCurve 
                duration:animationDuration
                    face:YES
         ];
        
        
    }else{
    keyboardHeight *= -1;
    [self slideFrame:YES 
               curve:animationCurve 
            duration:animationDuration
                face:NO
     ];
    }
}

- (void)slideFrame:(BOOL)up curve:(UIViewAnimationCurve)curve duration:(NSTimeInterval)duration face:(BOOL)isFaceBtn
{

    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:animationCurve];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         if (isFaceFlag) {
                             //弹出表情view
                             faceScroll.center = CGPointMake(self.view.frame.size.width * 0.5,
                                                             faceScroll.center.y);
                             
                             
                         }else{
                             //show或者hide 键盘
                             CGRect viewFrame = self.view.frame;
                             if (keyboardHeight < 0) {
                                 viewFrame.size.height -= keyboardHeight;
                             }else{
                                 //                             viewFrame.size.height =  [UIScreen mainScreen].applicationFrame.size.height - keyboardHeight;
                                 //                             float viewHeight = viewFrame.size.height;
                                 viewFrame.size.height = kViewHeight - keyboardHeight;
                             }
                             self.view.frame = viewFrame;
                         }

                     }];
    
    if (keyboardHeight > 0) {
        [self moveTableviewToEnd];
    }
}

- (void)moveTableviewToEnd{
    int arrNum = [arrTableView count];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(arrNum - 1) inSection:0];
    int cellNum = [self.tableView numberOfRowsInSection:0];
    if (cellNum > arrNum) {
        NSLog(@"tableView 不能滑动");
        return;
    }else{
        NSLog(@"tableView 滑到底");
        [self.tableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:YES];
    }
}


#pragma mark - text_Delegate

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height{
    
    float diff = (textInput.frame.size.height - height);
    
    ////  自动向上增长
    //	CGRect r = textviewInputArea.frame;
    //	r.origin.y += diff;
    //	textviewInputArea.frame = r;
    
    // 输入框背景
    CGRect whiteBgOldFrame = imageBottomInput.frame;
    whiteBgOldFrame.size.height -= diff;
    imageBottomInput.frame = whiteBgOldFrame;
    
    // 皮革背景调整
    CGRect bgOldFrame = imageBottom.frame;
    bgOldFrame.origin.y += diff;
    imageBottom.frame = bgOldFrame;  
}

//按发送键
- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView{
    
    if ([growingTextView.text length] == 0) {
        //如果输入框为空，禁止发送
        return NO;
    }
    
    [arrTableView addObject:self.textInput.text];
    [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                     withObject:nil
                                  waitUntilDone:NO];
    
    self.textInput.text = @"";
    [self moveTableviewToEnd];
    
    
//    CGFloat changedHeight = textInput.frame.size.height - imageBottomInputOriginHeight;
//    //输入框清空
//    self.textInput.text = @"";
////    [self.textInput resignFirstResponder];
//   
//    // 输入框大小恢复
//    CGRect textOldFrame = textInput.frame;
//    textOldFrame.size.height = imageBottomInputOriginHeight;
//    textInput.frame = textOldFrame;
//    
//    // 输入框背景
//    CGRect textBgOldFrame = imageBottomInput.frame;
//    textBgOldFrame.size.height  = imageBottomInputOriginHeight;
//    imageBottomInput.frame = textBgOldFrame;
//    
//    // 底栏背景调整
//    CGRect bottomBGOldFrame = imageBottom.frame;
//    bottomBGOldFrame.origin.y += changedHeight;
//    imageBottom.frame = bottomBGOldFrame;  
    
    return YES;
}

- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView{
    
    [self moveTableviewToEnd];
}
- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView{
    [self moveTableviewToEnd];
}



#pragma mark - tableView

//删除 cell
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.textInput resignFirstResponder];
    
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellContent = [arrTableView objectAtIndex:indexPath.row];
    CGSize paoPaoSize = [cellContent sizeWithFont:[UIFont systemFontOfSize:kChatContentTextSize]
                                constrainedToSize:CGSizeMake(200, 200)
                                    lineBreakMode:UILineBreakModeWordWrap];
    if (paoPaoSize.width > 35.0f) {
        return 60.0f + paoPaoSize.height;
    }else{
        return 96.0f;
    }
    
}


//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrTableView count];
}

//定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *stringMain = @"ChatTableViewCell";
    ChatTableViewCell *cell = (ChatTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:stringMain];
    
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ChatTableViewCell" owner:self options:nil];
        cell = (ChatTableViewCell *)[nibs objectAtIndex:0];
        cell.lableNickMine.text = @"我的昵称";
        NSString *pathImageMe = [[NSBundle mainBundle] pathForResource:@"chat_对话框_me@2x" ofType:@"png"]; 
        UIImage *imageTmpMe = [UIImage imageNamed:@"chat_对话框_me@2x.png"];
        cell.imageContentMine.image = [imageTmpMe stretchableImageWithLeftCapWidth:34.0f
                                                                    topCapHeight:30.0f];
        
        NSString *pathImageFriend = [[NSBundle mainBundle] pathForResource:@"chat_对话框_friend@2x" ofType:@"png"]; 
        UIImage *imageTmpFriend = [UIImage imageNamed:@"chat_对话框_friend@2x.png"];
        cell.imageContentFriend.image = [imageTmpFriend stretchableImageWithLeftCapWidth:34.0f
                                                                      topCapHeight:30.0f];
        
    }else{
        cell.lableChatContentMine.text = nil;
        cell.lableChatContentOthers.text = nil;
//        cell.lableNickMine.text = nil;
        cell.lableOthersNick.text = nil;
        
    }
    
    float ttInt = indexPath.row % 2;

    BOOL testBool = (ttInt > 0.5)?YES:NO;
    
    cell.imageViewOthers.hidden = testBool;
    cell.imageOtherBorder.hidden = testBool;
    cell.imageContentFriend.hidden = testBool;
    cell.lableOthersNick.hidden = testBool;
    cell.lableChatContentOthers.hidden = testBool;
    
    cell.imageViewMine.hidden = !testBool;
    cell.imageMineBorder.hidden = !testBool;
    cell.imageContentMine.hidden = !testBool;
    cell.lableNickMine.hidden = !testBool;
    cell.lableChatContentMine.hidden = !testBool;
    
    NSString *cellContent = [arrTableView objectAtIndex:indexPath.row];
    CGSize paoPaoSize = [cellContent sizeWithFont:[UIFont systemFontOfSize:kChatContentTextSize]
                                constrainedToSize:CGSizeMake(200, 200)
                                    lineBreakMode:UILineBreakModeWordWrap];
    
    NSLog(@"content:%@,row:%d,witch:%f,height:%f\n",cellContent,indexPath.row,paoPaoSize.width,paoPaoSize.height);
    
    if (testBool) {
        //右边-我的位置
        
        CGRect originImageFrame = cell.imageContentMine.frame;
        cell.imageContentMine.frame = CGRectMake(kCellOriginImageRightX - originImageFrame.size.width - paoPaoSize.width, 
                                              kCellOriginImageY, 
                                              originImageFrame.size.width + paoPaoSize.width, 
                                              originImageFrame.size.height + paoPaoSize.height);
        
        cell.lableChatContentMine.text = [arrTableView objectAtIndex:indexPath.row];
        CGRect originTextFrame = cell.lableChatContentMine.frame;
        cell.lableChatContentMine.frame = CGRectMake(cell.imageContentMine.frame.origin.x + 10, 
                                                     cell.imageContentMine.frame.origin.y + 10, 
                                                     paoPaoSize.width, 
                                                     paoPaoSize.height);
        
        cell.lableNickMine.text = @"我自己";
        
    }else{
        //左边-朋友的位置
        
        CGRect originImageFrame = cell.imageContentFriend.frame;
        cell.imageContentFriend.frame = CGRectMake(kCellOriginImageLeftX, 
                                              kCellOriginImageY, 
                                              originImageFrame.size.width + paoPaoSize.width, 
                                              originImageFrame.size.height + paoPaoSize.height);
        
        cell.lableChatContentOthers.text = [arrTableView objectAtIndex:indexPath.row];
        CGRect originTextFrame = cell.lableChatContentOthers.frame;
        cell.lableChatContentOthers.frame = CGRectMake(cell.imageContentFriend.frame.origin.x + 20, 
                                                       cell.imageContentFriend.frame.origin.y + 10, 
                                                       paoPaoSize.width, 
                                                       paoPaoSize.height);
        
        cell.lableOthersNick.text = @"朋友";
    }
    
    
    
    
    
    return cell;
}


















@end
