//
//  CVTableBackgroundView.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 11.04.14.
//
//

//------------------------------------------------------------------------------------

#import "CVTableBackgroundView.h"

//------------------------------------------------------------------------------------

@implementation CVTableBackgroundView

//------------------------------------------------------------------------------------
#pragma mark - UIView Methods
//------------------------------------------------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor colorWithWhite:0.949f alpha:1.0f];;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        self.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    UIBezierPath *linePath = [UIBezierPath bezierPathWithRect:CGRectMake(13.0f, 0.0f, 1.0f, self.bounds.size.height)];
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.831f alpha:1.0f].CGColor);
    CGContextAddPath(context, linePath.CGPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

@end
