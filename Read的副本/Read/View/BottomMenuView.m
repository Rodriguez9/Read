
#import "BottomMenuView.h"
#import "ThemView.h"
#import "ReadTool.h"
#import "Const_UI.h"
#import "MenuView.h"
#import "UIView+JZExtension.h"


#define MinFontSize 11.0f
#define MaxFontSize 20.0f
@interface BottomMenuView()
@property (nonatomic, strong) ThemView *themeView;
@property (nonatomic,strong) UIButton *catalog;
@property (nonatomic,strong) UIButton *increaseFont;
@property (nonatomic,strong) UIButton *decreaseFont;
@property (nonatomic,strong) UILabel *fontLabel;
@end
@implementation BottomMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [self addSubview:self.increaseFont];
    [self addSubview:self.decreaseFont];
    [self addSubview:self.fontLabel];
    [self addSubview:self.themeView];
    
    [[ReadTool shareInstance] addObserver:self forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
}


- (UIButton *)commonButtonSEL:(SEL)sel target:(id)target
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(UIButton *)increaseFont
{
    if (!_increaseFont) {
        _increaseFont = [self commonButtonSEL:@selector(changeFont:) target:self];
        [_increaseFont setTitle:@"A+" forState:UIControlStateNormal];
        [_increaseFont.titleLabel setFont:[UIFont systemFontOfSize:17]];
        _increaseFont.layer.cornerRadius = 20;
        _increaseFont.layer.borderWidth = 1;
        _increaseFont.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _increaseFont;
}
-(UIButton *)decreaseFont
{
    if (!_decreaseFont) {
        _decreaseFont = [self commonButtonSEL:@selector(changeFont:) target:self];
        [_decreaseFont setTitle:@"A-" forState:UIControlStateNormal];
        [_decreaseFont.titleLabel setFont:[UIFont systemFontOfSize:17]];
        _decreaseFont.layer.cornerRadius = 20;
        _decreaseFont.layer.borderWidth = 1;
        _decreaseFont.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _decreaseFont;
}
-(UILabel *)fontLabel
{
    if (!_fontLabel) {
        _fontLabel = [[UILabel alloc] init];
        _fontLabel.font = [UIFont systemFontOfSize:22];
        _fontLabel.textColor = [UIColor whiteColor];
        _fontLabel.textAlignment = NSTextAlignmentCenter;
        _fontLabel.text = [NSString stringWithFormat:@"%d",(int)[ReadTool shareInstance].fontSize];
    }
    return _fontLabel;
}
-(ThemView *)themeView
{
    if (!_themeView) {
        _themeView = [[ThemView alloc] init];
    }
    return _themeView;
}


-(void)changeFont:(UIButton *)sender
{
    
    if (sender == _increaseFont) {
        
        if (floor([ReadTool shareInstance].fontSize) == floor(MaxFontSize)) {
            return;
        }
        [ReadTool shareInstance].fontSize++;
    }
    else{
        if (floor([ReadTool shareInstance].fontSize) == floor(MinFontSize)){
            return;
        }
        [ReadTool shareInstance].fontSize--;
    }
    
    if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
        [self.delegate menuViewFontSize:self];
    }
}
#pragma mark showMsg

-(void)changeMsg:(UISlider *)sender
{
    if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:sliderValue:)]) {
        [self.delegate menuViewJumpChapter:self sliderValue:sender.value];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"chapterModel.chapter"] || [keyPath isEqualToString:@"chapterModel.page"]) {
        
    }
    else if ([keyPath isEqualToString:@"fontSize"]){
        _fontLabel.text = [NSString stringWithFormat:@"%d",(int)[ReadTool shareInstance].fontSize];
    }
    else{
       
    }
    
}
-(UIImage *)thumbImage
{
    CGRect rect = CGRectMake(0, 0, 15,15);
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5;
    [path addArcWithCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:7.5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    {
        [[UIColor whiteColor] setFill];
        [path fill];
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    return image;
}
-(void)showCatalog
{
    if ([self.delegate respondsToSelector:@selector(menuViewInvokeCatalog:)]) {
        [self.delegate menuViewInvokeCatalog:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _themeView.frame = CGRectMake(0,20, self.jz_width, 40);
   
    _decreaseFont.frame = CGRectMake(self.jz_centerX - 135,self.themeView.jz_origin.y + self.themeView.jz_height + 20, 40, 40);
    
    _fontLabel.frame = CGRectMake(self.jz_centerX - (self.jz_width - 20)/6, self.themeView.jz_origin.y + self.themeView.jz_height + 25, (self.jz_width - 20)/3,  30);
    
    _increaseFont.frame = CGRectMake(self.jz_centerX + 95, self.themeView.jz_origin.y + self.themeView.jz_height+20,  40, 40);
    
    
}

-(void)dealloc
{
    [[ReadTool shareInstance] removeObserver:self forKeyPath:@"fontSize"];
}

@end
