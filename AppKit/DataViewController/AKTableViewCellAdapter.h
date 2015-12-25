//
//  AKTableViewCellAdapter.h
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AKTableViewCellAdapter : NSObject

- (CGFloat)tableView:(UITableView *)tableView item:(id)item heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView item:(id)item cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
