//
//  AKCollectionViewLineLayout.h
//  AppKit
//
//  Created by Zijiao Liu on 1/11/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AKCollectionViewLineLayoutDelegate <NSObject>

- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView heightForItemAtIndexPath:(nonnull NSIndexPath *)indexPath withWidth:(CGFloat)width;

@end

@interface AKCollectionViewLineLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<AKCollectionViewLineLayoutDelegate> delegate;
@property (nonatomic) CGFloat zoomFactor;
@property (nonatomic) BOOL zoomAllowed;

- (nonnull instancetype)initWithDelegate:(nonnull id<AKCollectionViewLineLayoutDelegate>)delegate;

@end
