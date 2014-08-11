//
//  Article.h
//  Topic Picker
//
//  Created by Tsvi Tannin on 7/31/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
@class Article;
@protocol ArticleDelegate <NSObject>

- (void)didDislike:(Article *)article;
- (void)didLike:(Article *)article;

@end

@interface Article : UIView
@property (nonatomic, strong) ArticleModel *model;
@property (nonatomic, weak) id<ArticleDelegate>delegate;
- (instancetype)initAsStatic:(BOOL)staticView withFrame:(CGRect)frame;
@end
