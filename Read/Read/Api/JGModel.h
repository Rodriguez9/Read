
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGModel : NSObject
@property (nonatomic, assign) NSInteger bookCount;
@property (nonatomic, strong) NSArray *bookCover;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) NSInteger monthlyCount;
@property (nonatomic, strong) NSString *name;

@end


@interface JGBookModel : NSObject
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *shortIntro;

@end


@interface JGCategoryModel : NSObject
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSMutableArray *mins;
@end

@interface JGListModel : NSObject
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSMutableArray *books;
@property (nonatomic, strong) NSString *ok;
@end

@interface JGRankModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *shortIntro;
@property (nonatomic, strong) NSString *majorCate;
@property (nonatomic, strong) NSString *minorCate;
@end


NS_ASSUME_NONNULL_END
