//
//  AKDataViewController.h
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKStream.h"

@class AKTableViewSectionController;

@interface AKDataViewController : UIViewController <AKStreamDelegate>

- (nonnull AKStream *)stream;

- (void)registerSectionController:(nonnull AKTableViewSectionController *)sectionController forDataModule:(nonnull id)dataModule;

@end
