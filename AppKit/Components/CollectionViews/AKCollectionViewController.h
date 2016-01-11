//
//  AKCollectionViewController.h
//  AppKit
//
//  Created by Zijiao Liu on 1/11/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKCollectionViewController : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, readonly, nonnull) UICollectionView *collectionView;
@property (nonatomic, nonnull) NSArray *data;

@end
