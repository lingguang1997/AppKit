//
//  AKTableViewCellAdapterCacheTest.m
//  AppKit
//
//  Created by Zijiao Liu on 12/20/15.
//  Copyright © 2015 Zijiao Liu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AKTableViewCellAdapter.h"
#import "AKTableViewCellAdapterCache.h"

@interface TestString : NSString

@end

@implementation TestString

@end

@interface AKTableViewCellAdapterCacheTest : XCTestCase

@property (nonatomic) AKTableViewCellAdapterCache *cache;

@end

@implementation AKTableViewCellAdapterCacheTest

- (void)setUp {
    [super setUp];
    _cache = [AKTableViewCellAdapterCache new];
}

- (void)testRegister {
    AKTableViewCellAdapter *adapter = [AKTableViewCellAdapter new];
    [_cache registerAdapter:adapter forItemClass:[NSString class]];
    AKTableViewCellAdapter *adapterReceived = [_cache adapterForItemClass:[NSString class]];
    XCTAssert(adapter == adapterReceived);

    adapterReceived = [_cache adapterForItemClass:[TestString class]];
    XCTAssert(adapter == adapterReceived);

    adapterReceived = [_cache adapterForItemClass:[NSNumber class]];
    XCTAssertNil(adapterReceived);
}

@end
