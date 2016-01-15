//
//  AKTableViewConfiguration.h
//  AppKit
//
//  Created by Zijiao Liu on 1/14/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKDataViewController;
@class AKTableViewCell;

@protocol AKTableViewConfiguration <NSObject>

- (CGFloat)dataViewController:(nonnull AKDataViewController *)dataViewController item:(nonnull id)item heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (nonnull AKTableViewCell *)dataViewController:(nonnull AKDataViewController *)dataViewController item:(nonnull id)item cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (void)dataViewController:(nonnull AKDataViewController *)dataViewController item:(nonnull id)item didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end
