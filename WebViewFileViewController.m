//
//  WebViewFileViewController.m
//  TextBook
//
//  Created by shaowei on 12-11-15.
//
//

#import "WebViewFileViewController.h"

@interface WebViewFileViewController ()

- (void)loadWebViewOfString;

@end

@implementation WebViewFileViewController
@synthesize htmlString =_htmlString;
@synthesize localWebView =_localWebView;
@synthesize htmlContent = _htmlContent;


- (void)dealloc
{
    [_htmlContent release];
    [_htmlString release];
    [_localWebView release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *pathOfContent = [[NSBundle mainBundle] pathForResource:@"htmlContent" ofType:@""];
    self.htmlContent = [NSString stringWithContentsOfFile:pathOfContent
                                                 encoding:NSUTF8StringEncoding
                                                    error:nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WebView" ofType:@"html"];
    NSError *error = nil;
    self.htmlString = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];
    if (error) {
        NSLog(@"SW -error: %@",[error userInfo]);
    }
    
//    [self actionTest:nil];
    
//    [self loadWebViewOfLocalFile];
//    [self loadWebViewOfIntenet];
    [self loadWebViewOfString];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Function

- (void)loadWebViewOfStringWithImagePath:(NSString *)pathOfImage andContent:(NSString *)textContent{

    NSString *html = [_htmlString stringByReplacingOccurrencesOfString:@"PTPicturePath" withString:pathOfImage];
    html = [html stringByReplacingOccurrencesOfString:@"PTTextContent" withString:textContent];

    if (!_localWebView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 20, 280, 200)];
        self.localWebView = webView;
        [self.view addSubview:webView];
        [webView release];
    }
    [self.localWebView stopLoading];
    [self.localWebView loadHTMLString:html
                    baseURL:[[NSBundle mainBundle] resourceURL]];
//    [self.localWebView reload];
}

- (void)loadWebViewOfString{
//    NSString *pathOfImage = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"png"];
//    NSString *html = [_htmlString stringByReplacingOccurrencesOfString:@"LZImagePath" withString:pathOfImage];
//    html = [html stringByReplacingOccurrencesOfString:@"PTTextContent" withString:_htmlContent];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WebView2" ofType:@"html"];
    NSError *error = nil;
    NSString *subhtmlString = [NSString stringWithContentsOfFile:path
                                                encoding:NSUTF8StringEncoding
                                                   error:&error];
    if (error) {
        NSLog(@"SW -error: %@",[error userInfo]);
    }
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 20, 280, 200)];
    self.localWebView = webView;
    [self.localWebView loadHTMLString:subhtmlString
                    baseURL:[[NSBundle mainBundle] resourceURL]];
    
 
    
    [self.view addSubview:webView];
    [webView release];
}

- (void)loadWebViewOfLocalFile{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WebView" ofType:@"html"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 20, 280, 200)];
    //    [webView loadHTMLString:content
    //                    baseURL:[NSURL URLWithString:@"www.baidu.com"]];
    
    NSURL *fileUrl = [NSURL fileURLWithPath:path];
    [webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
    
    [self.view addSubview:webView];
    [webView release];
}

- (void)loadWebViewOfIntenet{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 230, 280, 200)];
    //    [webView loadHTMLString:content
    //                    baseURL:[NSURL URLWithString:@"www.baidu.com"]];
    
    NSURL *netUrl = [NSURL URLWithString:@"http://www.baidu.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:netUrl]];
    
    [self.view addSubview:webView];
    [webView setScalesPageToFit:YES];
    [webView release];
}

#pragma mark - action

- (IBAction)actionTest:(id)sender {
    NSString *test = [[NSBundle mainBundle] resourcePath];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"png"];
    NSString *pathOfContent = [[NSBundle mainBundle] pathForResource:@"htmlContent2" ofType:@""];
    NSString *textContent = [NSString stringWithContentsOfFile:pathOfContent
                                                 encoding:NSUTF8StringEncoding
                                                    error:nil];
    [self loadWebViewOfStringWithImagePath:@"loading.png" andContent:textContent];
    
}
@end
