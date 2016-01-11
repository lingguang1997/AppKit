//
//  AKCollectionViewController.m
//  AppKit
//
//  Created by Zijiao Liu on 1/11/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKCollectionViewController.h"

@implementation AKCollectionViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _data = [NSMutableArray array];
        _collectionView = [UICollectionView new];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return self;
}

# pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Should be overridden by subclasses
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}

@end
