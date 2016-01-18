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

- (CGFloat)dataViewController:(AKDataViewController *)dataViewController item:(id<AKDataModule>)module heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _adapterForRow:indexPath.row inModule:module];
    return [adapter dataViewController:dataViewController item:[[module data] objectAtIndex:indexPath.row] heightForRowAtIndexPath:indexPath];
}

- (AKTableViewCell *)dataViewController:(AKDataViewController *)dataViewController item:(id<AKDataModule>)module cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _adapterForRow:indexPath.row inModule:module];
    return [adapter dataViewController:dataViewController item:[[module data] objectAtIndex:indexPath.row] cellForRowAtIndexPath:indexPath];
}

- (void)dataViewController:(AKDataViewController *)dataViewController item:(id<AKDataModule>)module didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewCellAdapter *adapter = [self _adapterForRow:indexPath.row inModule:module];
    [adapter dataViewController:dataViewController item:[[module data] objectAtIndex:indexPath.row] didSelectRowAtIndexPath:indexPath];
}

- (NSInteger)dataViewController:(AKDataViewController *)dataViewController item:(id<AKDataModule>)module numberOfRowsInSection:(NSInteger)section {
    return [module data].count;
}

- (AKTableViewCellGroupStyle)dataViewController:(AKDataViewController *)dataViewController item:(id<AKDataModule>)module groupStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_grouped) {
        id item = [[module data] objectAtIndex:indexPath.row];
        BOOL isFirstItem = [self _isFirstItem:item inModule:module];
        BOOL isLastItem = [self _isLastItem:item inModule:module];
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

- (AKTableViewCellAdapter *)_adapterForRow:(NSInteger)row inModule:(id<AKDataModule>)module {
    assert([module data].count > row);
    id item = [[module data] objectAtIndex:row];;
    return [_cache adapterForItemClass:[item class]];
}

- (BOOL)_isFirstItem:(id)item inModule:(id<AKDataModule>)module {
    return [[[module data] firstObject] isEqual:item];
}

- (BOOL)_isLastItem:(id)item inModule:(id<AKDataModule>)module {
    return [[[module data] lastObject] isEqual:item];
}

@end
