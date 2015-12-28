//
//  AKTableViewCellAdapter.h
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKTableViewCell.h"

@interface AKTableViewCellAdapter : NSObject

- (CGFloat)tableView:(nonnull UITableView *)tableView item:(nonnull id)item heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull UITableViewCell<AKTableViewCell> *)tableView:(nonnull UITableView *)tableView item:(nonnull id)item cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)tableView:(nonnull UITableView *)tableView item:(nonnull id)item didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end
