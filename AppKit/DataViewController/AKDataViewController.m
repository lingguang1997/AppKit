//
//  AKDataViewController.m
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <objc/runtime.h>
#import "AKDataModule.h"
#import "AKDataViewController.h"
#import "AKStream.h"
#import "AKTableViewCell.h"
#import "AKTableViewSectionController.h"
#import "UIScrollView+SpiralPullToRefresh.h"

@interface AKDataViewController () <UITableViewDelegate, UITableViewDataSource>

# pragma mark - UI

@property (nonatomic) UITableView *tableView;

# pragma mark - Data

@property (nonatomic) NSMutableDictionary *moduleDict;

@end

@implementation AKDataViewController

# pragma mark - View controller life cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _moduleDict = [NSMutableDictionary dictionary];
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
        __weak typeof(self) weakSelf = self;
        [_tableView addPullToRefreshWithActionHandler:^{
            int64_t delayInSeconds = 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.stream update];
            });
        }];
    }

    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[self stream] shouldPoll]) {
        [[self stream] startPolling];
    } else {
        [[self stream] update];
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

- (void)registerSectionController:(AKTableViewSectionController *)sectionController forDataModuleClass:(id)dataModuleClass {
    _moduleDict[dataModuleClass] = sectionController;
}

# pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewSectionController *sectionController = [self _sectionControllerAtIndexPath:indexPath];
    return [sectionController dataViewController:self item:[self _itemAtIndexPath:indexPath] heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewSectionController *sectionController = [self _sectionControllerAtIndexPath:indexPath];
    [sectionController dataViewController:self item:[self _itemAtIndexPath:indexPath] didSelectRowAtIndexPath:indexPath];
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    __block NSInteger count = 0;
    [[self _modules] enumerateObjectsUsingBlock:^(id<AKDataModule>  _Nonnull dataModule, NSUInteger idx, BOOL * _Nonnull stop) {
        count += [[dataModule data] count];
    }];
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<AKDataModule> module = [self _modules][section];
    return [[module data] count];
}

- (AKTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self _itemAtIndexPath:indexPath];
    AKTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:NSStringFromClass([item class])];
    if (!cell) {
        AKTableViewSectionController *sectionController = [self _sectionControllerAtIndexPath:indexPath];
        cell = [sectionController dataViewController:self item:[self _itemAtIndexPath:indexPath] cellForRowAtIndexPath:indexPath];
    }
    [cell updateWithItem:item];
    return cell;
}

# pragma mark - AKStream

- (void)streamDidUpdate {
    [self.tableView.pullToRefreshController didFinishRefresh];
    [_tableView reloadData];
}

# pragma mark - Private Methods

- (AKTableViewSectionController *)_sectionControllerAtIndexPath:(NSIndexPath *)indexPath {
    id<AKDataModule> dataModule = [self _modules][indexPath.section];
    AKTableViewSectionController *sectionController = _moduleDict[dataModule];
    assert(sectionController);
    return sectionController;
}

- (id)_itemAtIndexPath:(NSIndexPath *)indexPath {
    id<AKDataModule> dataModule = [self _modules][indexPath.section];
    id item = [dataModule data][indexPath.row];
    assert(item);
    return item;
}

- (NSArray *)_modules {
    return [self stream].items;
}

@end
