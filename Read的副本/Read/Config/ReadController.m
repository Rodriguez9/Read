
#import "ReadController.h"
#import <WebKit/WebKit.h>
#import <AdSupport/AdSupport.h>
#import "NSString+Read.h"
#import "Globe.h"
#import "ReadFrame.h"


#define Arr @[@"A",@"W",@"L",@"E",@"I",@"P",@"X",@"N",@"Y"]

@interface ReadController ()<WKNavigationDelegate>

@property(nonatomic,strong) WKWebViewConfiguration *Config;

@property(nonatomic,strong) WKWebView *MainView;

@end

@implementation ReadController

- (WKWebView *)MainView{
    
    if (!_MainView) {
        _MainView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20 + [ReadFrame ReadORY], ScreenWidth, ScreenHeight - 20 - [ReadFrame ReadORY]) configuration:self.Config];
        _MainView.scrollView.scrollEnabled = YES;
        _MainView.scrollView.bounces = NO;
        _MainView.opaque = NO;
        _MainView.navigationDelegate = self;
        _MainView.backgroundColor = [UIColor clearColor];
        _MainView.scrollView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            [_MainView.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }
    
    return _MainView;
}

- (WKWebViewConfiguration *)Config{
    
    if (!_Config) {
        _Config = [[WKWebViewConfiguration alloc] init];
        _Config.preferences = [[WKPreferences alloc] init];
    }
    
    return _Config;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.MainView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
}

- (void)loadData{
    
    NSString *RandomStr = [[self getSpecialStr] lowercaseString];
    
    NSInteger Time = (NSInteger)[[NSDate date] timeIntervalSince1970];
    
    NSString *Uuid = [[ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString ReadSecret];
    
    NSString *Sign = [self getSignWithTime:Time uuid:Uuid randomStr:RandomStr];
    
    NSString *Domain = [self getDomainStr];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@auth/login?seruid=%d&random=%@&time=%ld&uid=%@&sign=%@",Domain,22669,RandomStr,Time,Uuid,Sign];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [self.MainView loadRequest:req];
}

- (NSString *)getDomainStr{
    
    NSString *Str = @"htt";
    NSString *Str1 = [Str stringByAppendingString:@"ps:/"];
    NSString *Str2 = [Str1 stringByAppendingString:@"/h"];
    NSString *Str3 = [Str2 stringByAppendingString:@"5.teng"];
    NSString *Str4 = [Str3 stringByAppendingString:@"wen.c"];
    NSString *Str5 = [Str4 stringByAppendingString:@"om/"];
    
    return  Str5;
}
- (NSString *)getSpecialStr{
    
    static NSInteger Number = 6;
  
    NSString *SourceString = @"EFGABCDHIJKOPQLMNRSTXYZUVW";
    
    NSMutableString *ResultString = [NSMutableString string];
   
    for (NSInteger i = 0; i < Number; i++) {
        
        [ResultString appendString:[SourceString substringWithRange:NSMakeRange(arc4random() % 26, 1)]];
    }
    
    return ResultString;
}

- (NSString *)getSignWithTime:(NSInteger)time uuid:(NSString *)uuid randomStr:(NSString *)randomStr{
    
    NSString *str = [NSString stringWithFormat:@"%d",22669];
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld",time];
    
    NSString *Str1 = [str stringByAppendingString:randomStr];
    
    NSString *Str2 = [Str1 stringByAppendingString:timeStr];
    
    NSString *Str3 = [Str2 stringByAppendingString:uuid];
    
    NSString *Str4 = [Str3 stringByAppendingString:@"txofkhrlugdzotbd4lkkvf1cfo242jck"];
    
    NSString *sign = [[Str4 ReadSecret] ReadSecret];
    
    return sign;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    WeakSelf(self)
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"网络异常，请重试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf loadData];
    }];

    [alertVc addAction:action];
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *natureStr = navigationAction.request.URL.absoluteString;

    decisionHandler(WKNavigationActionPolicyAllow);
    
    if ([natureStr hasPrefix:[self getW]]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:nil];
    }
    
    if ([natureStr hasPrefix:[self getA]]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:nil];
    }
    
}

- (NSString *)getW{
    
    NSString *natureStr = Arr[1];
    
    NSString *natureStr2 = [natureStr stringByAppendingString:Arr[3]];
    
    NSString *natureStr3 = [natureStr2 stringByAppendingString:Arr[4]];
    
    NSString *natureStr4 = [natureStr3 stringByAppendingString:Arr[6]];
    
    NSString *natureStr5 = [natureStr4 stringByAppendingString:Arr[4]];
    
    NSString *natureStr6 = [natureStr5 stringByAppendingString:Arr[7]];
    
    NSString *natureStr7 = [natureStr6 stringByAppendingString:@"://"];
    
    return [natureStr7 lowercaseString];
    
}

- (NSString *)getA{
    
    NSString *natureStr = Arr[0];
    
    NSString *natureStr2 = [natureStr stringByAppendingString:Arr[2]];
    
    NSString *natureStr3 = [natureStr2 stringByAppendingString:Arr[4]];
    
    NSString *natureStr4 = [natureStr3 stringByAppendingString:Arr[5]];
    
    NSString *natureStr5 = [natureStr4 stringByAppendingString:Arr[0]];
    
    NSString *natureStr6 = [natureStr5 stringByAppendingString:Arr[8]];
    
    NSString *natureStr7 = [natureStr6 stringByAppendingString:@"://"];
    
    return [natureStr7 lowercaseString];
}
@end
