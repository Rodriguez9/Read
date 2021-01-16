#import "BaseViewController.h"
#import "JGComicHead.h"
NS_ASSUME_NONNULL_BEGIN

@interface JGComicViewController : BaseViewController
@property (nonatomic,strong) NSString *bookName;
@property (nonatomic,strong) NSString *shortIntro;
@property (nonatomic,strong) NSString *majorCate;
@property (nonatomic,strong) NSString *minorCate;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *cover;
@property (nonatomic,strong) JGComicHead *ComicHead;
@property (nonatomic,strong) UITextView *ShortIntroText;
@property (nonatomic,strong) UIImageView *backImg;
@property (nonatomic,strong) UIButton *ReadButton;
@property (nonatomic,strong) UIView *separate;
- (instancetype)init:(NSString*)bookName cover:(NSString*)cover author:(NSString*)author major:(NSString*)major minor:(NSString*)minor shortIntro:(NSString *)shortIntro;
@end

NS_ASSUME_NONNULL_END
