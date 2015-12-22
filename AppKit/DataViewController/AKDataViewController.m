//
//  AKDataViewController.m
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <objc/runtime.h>
#import "AKDataViewController.h"
#import "AKTableViewCellAdapter.h"
#import "AKTableViewCellAdapterCache.h"

@interface AKDataViewController () <UITableViewDelegate, UITableViewDataSource>

# pragma mark - Data structurs for data
@property (nonatomic) NSMutableArray *data; // a 2d array
@property (nonatomic) AKTableViewCellAdapterCache *cache;

# pragma mark - UI
@property (nonatomic) UITableView *tableView;

@end

@implementation AKDataViewController

# pragma mark - View controller life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    _cache = [AKTableViewCellAdapterCache new];
    _tableView = [UITableView new];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = self.view.bounds;
}

- (void)registerItem:(id)item withAdapter:(AKTableViewCellAdapter *)adapter {
    assert(item);
    id itemClass = object_getClass(item);
    if (class_isMetaClass(itemClass)) {
        [_cache registerAdapter:adapter forItemClass:itemClass];
    } else {
        [_cache registerAdapter:adapter forItemClass:[item class]];
    }
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self _adapterWithIndexPath:indexPath] tableView:tableView heightForRowAtIndexPath:indexPath];
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_data objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self _adapterWithIndexPath:indexPath] tableView:tableView cellForRowAtIndexPath:indexPath];
}

# pragma mark - Helpers

- (AKTableViewCellAdapter *)_adapterWithIndexPath:(NSIndexPath *)indexPath {
    assert(_data[indexPath.section][indexPath.row]);
    id item = _data[indexPath.section][indexPath.row];
    return [_cache adapterForItemClass:[item class]];
}

@end
