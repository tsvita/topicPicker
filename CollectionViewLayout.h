//
//  CollectionViewLayout.h
//  Topic Picker
//
//  Created by Tsvi Tannin on 8/1/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewLayout : UICollectionViewFlowLayout
{
    UICollectionViewScrollDirection scrollDirection;
}
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

-(UICollectionViewScrollDirection) scrollDirection;
@end
