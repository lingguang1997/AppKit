//
//  AKTableViewCellAdapter.m
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import "AKCell.h"
#import "AKTableViewCellAdapter.h"

@implementation AKTableViewCellAdapter

- (CGFloat)dataViewController:(nonnull AKDataViewController *)dataViewController item:(id)item heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (AKCell *)dataViewController:(nonnull AKDataViewController *)dataViewController item:(id)item cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)dataViewController:(nonnull AKDataViewController *)dataViewController item:(nonnull id)item didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // should be overridden
}

@end
