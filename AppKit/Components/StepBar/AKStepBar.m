//
//  AKStepBar.m
//  AppKit
//
//  Created by Zijiao Liu on 1/24/16.
//  Copyright © 2016 Zijiao Liu. All rights reserved.
//

#import "AKStepBar.h"

@interface AKStepBar ()

@property (nonatomic, nonnull) CALayer *highlightStepLayer;

@end

@implementation AKStepBar

- (instancetype)initWithFrame:(CGRect)frame steps:(NSInteger)steps {
    assert(steps);
    self = [self initWithFrame:frame];
    if (self) {
        self.steps = steps;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _commentInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _commentInit];
    }
    return self;
}

- (void)_commentInit {
    _currentStep = 0;
    self.backgroundColor = [AKStepBar defaultBackgroundColor];
    _highlightStepLayer = [CALayer new];
    _highlightStepLayer.backgroundColor = [AKStepBar defaultHighlightColor].CGColor;
    [self.layer addSublayer:_highlightStepLayer];
}

- (instancetype)initWithSteps:(NSInteger)steps {
    return [self initWithFrame:CGRectZero steps:steps];
}

- (void)setSteps:(NSInteger)steps {
    if (_steps != steps) {
        assert(steps);
        _steps = steps;
        [self setNeedsLayout];
    }
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    if (![_highlightColor isEqual:highlightColor]) {
        _highlightColor = highlightColor;
        _highlightStepLayer.backgroundColor = _highlightColor.CGColor;
    }
}

- (BOOL)canGoPreviousStep {
    return !!_currentStep;
}

- (BOOL)canGoNextStep {
    return _currentStep < _steps - 1;
}

- (BOOL)previousStep {
    if ([self canGoPreviousStep]) {
        _currentStep--;
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}

- (BOOL)nextStep {
    if ([self canGoNextStep]) {
        _currentStep++;
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    CGFloat stepWidth = size.width / _steps;
    _highlightStepLayer.frame = CGRectMake(0, 0, (_currentStep + 1) * stepWidth, size.height);
}

+ (UIColor *)defaultBackgroundColor {
    return [UIColor colorWithRed:179.0 / 255 green:222.0 / 255 blue:242.0 / 255 alpha:1];
}

+ (UIColor *)defaultHighlightColor {
    return [UIColor colorWithRed:43.0 / 255 green:175.0 / 255 blue:243.0 / 255 alpha:1];
}

@end
