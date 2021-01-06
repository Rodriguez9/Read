
#import "BmwReadTool.h"
#import "BmwConst_UI.h"

@implementation BmwReadTool

+(instancetype)shareInstance
{
    static BmwReadTool *readConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        readConfig = [[self alloc] init];
        
    });
    return readConfig;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"BmwReadTool"];
        if (data) {
            NSKeyedUnarchiver *unarchive = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
            BmwReadTool *config = [unarchive decodeObjectForKey:@"BmwReadTool"];
            [config addObserver:config forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
            [config addObserver:config forKeyPath:@"lineSpace" options:NSKeyValueObservingOptionNew context:NULL];
            [config addObserver:config forKeyPath:@"fontColor" options:NSKeyValueObservingOptionNew context:NULL];
            [config addObserver:config forKeyPath:@"theme" options:NSKeyValueObservingOptionNew context:NULL];
            return config;
        }
        _lineSpace = 10.0f;
        _fontSize = 14.0f;
        _fontColor = [UIColor blackColor];
        _theme = BmwColor(248, 218, 138,1.0);
        [self addObserver:self forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"lineSpace" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"fontColor" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:self forKeyPath:@"theme" options:NSKeyValueObservingOptionNew context:NULL];
        [BmwReadTool updateLocalConfig:self];
        
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [BmwReadTool updateLocalConfig:self];
}
+(void)updateLocalConfig:(BmwReadTool *)config
{
    NSMutableData *data=[[NSMutableData alloc]init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:config forKey:@"ReadConfig"];
    [archiver finishEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"ReadConfig"];
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:self.fontSize forKey:@"fontSize"];
    [aCoder encodeDouble:self.lineSpace forKey:@"lineSpace"];
    [aCoder encodeObject:self.fontColor forKey:@"fontColor"];
    [aCoder encodeObject:self.theme forKey:@"theme"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.fontSize = [aDecoder decodeDoubleForKey:@"fontSize"];
        self.lineSpace = [aDecoder decodeDoubleForKey:@"lineSpace"];
        self.fontColor = [aDecoder decodeObjectForKey:@"fontColor"];
        self.theme = [aDecoder decodeObjectForKey:@"theme"];
    }
    return self;
}

+(CTFrameRef)parserContent:(NSString *)content config:(BmwReadTool *)parser bouds:(CGRect)bounds
{
    if (!content) return nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSDictionary *attribute = [self parserAttribute:parser];
    [attributedString setAttributes:attribute range:NSMakeRange(0, content.length)];
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    CGPathRef pathRef = CGPathCreateWithRect(bounds, NULL);
    CTFrameRef frameRef = CTFramesetterCreateFrame(setterRef, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(setterRef);
    CFRelease(pathRef);
    return frameRef;
    
}

+(NSDictionary *)parserAttribute:(BmwReadTool *)config
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = config.fontColor;
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:config.fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = config.lineSpace;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    dict[NSParagraphStyleAttributeName] = paragraphStyle;
    return [dict copy];
}
@end
