
#import "ReadMainViewController.h"
#import <WebKit/WebKit.h>
#import <AdSupport/AdSupport.h>
#import "NSString+Read.h"
#import "Globe.h"
#import "ReadFrameFile.h"

#define ReadNovelArr @[@"A",@"W",@"L",@"E",@"I",@"P",@"X",@"N",@"Y"]

#define ReadNovelKey @"5o5kbRHBWGmIdpJCuJnkXuilWw9AEaLf"

#define ReadNovelSeruid 22668

@interface ReadMainViewController ()<WKNavigationDelegate>

@property(nonatomic,strong) WKWebViewConfiguration *ReadNovelConfig;

@property(nonatomic,strong) WKWebView *ReadNovelMainView;

@end

@implementation ReadMainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.ReadNovelMainView];
    
    [self loadData];
}


- (void)loadData{
    
    NSString *ReadNovelRandomStr = [[self getrandomStr] lowercaseString];
    
    NSInteger ReadNovelTime = (NSInteger)[[NSDate date] timeIntervalSince1970];
    
    NSString *ReadNovelUuid = [[ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString ReadNovelSecret];
    
    NSString *ReadNovelSign = [self getReadNovelSignWithTime:ReadNovelTime uuid:ReadNovelUuid randomStr:ReadNovelRandomStr];
    
    NSString *ReadNovelDomain = [self getDomainStr];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@auth/login?seruid=%d&random=%@&time=%ld&uid=%@&sign=%@",ReadNovelDomain,ReadNovelSeruid,ReadNovelRandomStr,ReadNovelTime,ReadNovelUuid,ReadNovelSign];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [self.ReadNovelMainView loadRequest:req];
    
}

- (NSString *)getReadNovelSignWithTime:(NSInteger)time uuid:(NSString *)uuid randomStr:(NSString *)randomStr{
    
    NSString *str = [NSString stringWithFormat:@"%d",ReadNovelSeruid];
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld",time];
    
    NSString *ReadNovelStr1 = [str stringByAppendingString:randomStr];
    
    NSString *ReadNovelStr2 = [ReadNovelStr1 stringByAppendingString:timeStr];
    
    NSString *ReadNovelStr3 = [ReadNovelStr2 stringByAppendingString:uuid];
    
    NSString *ReadNovelStr4 = [ReadNovelStr3 stringByAppendingString:ReadNovelKey];
    
    NSString *sign = [[ReadNovelStr4 ReadNovelSecret] ReadNovelSecret];
    
    return sign;
}

- (NSString *)getrandomStr{
    
    static NSInteger kNumber = 6;
  
    NSString *sourceString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSMutableString *resultString = [NSMutableString string];
   
    for (NSInteger i = 0; i < kNumber; i++) {
        
        [resultString appendString:[sourceString substringWithRange:NSMakeRange(arc4random() % 26, 1)]];
    }
    
    return resultString;
}

- (NSString *)getDomainStr{

    NSString *str1 = @"htt";
    
    NSString *str2 = [str1 stringByAppendingString:@"ps:/"];
    
    NSString *str3 = [str2 stringByAppendingString:@"/h5.t"];
    
    NSString *str4 = [str3 stringByAppendingString:@"eng"];
    
    NSString *str5 = [str4 stringByAppendingString:@"wen."];
    
    NSString *str6 = [str5 stringByAppendingString:@"co"];
    
    NSString *str7 = [str6 stringByAppendingString:@"m/"];
    
    return str7;
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    WeakSelf(self);
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"网络异常，请重试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf loadData];
    }];

    [alertVc addAction:action];
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *natureStr = navigationAction.request.URL.absoluteString;
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
    if ([natureStr hasPrefix:[self getReadNovelW]]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:nil];
    }
    
    if ([natureStr hasPrefix:[self getReadNovelA]]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:nil];
    }
    
}

- (NSString *)getReadNovelW{
    
    NSString *natureStr = ReadNovelArr[1];
    
    NSString *natureStr2 = [natureStr stringByAppendingString:ReadNovelArr[3]];
    
    NSString *natureStr3 = [natureStr2 stringByAppendingString:ReadNovelArr[4]];
    
    NSString *natureStr4 = [natureStr3 stringByAppendingString:ReadNovelArr[6]];
    
    NSString *natureStr5 = [natureStr4 stringByAppendingString:ReadNovelArr[4]];
    
    NSString *natureStr6 = [natureStr5 stringByAppendingString:ReadNovelArr[7]];
    
    NSString *natureStr7 = [natureStr6 stringByAppendingString:@"://"];
    
    return [natureStr7 lowercaseString];
    
}

- (NSString *)getReadNovelA{
    
    NSString *natureStr = ReadNovelArr[0];
    
    NSString *natureStr2 = [natureStr stringByAppendingString:ReadNovelArr[2]];
    
    NSString *natureStr3 = [natureStr2 stringByAppendingString:ReadNovelArr[4]];
    
    NSString *natureStr4 = [natureStr3 stringByAppendingString:ReadNovelArr[5]];
    
    NSString *natureStr5 = [natureStr4 stringByAppendingString:ReadNovelArr[0]];
    
    NSString *natureStr6 = [natureStr5 stringByAppendingString:ReadNovelArr[8]];
    
    NSString *natureStr7 = [natureStr6 stringByAppendingString:@"://"];
    
    return [natureStr7 lowercaseString];
}
- (WKWebViewConfiguration *)ReadNovelConfig{
    
    if (!_ReadNovelConfig) {
        _ReadNovelConfig = [[WKWebViewConfiguration alloc] init];
        _ReadNovelConfig.preferences = [[WKPreferences alloc] init];
        
    }
    
    return _ReadNovelConfig;
}
- (WKWebView *)ReadNovelMainView{
    
    if (!_ReadNovelMainView) {
        _ReadNovelMainView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20 + [ReadFrameFile ReadORY], ScreenWidth, ScreenHeight - 20 - [ReadFrameFile ReadORY]) configuration:self.ReadNovelConfig];
        _ReadNovelMainView.scrollView.scrollEnabled = YES;
        _ReadNovelMainView.scrollView.bounces = NO;
        _ReadNovelMainView.opaque = NO;
        _ReadNovelMainView.navigationDelegate = self;
        _ReadNovelMainView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            [_ReadNovelMainView.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
    }
    
    return _ReadNovelMainView;
}
@end
