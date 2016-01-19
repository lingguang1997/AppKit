//
//  AKStream.h
//  AppKit
//
//  Created by Zijiao Liu on 12/24/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKStreamDelegate <NSObject>

- (void)streamDidUpdate;

@end

@interface AKStream : NSObject

@property (nonatomic) NSTimeInterval updateInterval;

/*
 An example of items is
 @[@[data_module], data_module, @[item0, item2], @[data_module], @[item3, item4, item5]]
 @[data_module]: data in it is displayed in a sigle row
 data_module, @[item0, item2]: data in it is displayed in multiple row
*/
@property (nonatomic, nullable) NSMutableArray *items;
@property (nonatomic, weak, nullable) id<AKStreamDelegate> delegate;

- (BOOL)shouldPoll;
- (BOOL)isPolling;
- (void)startPolling;
- (void)stopPolling;
- (void)update;

@end
