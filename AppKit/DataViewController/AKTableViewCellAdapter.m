//
//  AKTableViewCellAdapter.m
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import "AKTableViewCell.h"
#import "AKTableViewCellAdapter.h"

@implementation AKTableViewCellAdapter

- (CGFloat)tableView:(UITableView *)tableView item:(id)item heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell<AKTableViewCell> *)tableView:(UITableView *)tableView item:(id)item cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
