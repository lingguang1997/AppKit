//
//  AKRoundedView.m
//  AKRoundedView
//
//  Created by Tomasz Kuźma on 1/6/13.
//  Copyright (c) 2013 Tomasz Kuźma. All rights reserved.
//

#import "AKRoundedView.h"
#import <QuartzCore/QuartzCore.h>

const AKRoundedCorner AKRoundedCornerAll = AKRoundedCornerTopRight | AKRoundedCornerBottomRight | AKRoundedCornerBottomLeft | AKRoundedCornerTopLeft;

const AKDrawnBorderSides AKDrawnBorderSidesAll = AKDrawnBorderSidesRight | AKDrawnBorderSidesLeft | AKDrawnBorderSidesTop | AKDrawnBorderSidesBottom;

UIImage * AKRoundedCornerImage(CGSize size,
                               AKRoundedCorner corners,
                               AKDrawnBorderSides drawnBorders,
                               UIColor *fillColor,
                               UIColor *borderColor,
                               CGFloat borderWidth,
                               CGFloat cornerRadius){
    
    AKRoundedView *view = [[AKRoundedView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    view.roundedCorners = corners;
    view.drawnBordersSides = drawnBorders;
    view.fillColor = fillColor;
    view.borderColor = borderColor;
    view.borderWidth = borderWidth;
    view.cornerRadius = cornerRadius;
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    view = nil;
    
    return img;
    
}

@interface AKRoundedView (){
    CGColorSpaceRef _colorSpace;
    CGFloat* _locationsTable;
    CFArrayRef _cfColors;
    CGGradientRef _gradient;
    NSArray *_observableKeys;
}
@end

@implementation AKRoundedView

#pragma mark - Initialization

- (void)dealloc{
    
    [self.observableKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeObserver:self forKeyPath:obj];
    }];
    
    if(_locationsTable != NULL)
        free(_locationsTable);
    
    if (_cfColors != NULL) {
        CFRelease(_cfColors);
    }
    
    if (_colorSpace != NULL) {
        CGColorSpaceRelease(_colorSpace);
    }
    
    if (_gradient != NULL) {
        CGGradientRelease(_gradient);
    }
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self)return nil;
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (!self)return nil;
    
    [self commonInit];
    
    return self;
}

- (void)commonInit{
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    self.contentMode = UIViewContentModeRedraw;
    
    _gradientDirection = AKGradientDirectionVertical;
    _fillColor = [UIColor whiteColor];
    _borderColor = [UIColor lightGrayColor];
    _cornerRadius = 15.0f;
    _borderWidth = 1.0f;
    _roundedCorners = AKRoundedCornerAll;
    _drawnBordersSides = AKDrawnBorderSidesAll;
    
    [self.observableKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addObserver:self forKeyPath:obj options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    }];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat halfLineWidth = _borderWidth / 2.0f;
    
    CGFloat topInsets = _drawnBordersSides & AKDrawnBorderSidesTop ? halfLineWidth : -halfLineWidth;
    CGFloat leftInsets = _drawnBordersSides & AKDrawnBorderSidesLeft ? halfLineWidth : -halfLineWidth;
    CGFloat rightInsets = _drawnBordersSides & AKDrawnBorderSidesRight ? halfLineWidth : -halfLineWidth;
    CGFloat bottomInsets = _drawnBordersSides & AKDrawnBorderSidesBottom ? halfLineWidth : -halfLineWidth;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(topInsets, leftInsets, bottomInsets, rightInsets);
    
    CGRect properRect = UIEdgeInsetsInsetRect(rect, insets);
    
    /* Setup line width */
    CGContextSetLineWidth(ctx, 0.0f);
    
    // Add and fill rect
    [self addPathToContext:ctx inRect:properRect respectDrawnBorder:NO];
    
    // Close the path
    CGContextClosePath(ctx);
    
    if (_gradientColorsAndLocations.count) {
        CGContextSaveGState(ctx);
        CGContextClip(ctx);
        [self drawGradientToContext:ctx inRect:rect];
        CGContextRestoreGState(ctx);
    }
    else{
        // Fill and Stroke path
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        CGContextDrawPath(ctx, kCGPathFill);
    }
    
    /* Setup colors and line width */
    CGContextSetStrokeColorWithColor(ctx, _borderColor.CGColor);
    CGContextSetLineWidth(ctx, _borderWidth);
    
    // Add and stroke rect
    [self addPathToContext:ctx inRect:properRect respectDrawnBorder:YES];
    
    // Fill and Stroke path
    CGContextDrawPath(ctx, kCGPathStroke);
    
}

- (void)addPathToContext:(CGContextRef)ctx inRect:(CGRect)rect respectDrawnBorder:(BOOL)respectDrawnBorders{
    
    CGFloat minx = CGRectGetMinX(rect);
    CGFloat midx = CGRectGetMidX(rect);
    CGFloat maxx = CGRectGetMaxX(rect);
    
    CGFloat miny = CGRectGetMinY(rect);
    CGFloat midy = CGRectGetMidY(rect);
    CGFloat maxy = CGRectGetMaxY(rect);
    
    
    CGContextMoveToPoint(ctx, minx, midy);
    
    /* Top Left Corner */
    if (_roundedCorners & AKRoundedCornerTopLeft && _drawnBordersSides & (AKDrawnBorderSidesTop | AKDrawnBorderSidesLeft)) {
        CGContextAddArcToPoint(ctx, minx, miny, midx, miny, _cornerRadius);
        CGContextAddLineToPoint(ctx, midx, miny);
    }
    else{
        
        if (_drawnBordersSides & AKDrawnBorderSidesLeft || !respectDrawnBorders){
            CGContextAddLineToPoint(ctx, minx, miny);
        }
        else{
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextMoveToPoint(ctx, minx, miny);
        }
        
        if (_drawnBordersSides & AKDrawnBorderSidesTop  || !respectDrawnBorders){
            CGContextAddLineToPoint(ctx, midx, miny);
        }
        else{
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextMoveToPoint(ctx, midx, miny);
        }
    }
    
    /* Top Right Corner */
    if (_roundedCorners & AKRoundedCornerTopRight && _drawnBordersSides & (AKDrawnBorderSidesTop | AKDrawnBorderSidesRight)) {
        CGContextAddArcToPoint(ctx, maxx, miny, maxx, midy, _cornerRadius);
        CGContextAddLineToPoint(ctx, maxx, midy);
    }
    else{
        
        if (_drawnBordersSides & AKDrawnBorderSidesTop  || !respectDrawnBorders){
            CGContextAddLineToPoint(ctx, maxx, miny);
        }
        else{
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextMoveToPoint(ctx, maxx, miny);
        }
        
        if (_drawnBordersSides & AKDrawnBorderSidesRight  || !respectDrawnBorders){
            CGContextAddLineToPoint(ctx, maxx, midy);
        }
        else{
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextMoveToPoint(ctx, maxx, midy);
        }
    }
    
    /* Bottom Right Corner */
    if (_roundedCorners & AKRoundedCornerBottomRight && _drawnBordersSides & (AKDrawnBorderSidesBottom | AKDrawnBorderSidesRight)) {
        CGContextAddArcToPoint(ctx, maxx, maxy, midx, maxy, _cornerRadius);
        CGContextAddLineToPoint(ctx, midx, maxy);
        
    }
    else{
        
        if (_drawnBordersSides & AKDrawnBorderSidesRight  || !respectDrawnBorders){
            CGContextAddLineToPoint(ctx, maxx, maxy);
        }
        else{
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextMoveToPoint(ctx, maxx, maxy);
        }
        
        if (_drawnBordersSides & AKDrawnBorderSidesBottom  || !respectDrawnBorders){
            CGContextAddLineToPoint(ctx, midx, maxy);
        }
        else{
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextMoveToPoint(ctx, midx, maxy);
        }
    }
    
    /* Bottom Left Corner */
    if (_roundedCorners & AKRoundedCornerBottomLeft && _drawnBordersSides & (AKDrawnBorderSidesBottom | AKDrawnBorderSidesLeft)) {
        CGContextAddArcToPoint(ctx, minx, maxy, minx, midy, _cornerRadius);
        CGContextAddLineToPoint(ctx, minx, midy);
    }
    else{
        
        if (_drawnBordersSides & AKDrawnBorderSidesBottom  || !respectDrawnBorders){
            CGContextAddLineToPoint(ctx, minx, maxy);
        }
        else{
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextMoveToPoint(ctx, minx, maxy);
        }
        
        if (_drawnBordersSides & AKDrawnBorderSidesLeft  || !respectDrawnBorders){
            CGContextAddLineToPoint(ctx, minx, midy);
        }
        else{
            CGContextMoveToPoint(ctx, minx, midy);
            CGContextDrawPath(ctx, kCGPathStroke);
        }
        
    }
    
}

- (void)drawGradientToContext:(CGContextRef)ctx inRect:(CGRect)rect{
    
    if (_gradient == NULL) {
        _gradient = CGGradientCreateWithColors(_colorSpace,_cfColors, _locationsTable);
    }
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    
    switch (_gradientDirection) {
        case AKGradientDirectionVertical:
            startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
            endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
            break;
        case AKGradientDirectionHorizontal:
            startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect));
            endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect));
            break;
        case AKGradientDirectionDown:
            startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
            endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
            break;
        case AKGradientDirectionUp:
            startPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
            endPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
            break;
            
        default:
            break;
    }
    
    CGContextSaveGState(ctx);
    CGContextAddRect(ctx, rect);
    CGContextClip(ctx);
    CGContextDrawLinearGradient(ctx, _gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(ctx);
    
}

//#pragma mark - Setters
//
//- (void)setDrawnBordersSides:(AKDrawnBorderSides)drawnBordersSides{
//    _drawnBordersSides = drawnBordersSides;
//    [self setNeedsDisplay];
//}
//
//- (void)setRoundedCorners:(AKRoundedCorner)roundedCorners{
//    _roundedCorners = roundedCorners;
//    [self setNeedsDisplay];
//}
//
//- (void)setBorderColor:(UIColor *)borderColor{
//    if (_borderColor != borderColor) {
//        _borderColor = borderColor;
//        [self setNeedsDisplay];
//    }
//}
//
//- (void)setFillColor:(UIColor *)fillColor{
//    if (_fillColor != fillColor) {
//        _fillColor = fillColor;
//        [self setNeedsDisplay];
//    }
//}
//
//- (void)setGradientColorsAndLocations:(NSArray *)gradientColorsAndLocations{
//    if (_gradientColorsAndLocations != gradientColorsAndLocations) {
//        _gradientColorsAndLocations = gradientColorsAndLocations;
//        [self prepareGradient];
//        [self setNeedsDisplay];
//    }
//}
//
//- (void)setGradientDirection:(AKGradientDirection)gradientDirection{
//    if (_gradientDirection != gradientDirection) {
//        _gradientDirection = gradientDirection;
//        [self setNeedsDisplay];
//    }
//}
//
//- (void)setBorderWidth:(CGFloat)borderWidth{
//    _borderWidth = borderWidth;
//    [self setNeedsDisplay];
//}
//
//- (void)setCornerRadius:(CGFloat)cornerRadius{
//    _cornerRadius = cornerRadius;
//    [self setNeedsDisplay];
//}


#pragma mark - Key-Value Observing

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    return YES;
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"gradientColorsAndLocations"])
    {
        [self prepareGradient];
        [self setNeedsDisplay];
        return ;
    }
    
    [self.observableKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        if ([keyPath isEqualToString:obj])
        {
            [self setNeedsDisplay];
            return;
        }
    }];
}


- (void)didChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key{
    
    if ([key isEqualToString:@"gradientColorsAndLocations"])
    {
        [self prepareGradient];
        [self setNeedsDisplay];
    }
}

- (NSArray *)observableKeys{
    if (!_observableKeys) {
        _observableKeys = (@[
                             @"drawnBordersSides",
                             @"roundedCorners",
                             @"fillColor",
                             @"borderColor",
                             @"borderWidth",
                             @"cornerRadius",
                             @"gradientDirection",
                             @"gradientColorsAndLocations"
                             ]);
    }
    return _observableKeys;
}

#pragma mark - Private

- (void)prepareGradient{
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:_gradientColorsAndLocations.count];
    NSMutableArray *locations = [NSMutableArray arrayWithCapacity:_gradientColorsAndLocations.count];
    
    for (NSDictionary *dictionary in self.gradientColorsAndLocations) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            for (NSString *key in dictionary) {
                id object = dictionary[key];
                if ([object isKindOfClass:[NSNumber class]]) {
                    [locations addObject:object];
                }
                else if ([object isKindOfClass:[UIColor class]]){
                    [colors addObject:object];
                }
            }
        }
    }
    
    if (colors.count == locations.count) {
        
        if (_colorSpace == NULL) {
            _colorSpace = CGColorSpaceCreateDeviceRGB();
        }
        
        NSInteger count = locations.count;
        
        
        if (_locationsTable != NULL) {
            free(_locationsTable);
        }
        
        _locationsTable = malloc((size_t) sizeof(CGFloat) * count);
        
        CFMutableArrayRef cfColorsMutable = CFArrayCreateMutable(kCFAllocatorDefault, count, &kCFTypeArrayCallBacks);
        
        for(int i = 0; i < count; i++){
            NSNumber *locationNumber = locations[i];
            _locationsTable[i] = [locationNumber floatValue];
            CGColorRef color = [colors[i] CGColor];
            CFArrayAppendValue(cfColorsMutable, color);
        }
        
        if (_cfColors != NULL) {
            CFRelease(_cfColors);
        }
        _cfColors = CFArrayCreateCopy(kCFAllocatorDefault, cfColorsMutable);
        
        CFRelease(cfColorsMutable);
        
        if (_gradient != NULL) {
            CGGradientRelease(_gradient);
            _gradient = NULL;
        }
    }
}

@end
