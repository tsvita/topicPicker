//
//  Article.h
//  Topic Picker
//
//  Created by Tsvi Tannin on 7/31/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ArticleDelegate <NSObject>

- (void)setBackGroundColorWith:(UIColor *)color;
- (void)didLike;
- (void)didDislike;

@end

@interface Article : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *blurb;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, weak) id<ArticleDelegate> delegate;
@end
