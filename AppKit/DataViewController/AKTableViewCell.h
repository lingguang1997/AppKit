//
//  AKTableViewCell.h
//  AppKit
//
//  Created by Zijiao Liu on 12/28/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AKTableViewCell <NSObject>

- (void)updateWithItem:(id)item;
+ (CGFloat)heightForItem:(id)item;

@end
