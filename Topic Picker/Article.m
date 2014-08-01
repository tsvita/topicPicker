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
@end
@implementation Article

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor= [UIColor redColor];
    }
    return self;
}

- (void)setImageURL:(NSString *)imageURL
{
    NSURL *source = [[NSURL alloc]initWithString:imageURL];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:source];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            self.imageView.image = [UIImage imageWithData:imageData];
        });
    });
}

- (void)layoutSubviews
{
    CGFloat originY = 0;
    if (!self.containerView) {
        self.containerView = [[UIView alloc] init];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.containerView addGestureRecognizer:pan];
        self.containerView.backgroundColor = [UIColor redColor];
        [self addSubview:self.containerView];
    }
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, originY, 300, 150)];
        [self.containerView addSubview:self.imageView];
    }
    originY += self.imageView.frame.size.height;
    if (!self.titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, 300, 40)];
        self.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:24.0];
        self.titleLabel.text = self.title;
        [self.containerView addSubview:self.titleLabel];
    }
    originY += self.titleLabel.frame.size.height;
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
    NSLog(@"Velocity: %f", [pan velocityInView:self].y);
    NSLog(@"Y: %f", self.containerView.frame.origin.y);
    if ([pan velocityInView:self].y < -1000) [self flyOff:pan];
    if (pan.state == UIGestureRecognizerStateEnded && self.containerView.frame.origin.y <70) [self flyOff:pan];
}

- (void)flyOff:(UIPanGestureRecognizer *)pan
{
    [self.containerView removeGestureRecognizer:pan];
    NSTimeInterval interval = self.containerView.frame.origin.y/[pan velocityInView:self].y;
    [UIView animateWithDuration:interval animations:^{
        [self.containerView setFrame:CGRectMake(10, -self.containerView.frame.size.height, self.containerView.frame.size.width, self.containerView.frame.size.height)];
    } completion:^(BOOL finished) {
        self.containerView = nil;
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
