//
//  AKTableViewCellAdapterCache.m
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import "AKTableViewCellAdapter.h"
#import "AKTableViewCellAdapterCache.h"

@interface AKTableViewCellAdapterCache ()

@property (nonatomic) NSMutableDictionary *cache;

@end

@implementation AKTableViewCellAdapterCache

- (instancetype)init {
    if (self = [super init]) {
        _cache = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)registerAdapter:(AKTableViewCellAdapter *)adapter forItemClass:(id)itemClass {
    assert(adapter);
    assert(itemClass);
    _cache[itemClass] = adapter;
}

- (AKTableViewCellAdapter *)adapterForItemClass:(id)itemClass {
    assert(itemClass);

    for (id itemClazz = itemClass; itemClazz != nil; itemClazz = [itemClazz superclass]) {
        AKTableViewCellAdapter *adapter = _cache[itemClazz];
        if (adapter) {
            if (itemClazz != itemClass) {
                _cache[itemClazz] = adapter;
            }
            return adapter;
        }
    }
    return nil;
}

@end
