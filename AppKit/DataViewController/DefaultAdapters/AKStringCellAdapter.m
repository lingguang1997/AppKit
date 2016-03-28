//
//  AKStringCellAdapter.m
//  AppKit
//
//  Created by Zijiao Liu on 2/14/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKStringCellAdapter.h"
#import "AKStringCell.h"

@implementation AKStringCellAdapter

- (AKTableViewCell *)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[AKStringCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AKStringCell"];

}

- (CGFloat)dataViewController:(AKDataViewController *)dataViewController item:(NSString *)item groupStyle:(AKTableViewCellGroupStyle)groupStyle seperatorEnabled:(BOOL)seperatorEnabled heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (item.length) {
        return 44;
    } else {
        return 12;
    }
}

- (BOOL)dataViewController:(AKDataViewController *)dataViewController item:(NSString *)item seperatorForRowAtIndexPath:(NSIndexPath *)indexPath {
    return !!item.length;
}

@end
