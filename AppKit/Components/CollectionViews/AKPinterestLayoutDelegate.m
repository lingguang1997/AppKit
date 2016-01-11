//
//  AKPinterestLayoutDelegate.m
//  AppKit
//
//  Created by Zijiao Liu on 1/11/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKPinterestLayoutDelegate.h"

@implementation AKPinterestLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForAnnotationAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    return 0;
}

@end
