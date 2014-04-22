//
//  CVBubbleView.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 12.04.14.
//
//

//------------------------------------------------------------------------------------

#import "CVBubbleView.h"

//------------------------------------------------------------------------------------

@implementation CVBubbleView

//------------------------------------------------------------------------------------
#pragma mark - UIView Methods
//------------------------------------------------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:CGRectMake(9.0f, 0.0f, self.bounds.size.width - 9.0f, self.bounds.size.height) cornerRadius:3.5f].CGPath);
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    
    CGPoint firstPoint = CGPointMake(9.0f, self.bounds.size.height/2-7.0f);
    CGPoint secondPoint = CGPointMake(9.0f, self.bounds.size.height/2+7.0f);
    CGPoint thirdPoint = CGPointMake(0.0f, self.bounds.size.height/2);
    
    [trianglePath moveToPoint:firstPoint];
    [trianglePath addLineToPoint:secondPoint];
    [trianglePath addLineToPoint:thirdPoint];
    [trianglePath closePath];
        
    CGContextAddPath(context, trianglePath.CGPath);
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
