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
    AKTableViewCellAdapter *adapter = [self _adapterForItem:item];
    return [adapter dataViewController:dataViewController item:item heightForRowAtIndexPath:indexPath];
}

- (AKTableViewCell *)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _adapterForItem:item];
    return [adapter dataViewController:dataViewController item:item cellForRowAtIndexPath:indexPath];
}

- (void)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _adapterForItem:item];
    [adapter dataViewController:dataViewController item:item didSelectRowAtIndexPath:indexPath];
}

- (AKTableViewCellGroupStyle)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item groupStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_grouped) {
        assert(![item conformsToProtocol:@protocol(AKDataModule)]);
        BOOL isFirstItem = [self _isFirstItem:item inSection:indexPath.section dataViewController:dataViewController];
        BOOL isLastItem = [self _isLastItem:item inSection:indexPath.section dataViewController:dataViewController];
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

# pragma mark - Private methods

- (AKTableViewCellAdapter *)_adapterForItem:(id)item {
    assert(item);
    return [_cache adapterForItemClass:[item class]];
}

- (BOOL)_isFirstItem:(id)item inSection:(NSInteger)section dataViewController:(AKDataViewController *)dataViewController {
    NSArray *items = dataViewController.stream.items;
    NSArray *itemsInSection = items[section];
    return [item isEqual:[itemsInSection firstObject]];
}

- (BOOL)_isLastItem:(id)item inSection:(NSInteger)section dataViewController:(AKDataViewController *)dataViewController {
    NSArray *items = dataViewController.stream.items;
    NSArray *itemsInSection = items[section];
    return [item isEqual:[itemsInSection lastObject]];
}

@end
