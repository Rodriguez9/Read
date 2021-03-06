
#import "ChapterModel.h"
#import <CoreText/CoreText.h>
#import "Const_UI.h"
#import "ReadTool.h"

@implementation ChapterModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageArray = [NSMutableArray array];
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"content" : @"body"};
}

- (void)setContent:(NSString *)content{
    _content = content;
    [self paginateWithBounds:CGRectMake(20,40 + HEIGHT_NAVADD_FIT, WIDTH_SCREEN-20-20, HEIGHT_SCREEN-40-50 - HEIGHT_NAVADD_FIT - HEIGHT_NAVADD_FIT)];
    
}


-(void)updateFont
{
    [self paginateWithBounds:CGRectMake(20,40 + HEIGHT_NAVADD_FIT, WIDTH_SCREEN-20-20, HEIGHT_SCREEN-40-50 - HEIGHT_NAVADD_FIT)];
}


-(void)paginateWithBounds:(CGRect)bounds
{
    [_pageArray removeAllObjects];
    NSAttributedString *attrString;
    CTFramesetterRef frameSetter;
    CGPathRef path;
    NSMutableAttributedString *attrStr;
    attrStr = [[NSMutableAttributedString  alloc] initWithString:self.content];
    NSDictionary *attribute = [ReadTool parserAttribute:[ReadTool shareInstance]];
    [attrStr setAttributes:attribute range:NSMakeRange(0, attrStr.length)];
    attrString = [attrStr copy];
    frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attrString);
    path = CGPathCreateWithRect(bounds, NULL);
    int currentOffset = 0;
    int currentInnerOffset = 0;
    BOOL hasMorePages = YES;
    // 防止死循环，如果在同一个位置获取CTFrame超过2次，则跳出循环
    int preventDeadLoopSign = currentOffset;
    int samePlaceRepeatCount = 0;
    
    while (hasMorePages) {
        if (preventDeadLoopSign == currentOffset) {
            
            ++samePlaceRepeatCount;
            
        } else {
            
            samePlaceRepeatCount = 0;
        }
        
        if (samePlaceRepeatCount > 1) {
            // 退出循环前检查一下最后一页是否已经加上
            if (_pageArray.count == 0) {
                [_pageArray addObject:@(currentOffset)];
            }
            else {
                
                NSUInteger lastOffset = [[_pageArray lastObject] integerValue];
                
                if (lastOffset != currentOffset) {
                    [_pageArray addObject:@(currentOffset)];
                }
            }
            break;
        }
        
        [_pageArray addObject:@(currentOffset)];
        
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, NULL);
        CFRange range = CTFrameGetVisibleStringRange(frame);
        if ((range.location + range.length) != attrString.length) {
            
            currentOffset += range.length;
            currentInnerOffset += range.length;
            
        } else {
            // 已经分完，提示跳出循环
            hasMorePages = NO;
        }
        if (frame) CFRelease(frame);
    }
    
    CGPathRelease(path);
    CFRelease(frameSetter);
    _pageCount = _pageArray.count;
}
- (NSString *)stringOfPage:(NSUInteger)index
{
    if (index >= self.pageArray.count) return nil;
    NSUInteger local = [_pageArray[index] integerValue];
    NSUInteger length;
    if (index<self.pageCount-1) {
        length=  [_pageArray[index+1] integerValue] - [_pageArray[index] integerValue];
    }
    else{
        length = _content.length - [_pageArray[index] integerValue];
    }
    return [_content substringWithRange:NSMakeRange(local, length)];
}

@end
