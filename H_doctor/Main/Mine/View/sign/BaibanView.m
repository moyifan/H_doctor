

#import "BaibanView.h"


@interface BaibanView()

@property (nonatomic,strong) NSMutableArray  *beziPathArrM;


@end


@implementation BaibanView

-(NSMutableArray *)beziPathArrM{
    if(_beziPathArrM==nil){
        _beziPathArrM=[NSMutableArray array];
    }
    return  _beziPathArrM;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.lineColor = [UIColor blackColor];
    
    }
    return self;
}


#pragma mark - 操作栏方法
//撤销
- (void)btnPreviewActionClick {
    if(self.beziPathArrM.count>0){
        [self.beziPathArrM removeObjectAtIndex:self.beziPathArrM.count-1];
        [self setNeedsDisplay];
    }
}

// 清空
- (void)clear
{
    [self.beziPathArrM removeAllObjects];
    [self setNeedsDisplay];
}

// 橡皮擦
- (void)btnXPCClick {
    self.isErase = YES;
}

// 返回图片
- (UIImage *)capImage {
    
    UIImage *currentImg = [self captureImageFromView:self];

    return currentImg;
}


-(UIImage *)captureImageFromView:(UIView *)view
{
    CGRect screenRect = view.bounds;////CGRectMake(0, 108, KScreenWidth, KScreenHeight - 108 - 49);
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}



#pragma mark - 画画
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    self.bezierPath = [[BezierPath alloc] init];
    self.bezierPath.lineColor = self.lineColor;
    self.bezierPath.isErase = self.isErase;
    [self.bezierPath moveToPoint:currentPoint];
    
    [self.beziPathArrM addObject:self.bezierPath];
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    CGPoint previousPoint = [touch previousLocationInView:self];
    CGPoint midP = midpoint(previousPoint,currentPoint);
    //  这样写不会有尖头
    [self.bezierPath addQuadCurveToPoint:currentPoint controlPoint:midP];
    [self setNeedsDisplay];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    CGPoint midP = midpoint(previousPoint,currentPoint);
    [self.bezierPath addQuadCurveToPoint:currentPoint   controlPoint:midP];
    // touchesMoved
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect{
    
    if (self.beziPathArrM.count) {
        for (BezierPath *path in self.beziPathArrM) {
            if (path.isErase) {
                
                [self.backgroundColor setStroke];
            
            }else{
                [path.lineColor setStroke];
            }
            
            
            path.lineCapStyle = kCGLineCapRound;
            path.lineJoinStyle = kCGLineCapRound;
            if (path.isErase) {
                path.lineWidth = 10;    //   这里可抽取出来枚举定义
                [path strokeWithBlendMode:kCGBlendModeDestinationIn alpha:1.0];
            }else{
                path.lineWidth = 5;
                [path strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
            }
            [path stroke];
            
        }
        
    }
    
    
    [super drawRect:rect];
}

static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}


@end
