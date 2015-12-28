//
//  AKStream.h
//  AppKit
//
//  Created by Zijiao Liu on 12/24/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKStream : NSObject

@property (nonatomic) NSTimeInterval updateInterval;
@property (nonatomic, readonly) NSArray *streamItems;

- (BOOL)shouldPoll;
- (void)startPolling;
- (void)stopPolling;
- (void)update;

@end
