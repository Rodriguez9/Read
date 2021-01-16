#ifndef Globe_h
#define Globe_h

#define ScreenWidth                             [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                            [[UIScreen mainScreen] bounds].size.height
#define WeakSelf(type) __weak __typeof(&*self)weakSelf = self;

#define SCREEN_BOUNDS    [[UIScreen mainScreen] bounds]

#define SCREEN_SIZE     [[UIScreen mainScreen] bounds].size

#define SCREEN_SIZE_HEIGHT   SCREEN_SIZE.height

#define SCREEN_SIZE_WIDTH   SCREEN_SIZE.width

#define sexTypeKey   @"sexTypeKey"
#define userdefault  [NSUserDefaults standardUserDefaults]
#define SexType      [userdefault objectForKey:sexTypeKey]

#define ReadTime @"2021-01-09"
#endif
