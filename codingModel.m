//
//  CodingModel.m
//  TextBook
//
//  Created by shaowei on 13-1-21.
//
//

#import "CodingModel.h"

@implementation CodingModel
@synthesize testString = _testString;
@synthesize testint = _testint;
@synthesize testModel = _testModel;

- (void)dealloc
{
    [_testString release];
    [_testModel release];
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:_testint forKey:@"testint"];
    [aCoder encodeObject:_testString forKey:@"testString"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.testint = [aDecoder decodeIntegerForKey:@"testint"];
        self.testString = [aDecoder decodeObjectForKey:@"testString"];
    }
    
    return self;
}

@end
