//
//  MenuButton.m
//  WWDC
//
//  Created by Lars Schwegmann on 25.04.13.
//  Copyright (c) 2013 Lars Schwegmann. All rights reserved.
//

//------------------------------------------------------------------------------------

#import "MenuButton.h"

//------------------------------------------------------------------------------------

@implementation MenuButton

//------------------------------------------------------------------------------------
#pragma mark - UIView Methods
//------------------------------------------------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGColorRef strokeColor;
    CGColorRef fillColor;
    
    switch (self.state) {
        case UIControlStateHighlighted:
        case UIControlStateSelected:
            strokeColor = [self titleColorForState:UIControlStateNormal] ? [self titleColorForState:UIControlStateNormal].CGColor : [UIColor blackColor].CGColor;
            fillColor = [self titleColorForState:UIControlStateNormal] ? [self titleColorForState:UIControlStateNormal].CGColor : [UIColor blackColor].CGColor;
            break;
        case UIControlStateDisabled:
            strokeColor = [self titleColorForState:UIControlStateDisabled] ? [self titleColorForState:UIControlStateDisabled].CGColor : [UIColor blackColor].CGColor;
            fillColor = [self titleColorForState:UIControlStateDisabled] ? [self titleColorForState:UIControlStateDisabled].CGColor : [UIColor blackColor].CGColor;
            break;
        default:
            strokeColor = [self titleColorForState:UIControlStateNormal] ? [self titleColorForState:UIControlStateNormal].CGColor : [UIColor blackColor].CGColor;
            fillColor = [UIColor clearColor].CGColor;
            break;
    }
    
    CGContextSetFillColorWithColor(contextRef, fillColor);
    CGContextSetStrokeColorWithColor(contextRef, strokeColor);
    
    CGContextSaveGState(contextRef);
    
    CGFloat borderWidth = 2.0f;
    
    CGContextSetLineWidth(contextRef, borderWidth);
        
    UIBezierPath *outlinePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, borderWidth, borderWidth) cornerRadius:self.bounds.size.height/2];
        
    CGContextAddPath(contextRef, outlinePath.CGPath);
    CGContextStrokePath(contextRef);
        
    CGContextRestoreGState(contextRef);
    
    if (self.highlighted) {
        CGContextSaveGState(contextRef);
        UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, borderWidth * 2.5, borderWidth * 2.5) cornerRadius:self.bounds.size.height/2];
        
        CGContextAddPath(contextRef, fillPath.CGPath);
        CGContextFillPath(contextRef);
        
        CGContextRestoreGState(contextRef);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

//------------------------------------------------------------------------------------
#pragma mark - UIButton Methods
//------------------------------------------------------------------------------------

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self setNeedsDisplay];
}

@end

//------------------------------------------------------------------------------------