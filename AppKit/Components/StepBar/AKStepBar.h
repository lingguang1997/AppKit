//
//  AKStepBar.h
//  AppKit
//
//  Created by Zijiao Liu on 1/24/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKStepBar : UIView

@property (nonatomic) NSInteger steps;
@property (nonatomic) NSInteger currentStep;
@property (nonatomic, nonnull) UIColor *highlightColor;

+ (nonnull UIColor *)defaultBackgroundColor;
+ (nonnull UIColor *)defaultHighlightColor;

- (nonnull instancetype)initWithSteps:(NSInteger)steps;
- (nonnull instancetype)initWithFrame:(CGRect)frame steps:(NSInteger)steps;
- (void)previousStep;
- (void)nextStep;

@end
