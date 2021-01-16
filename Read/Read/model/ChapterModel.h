
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChapterModel : NSObject
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL unreadble;
@property (nonatomic,strong) NSMutableArray *pageArray;
//***************辅助属性********************//
//第几章
@property (nonatomic, assign) NSInteger chapter;
//第几页
@property (nonatomic, assign) NSInteger page;
-(void)updateFont;
-(NSString *)stringOfPage:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
