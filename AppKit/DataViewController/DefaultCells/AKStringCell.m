//
//  AKStringCell.m
//  AppKit
//
//  Created by Zijiao Liu on 2/14/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKStringCell.h"

@implementation AKStringCell

- (void)updateWithItem:(id)item {
    assert([item isKindOfClass:[NSString class]]);
    self.textLabel.text = (NSString *)item;
    [self setNeedsDisplay];
}

@end
