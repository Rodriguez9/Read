
#ifndef Const_UI_h
#define Const_UI_h

#define iOS10_OR_LATER ( ([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0) ? YES : NO )

//尺寸
#define     SCREEN_RECT                 [UIScreen mainScreen].bounds
#define     SIZE_SCREEN                 SCREEN_RECT.size
#define     WIDTH_SCREEN                SIZE_SCREEN.width
#define     HEIGHT_SCREEN               SIZE_SCREEN.height
#define     HEIGHT_STATUSBAR            20.0f
#define     HEIGHT_TABBAR               49.0f
#define     HEIGHT_NAVBAR               44.0f
#define     NAVBAR_ITEM_FIXED_SPACE     5.0f
#define     HEIGHT_NAV                  (HEIGHT_NAVBAR + HEIGHT_STATUSBAR)

/** 各机型与i6的宽高比例系数  */
#define     HeightScale                     HEIGHT_SCREEN / 667
#define     WidthScale                      WIDTH_SCREEN / 375

/**************************************机型*****************************************/
#define     iPhone_X                        (HEIGHT_SCREEN == 812 || HEIGHT_SCREEN == 896 || HEIGHT_SCREEN == 844 || HEIGHT_SCREEN == 926)

/************ iphone_x尺寸适配 ****************/
/*** iPhoneX底部虚拟区适配 */
//iphoneX底部虚拟区高度
#define     HEIGHT_VIRTUAL_IX               34.0f
#define     HEIGHT_VIRTUAL_FIT              (iPhone_X ? HEIGHT_VIRTUAL_IX : 0)
/*** iPhoneX底部Tabbar   */
//iphoneX底部Tabbar高度
#define     HEIGHT_TABBAR_IX                (HEIGHT_VIRTUAL_IX + HEIGHT_TABBAR)

/** 导航栏高度(内部控件已适配) */
//iphoneX下导航条需要增加的高度
#define     HEIGHT_NAVADD_IX                 24.0f
//iphoneX下导航条高度
#define     HEIGHT_NAV_IX                   HEIGHT_NAV + HEIGHT_NAVADD_IX
#define     HEIGHT_NAVADD_FIT               (iPhone_X ? HEIGHT_NAVADD_IX : 0)

//底部Tabbar高度： X是(34+49)  非X是(49)
#define     HEIGHT_TABBAR_FIT               (iPhone_X ? HEIGHT_TABBAR_IX : HEIGHT_TABBAR)
//导航高度: X是(64+24) 非X是(64)
#define     HEIGHT_NAV_FIT                  (iPhone_X ? HEIGHT_NAV_IX : HEIGHT_NAV)

#define Color(r, g, b, a)             [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define HexColor(String)              [SystemManager colorWithHexString:String]
#define WeakSelf(type)                __weak typeof(type) weak##type = type;
#define DocumentDirectory             [(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)) lastObject]

#endif /* Const_UI_h */
