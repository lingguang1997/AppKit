//
//  AKTableViewCellAdapterCache.h
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AKTableViewCellAdapter;

@interface AKTableViewCellAdapterCache : NSObject

- (void)registerAdapter:(nonnull AKTableViewCellAdapter *)adapter forItemClass:(nonnull id)itemClass;
- (nullable AKTableViewCellAdapter *)adapterForItemClass:(nonnull id)itemClass;

@end
