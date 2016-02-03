//
//  AKRoundedView.h
//  AKRoundedView
//
//  Created by Tomasz Kuźma on 1/6/13.
//  Copyright (c) 2013 Tomasz Kuźma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, AKRoundedCorner) {
    AKRoundedCornerNone         = 0,
    AKRoundedCornerTopRight     = 1 <<  0,
    AKRoundedCornerBottomRight  = 1 <<  1,
    AKRoundedCornerBottomLeft   = 1 <<  2,
    AKRoundedCornerTopLeft      = 1 <<  3,
};

typedef NS_OPTIONS(NSInteger, AKDrawnBorderSides) {
    AKDrawnBorderSidesNone      = 0,
    AKDrawnBorderSidesRight     = 1 <<  0,
    AKDrawnBorderSidesLeft      = 1 <<  1,
    AKDrawnBorderSidesTop       = 1 <<  2,
    AKDrawnBorderSidesBottom    = 1 <<  3,
};

typedef NS_OPTIONS(NSInteger, AKGradientDirection) {
    AKGradientDirectionHorizontal,
    AKGradientDirectionVertical,
    AKGradientDirectionUp,
    AKGradientDirectionDown,
};

extern const AKRoundedCorner AKRoundedCornerAll;
extern const AKDrawnBorderSides AKDrawnBorderSidesAll;

extern NSString * const AKRoundedViewGradientColorKey;
extern NSString * const AKRoundedViewGradientLocationKey;

UIImage * AKRoundedCornerImage(CGSize size,
                               AKRoundedCorner corners,
                               AKDrawnBorderSides drawnBorders,
                               UIColor *fillColor,
                               UIColor *borderColor,
                               CGFloat borderWidth,
                               CGFloat cornerRadius);

@interface AKRoundedView : UIView

/* Which borders should be drawn - default AKDrawnBordersSidesAll - only not rounded borders can *NOT* be drawn atm  */
@property (nonatomic, assign) AKDrawnBorderSides drawnBordersSides;

/* Which corners should be rounded - default AKRoundedCornerAll */
@property (nonatomic, assign) AKRoundedCorner roundedCorners;

/* Fill color of the figure - default white */
@property (nonatomic, strong) UIColor *fillColor;

/* Stroke color for the figure, default is light gray */
@property (nonatomic, strong) UIColor *borderColor;

/* Border line width, default 1.0f */
@property (nonatomic, assign) CGFloat borderWidth;

/* Corners radius , default 15.0f */
@property (nonatomic, assign) CGFloat cornerRadius;

/* Direction of the gradient [options -, |,  /,  \] (if there will be a gradient drawn), default vertical  */
@property (nonatomic, assign) AKGradientDirection gradientDirection;

/* NSArray of NSDictionaries with NSNumber with color's locations and the UIColor object, default nil  */
@property (nonatomic, strong) NSArray *gradientColorsAndLocations;

@end
