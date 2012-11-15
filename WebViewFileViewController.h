//
//  WebViewFileViewController.h
//  TextBook
//
//  Created by shaowei on 12-11-15.
//
//

#import <UIKit/UIKit.h>

@interface WebViewFileViewController : UIViewController

@property (nonatomic, retain) UIWebView *localWebView;
@property (nonatomic, copy) NSString *htmlString;
@property (nonatomic, copy) NSString *htmlContent;


- (IBAction)actionTest:(id)sender;

@end
