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
        [self startPolling];
    }
    return self;
}

- (void)setUpdateInterval:(NSTimeInterval)updateInterval {
    if (updateInterval >= 0 && updateInterval != _updateInterval) {
        [self stopPolling];
        _updateInterval = updateInterval;
        [self startPolling];
    }
}

- (BOOL)shouldPoll {
    return YES;
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
}

# pragma mark - Private methods

@end
