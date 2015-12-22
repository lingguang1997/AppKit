//
//  AKDataViewController.h
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKTableViewCellAdapter;

@interface AKDataViewController : UIViewController

- (void)registerItem:(id)item withAdapter:(AKTableViewCellAdapter *)adapter;

@end
