//
//  AppStoreButton.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 11.04.14.
//
//

//------------------------------------------------------------------------------------

#import "AppStoreButton.h"

//------------------------------------------------------------------------------------

@implementation AppStoreButton

//------------------------------------------------------------------------------------
#pragma mark - UIView Methods
//------------------------------------------------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
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
    
    CGFloat borderWidth = 1.0f;
    
    CGContextSetLineWidth(contextRef, borderWidth);
    
    UIBezierPath *outlinePath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, borderWidth, borderWidth) cornerRadius:self.bounds.size.height/8];
    
    CGContextAddPath(contextRef, outlinePath.CGPath);
    CGContextStrokePath(contextRef);
    
    CGContextRestoreGState(contextRef);
    
    if (self.highlighted || self.selected) {
        CGContextSaveGState(contextRef);
        UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 0 , 0) cornerRadius:self.bounds.size.height/8];
        
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