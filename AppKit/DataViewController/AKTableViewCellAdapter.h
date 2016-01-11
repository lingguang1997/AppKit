//
//  AKTableViewCellAdapter.h
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKCell.h"

@class AKDataViewController;

@interface AKTableViewCellAdapter : NSObject

- (CGFloat)dataViewController:(nonnull AKDataViewController *)dataViewController item:(nonnull id)item heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull UITableViewCell<AKCell> *)dataViewController:(nonnull AKDataViewController *)dataViewController item:(nonnull id)item cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)dataViewController:(nonnull AKDataViewController *)dataViewController item:(nonnull id)item didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end
