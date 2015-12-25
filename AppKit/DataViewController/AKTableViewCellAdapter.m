//
//  AKTableViewCellAdapter.m
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import "AKTableViewCellAdapter.h"

@implementation AKTableViewCellAdapter

- (CGFloat)tableView:(UITableView *)tableView item:(id)item heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView item:(id)item cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

@end
