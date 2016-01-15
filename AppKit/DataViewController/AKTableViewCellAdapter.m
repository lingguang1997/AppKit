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

- (CGFloat)dataViewController:(AKDataViewController *)dataViewController item:(id)item heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (AKTableViewCell *)dataViewController:( AKDataViewController *)dataViewController item:(id)item cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)dataViewController:(AKDataViewController *)dataViewController item:(id)item didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // should be overridden
}

@end
