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

static NSString * const kDefaultSectionControllerKey = @"DefaultSectionControllerKey";

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
        _moduleDict = [NSMutableDictionary dictionaryWithObject:[AKTableViewSectionController new] forKey:kDefaultSectionControllerKey];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    id item = [self _itemAtIndexPath:indexPath];
    return [sectionController dataViewController:self item:item heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTableViewSectionController *sectionController = [self _sectionControllerAtIndexPath:indexPath];
    id item = [self _itemAtIndexPath:indexPath];
    [sectionController dataViewController:self item:item didSelectRowAtIndexPath:indexPath];
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self _items].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSObject> item = [self _items][section];
    if ([item conformsToProtocol:@protocol(AKDataModule)]) {
        id<AKDataModule> module = (id<AKDataModule>)item;
        return module.data.count;
    } else {
        NSArray *items = (NSArray *)item;
        return [items count];
    }
}

- (AKTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self _itemAtIndexPath:indexPath];
    AKTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:NSStringFromClass([item class])];
    AKTableViewSectionController *sectionController = [self _sectionControllerAtIndexPath:indexPath];
    if (!cell) {
        cell = [sectionController dataViewController:self item:item cellForRowAtIndexPath:indexPath];
    }
    cell.groupStyle = [sectionController dataViewController:self item:item groupStyleForRowAtIndexPath:indexPath];
    [cell updateWithItem:item];
    return cell;
}

# pragma mark - AKStream

- (void)streamDidUpdate {
    [self.tableView.pullToRefreshController didFinishRefresh];
    [_tableView reloadData];
}

# pragma mark - Private Methods

- (id)_itemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [self _items];
    assert(items.count > indexPath.section);
    id<NSObject> item;
    id<NSObject> section = items[indexPath.section];
    if ([section isKindOfClass:[NSArray class]]) {
        NSArray *itemsInSection = (NSArray *)section;
        assert(itemsInSection.count > indexPath.row);
        item = itemsInSection[indexPath.row];
    } else if ([section conformsToProtocol:@protocol(AKDataModule)]) {
        id<AKDataModule> module = (id<AKDataModule>)section;
        assert(module.data.count > indexPath.row);
        item = [module.data objectAtIndex:indexPath.row];
    } else {
        assert(true);
    }
    return item;
}

- (AKTableViewSectionController *)_sectionControllerAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [self _items];
    id<NSObject> section = items[indexPath.section];
    id<NSObject> item;
    if ([section isKindOfClass:[NSArray class]]) {
        NSArray *itemsInSection = (NSArray *)section;
        if (itemsInSection.count == 1 && [itemsInSection[0] conformsToProtocol:@protocol(AKDataModule)]) {
            item = itemsInSection[0];
        } else if (itemsInSection.count > 0) {
            item = kDefaultSectionControllerKey;
        } else {
            assert(true);
        }
    } else if ([section conformsToProtocol:@protocol(AKDataModule)]) {
        item = section;
    }
    return _moduleDict[[item class]];
}

- (NSArray *)_items {
    return [self stream].items;
}

@end
