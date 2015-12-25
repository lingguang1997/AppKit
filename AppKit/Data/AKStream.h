//
//  AKStream.h
//  AppKit
//
//  Created by Zijiao Liu on 12/24/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AKStream

- (void)streamDidUpdate;

@end

@interface AKStream : NSObject

@property (nonatomic) NSTimeInterval updateInterval;
@property (nonatomic, readonly) NSArray *streamItems;
@property (nonatomic, weak) id<AKStream> delegate;

- (void)startPolling;
- (void)stopPolling;
- (void)update;

@end
