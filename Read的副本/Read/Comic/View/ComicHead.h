#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComicHead : UIView
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) NSArray <UILabel *> *labels;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) UILabel *shortIntroLabel;

- (instancetype)init:(NSString*)bookName coverImg:(NSString*)cover shortIntro:(NSString*)shortIntro;
@end

NS_ASSUME_NONNULL_END
