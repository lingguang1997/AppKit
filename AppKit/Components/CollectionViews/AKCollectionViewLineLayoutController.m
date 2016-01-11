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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.collectionView.collectionViewLayout = [[AKCollectionViewLineLayout alloc] initWithDelegate:self];
    }
    return self;
}

# pragma mark - AKCollectionViewLineLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    return CGRectGetHeight(self.frame);
}

@end
