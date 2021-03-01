#ifndef Globe_h
#define Globe_h

#define ScreenWidth                             [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                            [[UIScreen mainScreen] bounds].size.height
#define WeakSelf(type) __weak __typeof(&*self)weakSelf = self;

#define SCREEN_BOUNDS    [[UIScreen mainScreen] bounds]

#define SCREEN_SIZE     [[UIScreen mainScreen] bounds].size

#define SCREEN_SIZE_HEIGHT   SCREEN_SIZE.height

#define SCREEN_SIZE_WIDTH   SCREEN_SIZE.width

#define bookshelfKey      @"bookKey"
#define userdefault  [NSUserDefaults standardUserDefaults]
#define SexType      [userdefault objectForKey:sexTypeKey]
#define bookshelf      [userdefault objectForKey:bookshelfKey]
#define MinPixel    1/[UIScreen mainScreen].scale
#define ReadTime @"2021-02-26"
#endif
