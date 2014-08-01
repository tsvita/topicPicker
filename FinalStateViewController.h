//
//  FinalStateViewController.h
//  Topic Picker
//
//  Created by Tsvi Tannin on 8/1/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"
@interface FinalStateViewController : UICollectionViewController
//- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andItems:(NSArray *)items;
//- (instancetype)initWithItems:(NSArray *)items;
@property (nonatomic, copy) NSArray *items;
@end
