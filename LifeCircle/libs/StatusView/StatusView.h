
#import <UIKit/UIKit.h>

@interface StatusView : UIView
{
}

+ (id)statusViewInView:(UIView *)aSuperview withText:(NSString *)statusText width:(NSInteger)width height:(NSInteger)height color:(UIColor*)color  y:(NSInteger)y;//inFrame:(CGRect)rect

- (void)removeView;

@end
