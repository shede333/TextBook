//
//  TestCodingViewController.h
//  TextBook
//
//  Created by shaowei on 13-1-21.
//
//

#import <UIKit/UIKit.h>
#import "CodingModel.h"

@interface TestCodingViewController : UIViewController


@property (retain, nonatomic) IBOutlet UITextField *textNumber;
@property (retain, nonatomic) IBOutlet UITextField *textString;
- (IBAction)actionSave:(id)sender;


@end
