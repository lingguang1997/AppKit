//
//  AKDataViewController.h
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKStream.h"

@class AKTableViewCellAdapter;

@interface AKDataViewController : UIViewController <AKStreamDelegate>

- (nonnull AKStream *)stream;
- (void)registerAdapter:(nonnull AKTableViewCellAdapter *)adapter forItemClass:(nonnull id)itemClass;

@end
