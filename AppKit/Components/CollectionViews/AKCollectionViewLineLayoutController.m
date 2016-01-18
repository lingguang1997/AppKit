//
//  AKCollectionViewLineLayoutController.m
//  AppKit
//
//  Created by Zijiao Liu on 1/11/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKCollectionViewLineLayout.h"
#import "AKCollectionViewLineLayoutController.h"

@implementation AKCollectionViewLineLayoutController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[AKCollectionViewLineLayout alloc] initWithDelegate:self]];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
    }
    return self;
}

# pragma mark - AKCollectionViewLineLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    return CGRectGetHeight(self.collectionView.frame);
}

@end
