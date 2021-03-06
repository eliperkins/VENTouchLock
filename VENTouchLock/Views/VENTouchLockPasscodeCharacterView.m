#import "VENTouchLockPasscodeCharacterView.h"

@interface VENTouchLockPasscodeCharacterView ()

@property (strong, nonatomic) CAShapeLayer *circle;
@property (strong, nonatomic) CAShapeLayer *hyphen;

@end

@implementation VENTouchLockPasscodeCharacterView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _isEmpty = YES;
        self.backgroundColor = [UIColor clearColor];
        [self drawCircle];
        [self drawHyphen];
        [self redraw];
    }
    return self;
}

- (void)redraw
{
    self.circle.hidden = self.isEmpty;
    self.hyphen.hidden = !self.isEmpty;
}

- (void)drawCircle
{
    CGFloat borderWidth = 2;
    CGFloat radius = (CGRectGetWidth(self.bounds) - borderWidth) / 2;
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)

                                             cornerRadius:radius].CGPath;
    UIColor *circleColor = [UIColor blackColor];
    circle.fillColor = circleColor.CGColor;
    circle.strokeColor =  circleColor.CGColor;
    circle.borderWidth = borderWidth;
    [self.layer addSublayer:circle];
    self.circle = circle;
}

- (void)drawHyphen
{
    CGFloat hyphenHeight = CGRectGetHeight(self.bounds) / 7;
    CAShapeLayer *hyphen = [CAShapeLayer layer];
    UIBezierPath *hyphenPath = [UIBezierPath bezierPath];

    CGPoint leftTopCorner = CGPointMake(0, 3 * hyphenHeight);
    CGPoint rightTopCorner = CGPointMake(CGRectGetWidth(self.bounds), 3 * hyphenHeight);
    CGPoint rightBottomCorner = CGPointMake(CGRectGetWidth(self.bounds), 4 * hyphenHeight);
    CGPoint leftBottomCorner = CGPointMake(0, 4 * hyphenHeight);

    [hyphenPath moveToPoint:leftTopCorner];
    [hyphenPath addLineToPoint:rightTopCorner];
    [hyphenPath addLineToPoint:rightBottomCorner];
    [hyphenPath addLineToPoint:leftBottomCorner];

    hyphen.path = hyphenPath.CGPath;
    UIColor *hyphenColor = [UIColor blackColor];
    hyphen.fillColor = hyphenColor.CGColor;
    hyphen.strokeColor = hyphenColor.CGColor;
    [self.layer addSublayer:hyphen];
    self.hyphen = hyphen;
}

- (void)setIsEmpty:(BOOL)isEmpty {
    if (_isEmpty != isEmpty) {
        _isEmpty = isEmpty;
        [self redraw];
    }
}

@end