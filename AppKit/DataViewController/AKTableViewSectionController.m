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
    AKTableViewCellAdapter *adapter = [self _dataViewController:dataViewController adapterAtRow:indexPath.row];
    return [adapter dataViewController:dataViewController item:item heightForRowAtIndexPath:indexPath];
}

- (AKTableViewCell *)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _dataViewController:dataViewController adapterAtRow:indexPath.row];
    return [adapter dataViewController:dataViewController item:item cellForRowAtIndexPath:indexPath];
}

- (void)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _dataViewController:dataViewController adapterAtRow:indexPath.row];
    [adapter dataViewController:dataViewController item:item didSelectRowAtIndexPath:indexPath];
}

- (AKTableViewCellGroupStyle)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item groupStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_grouped) {
        BOOL isFirstItem = [self _dataViewController:dataViewController isFirstItem:item];
        BOOL isLastItem = [self _dataViewController:dataViewController isLastItem:item];
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

- (id)_dataViewController:(AKDataViewController *)dataViewController itemAtRow:(NSInteger)row {
    NSArray *items = [dataViewController stream].items;
    assert(items.count > row);
    assert(row >= 0);
    return items[row];
}

- (AKTableViewCellAdapter *)_dataViewController:(AKDataViewController *)dataViewController adapterAtRow:(NSInteger)row {
    id item = [self _dataViewController:dataViewController itemAtRow:row];
    return [_cache adapterForItemClass:[item class]];
}

- (BOOL)_dataViewController:(AKDataViewController *)dataViewController isFirstItem:(id)item {
    NSArray *items = [dataViewController stream].items;
    assert(items.count);
    return [items[0] isEqual:item];
}

- (BOOL)_dataViewController:(AKDataViewController *)dataViewController isLastItem:(id)item {
    NSArray *items = [dataViewController stream].items;
    NSInteger lastItemIndex = items.count - 1;
    assert(lastItemIndex);
    return [items[lastItemIndex] isEqual:item];
}

@end
