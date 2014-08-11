//
//  Article.m
//  Topic Picker
//
//  Created by Tsvi Tannin on 7/31/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import "Article.h"

@interface Article ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *blurbView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *blurb;
@property (nonatomic, copy) NSURL *imageURL;
@property (nonatomic, assign) BOOL staticView;
@end
@implementation Article

- (instancetype)initAsStatic:(BOOL)staticView withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.staticView = staticView;
    }
    return self;
}

- (void)setImageURL:(NSString *)imageURL
{
    NSURL *source = [NSURL URLWithString:imageURL];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:source];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            self.imageView.image = [UIImage imageWithData:imageData];
        });
    });
}
- (void)setModel:(ArticleModel *)model
{
    _model = model;
    self.title = model.title;
    self.blurb = model.blurb;
    self.imageURL = model.imageURL;
    self.containerView = nil;
    self.imageView = nil;
    self.titleLabel = nil;
    self.blurbView = nil;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    CGFloat originY = 0;
    if (!self.containerView) {
        self.containerView = [[UIView alloc] init];
        self.containerView.backgroundColor = [UIColor redColor];
        if (!self.staticView) {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self.containerView addGestureRecognizer:pan];
        }
        [self addSubview:self.containerView];
    }
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, originY, self.bounds.size.width-20, 200)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.containerView addSubview:self.imageView];
    }
    originY += self.imageView.frame.size.height;
    if (!self.titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, originY-150, self.imageView.bounds.size.width-60, 40)];
        self.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:18.0];
        self.titleLabel.text = self.title;
        self.titleLabel.backgroundColor = [UIColor grayColor];
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.titleLabel sizeToFit];
        [self.containerView addSubview:self.titleLabel];
    }
    if (!self.blurbView) {
        self.blurbView = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 300, 100)];
        self.blurbView.text = self.blurb;
        self.blurbView.numberOfLines = 0; 
        [self.blurbView setLineBreakMode:NSLineBreakByWordWrapping];
        [self.containerView addSubview:self.blurbView];
    }
    originY += self.blurbView.frame.size.height;
    [self.containerView setFrame:CGRectMake(10, self.bounds.size.height/4.0, self.bounds.size.width-20, originY)];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint translation = [pan translationInView:self];
    pan.view.center = CGPointMake(pan.view.center.x, pan.view.center.y + translation.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self];
    if ([pan velocityInView:self].y*[pan velocityInView:self].y > 2250000 && pan.state == UIGestureRecognizerStateEnded) {
        [self flyOff:pan];
    } else if (pan.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:.25 animations:^{
            [self.containerView setFrame:CGRectMake(10, self.bounds.size.height/4, self.bounds.size.width-20, self.containerView.frame.size.height)];
                                                    }];
    }
}

- (void)flyOff:(UIPanGestureRecognizer *)pan
{
    [self.containerView removeGestureRecognizer:pan];
    NSTimeInterval interval;
    CGFloat finalY;
    BOOL up = YES;
    if ([pan velocityInView:self].y < 0) {
        interval = self.containerView.frame.origin.y/[pan velocityInView:self].y;
        finalY = -self.containerView.frame.size.height;
    } else {
        up = NO;
        interval = (self.superview.bounds.size.height-CGRectGetMinY(self.containerView.frame))/[pan velocityInView:self].y;
        finalY = self.bounds.size.height;
    }
    [UIView animateWithDuration:interval animations:^{
        [self.containerView setFrame:CGRectMake(10, finalY, self.containerView.frame.size.width, self.containerView.frame.size.height)];
    } completion:^(BOOL finished) {
        self.containerView = nil;
        if (up) [self.delegate didLike:self];
        else [self.delegate didDislike:self];
    }];
    
}

- (CGFloat)scale:(CGFloat)val
{
    CGFloat x = sqrtf(val*val);
    CGFloat scaled = sin((3.14159*x)/300);
    if (scaled>1) return 1;
    else return scaled;
}
@end
