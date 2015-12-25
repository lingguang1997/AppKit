//
//  NSTimer+AKBlocksSupport.m
//  AppKit
//
//  Created by Zijiao Liu on 12/25/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import "NSTimer+AKBlocksSupport.h"

@implementation NSTimer (AKBlocksSupport)

+ (NSTimer *)ak_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(ak_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)ak_blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end
