//
//  TPViewController.m
//  Topic Picker
//
//  Created by Tsvi Tannin on 7/31/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import "TPViewController.h"
#import "Article.h"
@interface TPViewController () <ArticleDelegate>
@property (nonatomic, strong) Article *article;
@end

@implementation TPViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configure];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
}
- (void)configure
{
    self.view.backgroundColor = [UIColor orangeColor];
    self.article = [[Article alloc] init];
    self.article.imageURL = @"http://profile.ak.fbcdn.net/hprofile-ak-xfp1/t1.0-1/s200x200/10390343_10152459335378522_1222800649387301580_n.jpg";
    self.article.frame = self.view.bounds;
    self.article.title = @"This will be an article title";
    self.article.blurb = @"The default values are 0.0 for strokeStart and 1.0 for strokeEnd, obviously, which causes the shape layer’s path to be stroked along its entire length. If you would, say, set layer.strokeEnd = 0.5f, only the first half of the path would be stroked.";
    self.article.delegate = self;
    [self.view addSubview:self.article];
}
- (void)handleTapGesture
{
    [self.article removeFromSuperview];
    [self configure];
}

- (void)didDislike
{
    
}
- (void)didLike
{
    
}
@end

