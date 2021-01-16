#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGComicHead : UIView
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UILabel *shortIntroLabel;
@property (nonatomic,strong) UILabel *majorCate;
@property (nonatomic,strong) UILabel *minorCate;
@property (nonatomic,strong) UILabel *authorLabel;
@property (nonatomic,strong) NSArray <UILabel *> *labels;
@property (nonatomic,strong) UIImageView *coverImg;

- (instancetype)init:(NSString*)bookName coverImg:(NSString*)cover author:(NSString*)author major:(NSString*)major minor:(NSString*)minor;
@end

NS_ASSUME_NONNULL_END
