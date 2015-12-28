//
//  AKDataViewController.m
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <objc/runtime.h>
#import "AKDataViewController.h"
#import "AKStream.h"
#import "AKTableViewCell.h"
#import "AKTableViewCellAdapter.h"
#import "AKTableViewCellAdapterCache.h"

@interface AKDataViewController () <UITableViewDelegate, UITableViewDataSource>

# pragma mark - Data structurs for data
@property (nonatomic) AKTableViewCellAdapterCache *cache;

# pragma mark - UI
@property (nonatomic) UITableView *tableView;

@end

@implementation AKDataViewController

# pragma mark - View controller life cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _cache = [AKTableViewCellAdapterCache new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if ([[self stream] shouldPoll]) {
        [[self stream] startPolling];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = self.view.bounds;
}

- (AKStream *)stream {
    // should be overriden
    return nil;
}

- (void)registerAdapter:(nonnull AKTableViewCellAdapter *)adapter forItemClass:(nonnull id)itemClass {
    assert(itemClass);
    [_cache registerAdapter:adapter forItemClass:itemClass];
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self _adapterWithIndexPath:indexPath] tableView:tableView item:[self _itemAtIndexPath:indexPath] heightForRowAtIndexPath:indexPath];
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self stream].streamItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self stream].streamItems objectAtIndex:section] count];
}

- (UITableViewCell<AKTableViewCell> *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self _itemAtIndexPath:indexPath];
    UITableViewCell<AKTableViewCell> *cell = [_tableView dequeueReusableCellWithIdentifier:NSStringFromClass([item class])];
    if (!cell) {
        cell = [[self _adapterWithIndexPath:indexPath] tableView:tableView item:item cellForRowAtIndexPath:indexPath];
    }
    [cell updateWithItem:item];
    return cell;
}

# pragma mark - AKStream

- (void)streamDidUpdate {
    [_tableView reloadData];
}

# pragma mark - Private Methods

- (id)_itemAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self stream].streamItems[indexPath.section][indexPath.row];
    assert(item);
    return item;
}

- (AKTableViewCellAdapter *)_adapterWithIndexPath:(NSIndexPath *)indexPath {
    id item = [self _itemAtIndexPath:indexPath];
    return [_cache adapterForItemClass:[item class]];
}

@end
