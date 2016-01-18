//
//  AKTableViewSectionController.m
//  AppKit
//
//  Created by Zijiao Liu on 1/14/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKDataModule.h"
#import "AKDataViewController.h"
#import "AKTableViewCell.h"
#import "AKTableViewCellAdapter.h"
#import "AKTableViewCellAdapterCache.h"
#import "AKTableViewSectionController.h"

@interface AKTableViewSectionController ()

# pragma mark - Data structurs for data
@property (nonatomic) AKTableViewCellAdapterCache *cache;

@property (nonatomic) NSArray *items;

@end

@implementation AKTableViewSectionController

- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [AKTableViewCellAdapterCache new];
    }
    return self;
}

- (void)registerAdapter:(AKTableViewCellAdapter *)adapter forItemClass:(id)itemClass {
    assert(itemClass);
    [_cache registerAdapter:adapter forItemClass:itemClass];
}

# pragma mark - AKTableViewConfiguration

- (CGFloat)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _adapterAtRow:indexPath.row];
    return [adapter dataViewController:dataViewController item:item heightForRowAtIndexPath:indexPath];
}

- (AKTableViewCell *)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _adapterAtRow:indexPath.row];
    return [adapter dataViewController:dataViewController item:item cellForRowAtIndexPath:indexPath];
}

- (void)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _adapterAtRow:indexPath.row];
    [adapter dataViewController:dataViewController item:item didSelectRowAtIndexPath:indexPath];
}

- (AKTableViewCellGroupStyle)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item groupStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_grouped) {
        BOOL isFirstItem = [self _isFirstItem:item];
        BOOL isLastItem = [self _isLastItem:item];
        if (isFirstItem) {
            if (isLastItem) {
                return AKTableViewCellGroupStyleTopAndBottom;
            }
            return AKTableViewCellGroupStyleTop;
        } else if (isLastItem) {
            return AKTableViewCellGroupStyleBottom;
        }
        return AKTableViewCellGroupStyleMiddle;
    }
    return AKTableViewCellGroupStyleNone;
}

- (NSInteger)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item numberOfRowsInSection:(NSInteger)section {
    if ([item conformsToProtocol:@protocol(AKDataModule)]) {
        id<AKDataModule> module = (id<AKDataModule>)item;
        return [module data].count;
    }
    return 1;
}

# pragma mark - Private methods

- (id)_itemAtRow:(NSInteger)row {
    assert(_items.count > row);
    assert(row >= 0);
    return _items[row];
}

- (AKTableViewCellAdapter *)_adapterAtRow:(NSInteger)row {
    id item = [self _itemAtRow:row];
    return [_cache adapterForItemClass:[item class]];
}

- (BOOL)_isFirstItem:(id)item {
    assert(_items.count);
    return [_items[0] isEqual:item];
}

- (BOOL)_isLastItem:(id)item {
    NSInteger lastItemIndex = _items.count - 1;
    assert(lastItemIndex);
    return [_items[lastItemIndex] isEqual:item];
}

@end
