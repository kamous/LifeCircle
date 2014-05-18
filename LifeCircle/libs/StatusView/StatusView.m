
#import "StatusView.h"
#import <QuartzCore/QuartzCore.h>

@implementation StatusView

+ (id)statusViewInView:(UIView *)aSuperview withText:(NSString *)statusText width:(NSInteger)width height:(NSInteger)height color:(UIColor *)color y:(NSInteger)y{
	StatusView *statusView =  
	//[[StatusView alloc] initWithFrame:CGRectMake((rect.size.width-width)/2, (rect.size.height-height)/2, width, height)];
    [[StatusView alloc] initWithFrame:CGRectMake((aSuperview.frame.size.width - width) / 2, y , width, height)];
    
    if (!statusView)  
    {  
        return nil;  
    }  
	
    statusView.opaque = NO;  
    statusView.autoresizingMask =  
	UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
    [aSuperview addSubview:statusView];  
	
    CGSize size = [statusText sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0f] constrainedToSize:CGSizeMake(width-20, height-20) lineBreakMode:UILineBreakModeWordWrap];
    
    
    UILabel *statusLabel =  
	[[UILabel alloc]  
	  initWithFrame:CGRectMake((width - size.width)/2, (height - size.height)/2, size.width, size.height)];
    statusLabel.layer.cornerRadius = 2.0;
    statusLabel.text = statusText;  
    statusLabel.textColor = [UIColor whiteColor];  
    statusLabel.backgroundColor = color;
    statusLabel.textAlignment = UITextAlignmentCenter;  
    statusLabel.numberOfLines = 0;
    statusLabel.lineBreakMode = UILineBreakModeWordWrap;
    statusLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    statusLabel.autoresizingMask =  
	UIViewAutoresizingFlexibleLeftMargin |  
	UIViewAutoresizingFlexibleRightMargin |  
	UIViewAutoresizingFlexibleTopMargin |  
	UIViewAutoresizingFlexibleBottomMargin;  
	
    [statusView addSubview:statusLabel];
	
    // Set up the fade-in animation  
    CATransition *animation = [CATransition animation];  
    [animation setType:kCATransitionFade];  
    [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];  
	
    return statusView;
}

- (void)removeView{
	UIView *aSuperview = [self superview];  
    [super removeFromSuperview];  
	
    // Set up the animation  
    CATransition *animation = [CATransition animation];  
    [animation setType:kCATransitionFade];  
	
    [[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"]; 
}

- (void)drawRect:(CGRect)rect  
{  
    rect.size.height -= 1;  
    rect.size.width -= 1;  
	
    const CGFloat RECT_PADDING = 8.0;  
    rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);  
	
    const CGFloat ROUND_RECT_CORNER_RADIUS = 5.0;  
    CGPathRef roundRectPath;
	
	
	//  
    // Create the boundary path  
    //  
    CGMutablePathRef path = CGPathCreateMutable();  
    CGPathMoveToPoint(path, NULL,  
					  rect.origin.x,  
					  rect.origin.y + rect.size.height - ROUND_RECT_CORNER_RADIUS);  
	
    // Top left corner  
    CGPathAddArcToPoint(path, NULL,  
						rect.origin.x,  
						rect.origin.y,  
						rect.origin.x + rect.size.width,  
						rect.origin.y,  
						ROUND_RECT_CORNER_RADIUS);  
	
    // Top right corner  
    CGPathAddArcToPoint(path, NULL,  
						rect.origin.x + rect.size.width,  
						rect.origin.y,  
						rect.origin.x + rect.size.width,  
						rect.origin.y + rect.size.height,  
						ROUND_RECT_CORNER_RADIUS);  
	
    // Bottom right corner  
    CGPathAddArcToPoint(path, NULL,  
						rect.origin.x + rect.size.width,  
						rect.origin.y + rect.size.height,  
						rect.origin.x,  
						rect.origin.y + rect.size.height,  
						ROUND_RECT_CORNER_RADIUS);  
	
    // Bottom left corner  
    CGPathAddArcToPoint(path, NULL,  
						rect.origin.x,  
						rect.origin.y + rect.size.height,  
						rect.origin.x,  
						rect.origin.y,  
						ROUND_RECT_CORNER_RADIUS);  
	
    // Close the path at the rounded rect  
    CGPathCloseSubpath(path);
	
	roundRectPath = path;
	
	
    CGContextRef context = UIGraphicsGetCurrentContext();  
	
    const CGFloat BACKGROUND_OPACITY = 0.85;  
    CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);  
    CGContextAddPath(context, roundRectPath);  
    CGContextFillPath(context);  
	
    const CGFloat STROKE_OPACITY = 0.25;  
    CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);  
    CGContextAddPath(context, roundRectPath);  
    CGContextStrokePath(context);  
	
    CGPathRelease(roundRectPath);  
} 



@end
