
#import "BmwTopMenuView.h"
#import "BmwConst_UI.h"

@interface BmwTopMenuView()
@property (nonatomic,strong) UIButton *backButton;
@end

@implementation BmwTopMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    [self setBackgroundColor:BmwColor(0, 0, 0, 0.8)];
    [self addSubview:self.backButton];
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)backView{
    [[self getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton *)commonButtonSEL:(SEL)sel target:(id)target
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [self commonButtonSEL:@selector(backView) target:self];
        _backButton.frame = CGRectMake(0,15 + HEIGHT_NAVADD_FIT, 40, 40);
        [_backButton setImage:[UIImage imageNamed:@"bg_back_white"] forState:UIControlStateNormal];
        
    }
    return _backButton;
}
@end
