
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject
@property (nonatomic, assign) NSInteger bookCount;
@property (nonatomic, strong) NSArray *bookCover;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) NSInteger monthlyCount;
@property (nonatomic, strong) NSString *name;

@end


@interface BookModel : NSObject
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *shortIntro;

@end


@interface CategoryModel : NSObject
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSMutableArray *mins;
@end

@interface ListModel : NSObject
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSMutableArray *books;
@property (nonatomic, strong) NSString *ok;
@end

@interface RankModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *shortIntro;
@property (nonatomic, strong) NSString *majorCate;
@property (nonatomic, strong) NSString *minorCate;
@end

@interface RankTypeModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *_id;

@end


NS_ASSUME_NONNULL_END
