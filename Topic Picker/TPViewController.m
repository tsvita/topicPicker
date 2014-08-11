//
//  TPViewController.m
//  Topic Picker
//
//  Created by Tsvi Tannin on 7/31/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import "TPViewController.h"
#import "Article.h"
#import "Communicator.h"
#import "FinalStateViewController.h"
#import "CollectionViewLayout.h"
@interface TPViewController () <ArticleDelegate, CommunicatorDelegate>
@property (nonatomic, strong) Article *topArticle;
@property (nonatomic, strong) Article *bottomArticle;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, strong) NSMutableArray *modelsToSend;
@property (nonatomic, strong) Communicator *comm;
@end

@implementation TPViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configure];
    self.comm =[[Communicator alloc] init];
    self.comm.delegate = self;
    [self.comm getInitialPayload];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
    tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
}
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    if ([_items count] < 2 && [self.modelsToSend count] > 1) {
        NSMutableDictionary *pref = [[NSMutableDictionary alloc] init];
        for (ArticleModel *model in self.modelsToSend) {
            pref[model.identification] = model.liked ? @1 : @0;
        }
        NSDictionary *dump = @{@"topic_results":pref};
        NSData *json = [NSJSONSerialization dataWithJSONObject:dump options:0 error:nil];
        [self.comm getNextPayloadForUser:self.userID WithPreferences:json];
        [self.modelsToSend removeAllObjects];
    }

    return _items;
}
- (void)configure
{
    self.modelsToSend = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.topArticle = [[Article alloc] initAsStatic:NO withFrame:self.view.bounds];
    ArticleModel *model = [[ArticleModel alloc] initWithTitle:@"Bush-era EPA chief stuns Fox Business host with carbon regulation support" Blurb:@"Fox Business host Stuart Varney was not expecting Bush-era EPA Administrator to respond this way Host of Fox Business Varney & Company Stuart Varney was blindsided when Bush-era EPA Administrator Christie Whitman actually supported the regulation of carbon emissions.<p>Varney began the interview by asking Whitman whether or not she would have imposed the same kinds of restrictions on carbon emissions as the EPA has under the Obama Administration. I would have done a regulation on carbon" ImageURL:@"http://cdn.flipboard.com/salon.com/97821bfe88e2275597c067d95e129771ffcfd78f/thumbnail.jpg" andID:@"News"];
    self.topArticle.delegate = self;
    self.topArticle.model = model;
    self.bottomArticle = [[Article alloc] initAsStatic:YES withFrame:self.view.bounds];
     ArticleModel *model2 = [[ArticleModel alloc] initWithTitle:@"US sending arms to Kurds in Iraq" Blurb:@"The Obama administration has begun directly providing weapons to Kurdish forces who have started to make gains against Islamic militants in northern Iraq, senior U.S. officials said Monday, but the aid has so far been limited to automatic rifles and ammunition" ImageURL:@"http://ww2.hdnux.com/photos/31/46/21/6710353/7/622x350.jpg" andID:@"News"];
    self.bottomArticle.model = model2;
    [self.view addSubview:self.bottomArticle];
    [self.view addSubview:self.topArticle];
}
- (void)handleTapGesture
{
//    [self.article removeFromSuperview];
//    [self configure];
//    CollectionViewLayout *collectionViewLayout = [[CollectionViewLayout alloc] init];
//    FinalStateViewController *vc = [[FinalStateViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didDislike:(Article *)article
{
    NSLog(@"dislike");
    self.topArticle.model.liked = NO;
    [self.modelsToSend addObject:self.topArticle.model];
    self.topArticle.model = self.bottomArticle.model;
    self.bottomArticle.model = [self.items objectAtIndex:0];
    [self.items removeObjectAtIndex:0];
}
- (void)didLike:(Article *)article
{
    NSLog(@"like");
    self.topArticle.model.liked = YES;
    [self.modelsToSend addObject:self.topArticle.model];
    self.topArticle.model = self.bottomArticle.model;
    self.bottomArticle.model = [self.items objectAtIndex:0];
    [self.items removeObjectAtIndex:0];
}
- (void)setUserID:(NSString *)userID
{
    _userID = userID;
    if (!self.userID) {
        NSDictionary *bsLikes = @{@"technology":@1, @"flipboard":@1, @"pokemon":@1, @"digimon":@0, @"pulse":@0};
        NSDictionary *moreBS = @{@"topic_results": [NSJSONSerialization dataWithJSONObject:bsLikes options:0 error:nil]};
        NSData *data = [NSJSONSerialization dataWithJSONObject:moreBS options:0 error:nil];
        [self.comm getNextPayloadForUser:self.userID WithPreferences:data];
    }
}
- (void)recievedPayload:(NSDictionary *)payload
{
    NSMutableArray *models = [[NSMutableArray alloc] init];
    NSArray *articles = [payload objectForKey:@"articles"];
    for (NSDictionary *dict in articles) {
        NSDictionary *article = [dict objectForKey:@"flcp"];
        ArticleModel *model = [[ArticleModel alloc] initWithTitle:[article objectForKey:@"title"] Blurb:[article objectForKey:@"excerpt2"] ImageURL:[[[[article objectForKey:@"images"] objectAtIndex:0] objectForKey:@"small"] objectForKey:@"url"] andID:[dict objectForKey:@"topic"]];
        [models addObject:model];
    }
    [self.items addObjectsFromArray:models];
    self.userID = [payload objectForKey:@"user_id"];
}
@end

