//
//  AKDynamicHeightView.h
//  AppKit
//
//  Created by Zijiao Liu on 2/15/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#ifndef AKDynamicHeightView_h
#define AKDynamicHeightView_h

#import <UIKit/UIKit.h>

@protocol AKDynamicHeightView <NSObject>

- (CGFloat)heightWithItem:(id)item;

@end


#endif /* AKDynamicHeightView_h */
