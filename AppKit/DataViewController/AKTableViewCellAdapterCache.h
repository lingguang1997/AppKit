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

- (void)registerAdapter:(AKTableViewCellAdapter *)adapter forItemClass:(id)itemClass;
- (AKTableViewCellAdapter *)adapterForItemClass:(id)itemClass;

@end
