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

- (CGFloat)dataViewController:(AKDataViewController *)dataViewController item:(id<NSObject>)item groupStyle:(AKTableViewCellGroupStyle)groupStyle seperatorEnabled:(BOOL)seperatorEnabled heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
