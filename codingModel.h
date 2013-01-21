//
//  CodingModel.h
//  TextBook
//
//  Created by shaowei on 13-1-21.
//
//

#import <Foundation/Foundation.h>

@interface CodingModel : NSObject<NSCoding>
@property (nonatomic, assign) NSInteger testint;
@property (nonatomic, retain) NSString *testString;
@property (nonatomic, retain) CodingModel *testModel;

@end
