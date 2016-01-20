//
//  AKTableViewCellAdapter.h
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import "AKTableViewConfiguration.h"
#import "AKTableViewCell.h"

@interface AKTableViewCellAdapter : NSObject <AKTableViewConfiguration>

- (CGFloat)dataViewController:(nonnull AKDataViewController *)dataViewController item:(nonnull id<NSObject>)item groupStyle:(AKTableViewCellGroupStyle)groupStyle seperatorEnabled:(BOOL)seperatorEnabled heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end
