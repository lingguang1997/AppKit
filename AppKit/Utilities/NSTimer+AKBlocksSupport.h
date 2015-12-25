//
//  NSTimer+AKBlocksSupport.h
//  AppKit
//
//  Created by Zijiao Liu on 12/25/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (AKBlocksSupport)

+ (NSTimer *)ak_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats;

@end
