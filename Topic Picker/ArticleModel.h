//
//  ArticleModel.h
//  Topic Picker
//
//  Created by Tsvi Tannin on 8/1/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *blurb;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, copy) NSString *identification;
@property (nonatomic, assign) BOOL liked;
- (instancetype) initWithTitle:(NSString *)title Blurb:(NSString *)blurb ImageURL:(NSString *)imageURL andID:(NSString *)identification;

@end
