//
//  AKStream.m
//  AppKit
//
//  Created by Zijiao Liu on 12/24/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import "AKStream.h"
#import "NSTimer+AKBlocksSupport.h"

static const NSTimeInterval kDefaultUpdateInterval = 5 * 60;

@interface AKStream ()

@property (nonatomic) NSTimer *timer;

@end

@implementation AKStream

- (instancetype)init {
    self = [super init];
    if (self) {
        _updateInterval = kDefaultUpdateInterval;
    }
    return self;
}

- (void)setUpdateInterval:(NSTimeInterval)updateInterval {
    if (updateInterval >= 0 && updateInterval != _updateInterval) {
        BOOL isPolling = [self isPolling];
        if (isPolling) {
            [self stopPolling];
        }
        _updateInterval = updateInterval;
        if (isPolling) {
            [self startPolling];
        }
    }
}

- (BOOL)shouldPoll {
    return YES;
}

- (BOOL)isPolling {
    return !!_timer;
}

- (void)startPolling {
    __weak AKStream *weakSelf = self;
    _timer = [NSTimer ak_scheduledTimerWithTimeInterval:_updateInterval block:[^{
        [weakSelf update];
    } copy] repeats:YES];
    [_timer fire];
}

- (void)stopPolling {
    [_timer invalidate];
    _timer = nil;
}

- (void)update {
    // should be overridden
}

@end
