//
//  AKTableViewSectionController.h
//  AppKit
//
//  Created by Zijiao Liu on 1/14/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKTableViewConfiguration.h"

@class AKTableViewCellAdapter;

@interface AKTableViewSectionController : NSObject <AKTableViewConfiguration>

@property (nonatomic, getter=isGrouped) BOOL grouped;

- (void)registerAdapter:(nonnull AKTableViewCellAdapter *)adapter forItemClass:(nonnull id)itemClass;

- (AKTableViewCellGroupStyle)dataViewController:(nonnull AKDataViewController *)dataViewController item:(nonnull id)item groupStyleForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end
