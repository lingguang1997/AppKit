//
//  AKDataViewController.h
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKTableViewCellAdapter;
@class AKStream;

@protocol AKDataViewController

@property (nonatomic, nonnull) AKStream *stream;

- (void)streamDidUpdate;

@end

@interface AKDataViewController : UIViewController <AKDataViewController>

@property (nonatomic, nonnull) AKStream *stream;

- (void)registerAdapter:(nonnull AKTableViewCellAdapter *)adapter forItem:(nonnull id)item;

@end
