//
//  ArticleModel.m
//  Topic Picker
//
//  Created by Tsvi Tannin on 8/1/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
- (instancetype) initWithTitle:(NSString *)title Blurb:(NSString *)blurb ImageURL:(NSString *)imageURL andID:(NSString *)identification
{
    self = [super init];
    if (self) {
        self.title = title;
        self.blurb = blurb;
        self.imageURL = [NSURL URLWithString:imageURL];
        self.identification = identification;
    }
    return self;
}
@end
