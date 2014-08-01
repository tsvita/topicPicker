//
//  FinalStateViewController.m
//  Topic Picker
//
//  Created by Tsvi Tannin on 8/1/14.
//  Copyright (c) 2014 Tsvi Tannin. All rights reserved.
//

#import "FinalStateViewController.h"

@interface FinalStateViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//@property (nonatomic, copy) NSArray *items;
@end

@implementation FinalStateViewController

//- (instancetype)initWithItems:(NSArray *)items
//{
//    self = [super initWithCollectionViewLayout:];
//    if (self) {
//        self.items = items;
//    }
//    return self;
//}
//
//- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andItems:(NSArray *)items
//{
//    self = [super initWithCollectionViewLayout:layout];
//    if (self) {
//        self.items = items;
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"MY_CELL"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    cell.label.text = [self.items objectAtIndex:indexPath.item];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}
#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(10, 10);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
