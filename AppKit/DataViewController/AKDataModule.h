//
//  AKDataModule.h
//  AppKit
//
//  Created by Zijiao Liu on 1/15/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKDataModule <NSObject, NSCopying>

- (NSString *)identifier;
- (NSArray *)data;

@end
