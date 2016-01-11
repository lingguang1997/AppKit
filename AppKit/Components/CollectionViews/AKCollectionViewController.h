//
//  AKCollectionViewController.h
//  AppKit
//
//  Created by Zijiao Liu on 1/11/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKCollectionViewController : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) CGRect frame;
@property (nonatomic, readonly, nonnull) UICollectionView *collectionView;
@property (nonatomic, nonnull) NSArray *data;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end
