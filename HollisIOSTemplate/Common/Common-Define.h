//
//  Common-Define.h
//  TestNWD
//
//  Created by Gary on 29/11/15.
//  Copyright (c) 2015 garyhuang. All rights reserved.
//

#ifndef TestNWD_Common_Define_h
#define TestNWD_Common_Define_h

#define APP_VER     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define STATUS_BAR_HEIGHT CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
#define NAVIGATION_BAR_HEIGHT 44
#define TAB_BAR_HEIGHT 49

#define SCREEN_WIDTH    CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT   CGRectGetHeight([[UIScreen mainScreen] bounds])

// iOS System Version Checking
#define IS_IOS_6_OR_BELOW ([[[UIDevice currentDevice] systemVersion] intValue] < 7)
#define IS_IOS_7_OR_BELOW ([[[UIDevice currentDevice] systemVersion] intValue] < 8)
#define IS_IOS_7_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] intValue] >= 7)
#define IS_IOS_8_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] intValue] >= 8)
#define IS_IOS_9_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] intValue] >= 9)

// iOS Device Checking
#define IS_IPAD                     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS         (IS_IPHONE && SCREEN_HEIGHT < 568.0)
#define IS_IPHONE_5                 (SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_5_OR_LESS         (IS_IPHONE && SCREEN_WIDTH == 320)
#define IS_IPHONE_6                 (IS_IPHONE && SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6_OR_ABOVE        (IS_IPHONE && SCREEN_WIDTH > 320)
#define IS_IPHONE_6_PLUS            (IS_IPHONE && SCREEN_HEIGHT == 736.0)
#define IS_IPHONE_6_PLUS_OR_ABOVE   (IS_IPHONE && SCREEN_HEIGHT >= 736.0)

// GA
#define GA_ALLOW_TRACKING           @"allowTracking"

#if (APP_STORE == 1)  // (Google Developer Account : artrkchan@gmail.com)
#define GA_TRACKINGID               @"UA-53852340-15"
#else  // (Google Developer Account : nwdapp@gmail.com)
#define GA_TRACKINGID               @"UA-72420317-10"
#endif

// GrowingIO
#define GROWINGIO_ACCOUNT_ID        @"b05fdd51474e133d"

// AppsFlyer
#define APPSFLYER_DEV_FEY           @"iStJiYV8FVLoJUm9Mxdvj8"

#define APPLE_APP_ID                @"1110673793"

// Google Map (Google Developer Account : nwdapp@gmail.com)
#define GOOGLE_MAP_API_KEY          @"AIzaSyCsmw2ZovnYKG-VwjHWqAqDwRE4nqi2oHg"  // one for all apps (support multiple Bundle ID)

//#if (APP_STORE == 1)
#define FACEBOOK_APP_ID             @"1087711511290948"  // App Store (Facebook Developer Account : nwdapp@gmail.com)
//#else
//#define FACEBOOK_APP_ID             @"1481757585459151"  // Dev and UAT
//#endif

#if (APP_STORE == 1)
#define API_DOMAIN      API_DOMAIN_PRO
#else
//#define API_DOMAIN      API_DOMAIN_DEV
#define API_DOMAIN      API_DOMAIN_UAT
#endif

#define kApiDomain        @"kApiDomain"
#define API_DOMAIN_PRO    @"https://apps.nwd.com.hk/NWDService/Service.svc/"         // production
#define API_DOMAIN_UAT    @"https://appsdev.nwd.com.hk/NWDService_UAT/Service.svc/"  // external UAT / for Demo to Boss
//#define API_DOMAIN_UAT    @"https://apps.nwd.com.hk/NWDService_UAT/Service.svc/"   // Old UAT
#define API_DOMAIN_DEV    @"http://10.1.0.63:1001/NWDService/Service.svc/"           // internal UAT

#define API_DOMAIN_K11    @"https://webservice.klub-11.com/ws_member.asmx/"

// App Language
#define kAppLanguage    @"kAppLanguage"
#define LANG_TC         @"tc"   // Tranditional Chinese, "tc"
#define LANG_EN         @"en"   // English, "en"
#define LANG_SC         @"sc"   // Simplified Chinese, "sc"
#define API_LANG_TC     @"TChi"  // Tranditional Chinese, "tc"
#define API_LANG_EN     @"Eng"   // English, "en"
#define API_LANG_SC     @"SChi"  // Simplified Chinese, "sc"

#define kNWDWebsiteDomain   @"http://www.nwd.com.hk"

#define kSideMenuWidth 230
#define kUploadPhotoMaxWidthHeight  1024

#define LOAD_DATA_FROM_INDEX       1
#define LOAD_DATA_TO_INDEX         kTableViewRowCountPerPage

// UIBaseTableView
#define kTableViewRowCountPerPage                10
#define kBaseTableViewCellIdentifier             @"kBaseTableViewCellIdentifier"
#define kBaseTableViewFooterViewIdentifier       @"kBaseTableViewFooterViewIdentifier"
#define kBaseTableViewCellHeight                 60
#define kBaseTableViewSectionHeaderHeight        30
#define kBaseTableViewFooterLoadingViewHeight    60

// UIBaseTableView
#define TABLEVIEW_IS_USE_MAX_ROW_COUNT  1
#define kTableViewMaxRowCount           100

// UIBaseDetailView
#define kBaseDetailViewCellIdentifier       @"kBaseDetailViewCellIdentifier"

// Last Updated Time (for tables which need pull down refresh)
#define kTestTableVCLastUpdatedTime             @"kTestTableVCLastUpdatedTime"
#define kNoticeMessageListVCLastUpdatedTime     @"kNoticeMessageListVCLastUpdatedTime"

#define DEFAULT_TIMEOUT            30

// Card Type
#define CARD_TYPE_CIRCLE      @"Circle"
#define CARD_TYPE_VIVA        @"Viva"
#define CARD_TYPE_INFINITY    @"Infinity"
#define CARD_TYPE_DIAMOND     @"Diamond"
#define CARD_TYPE_PH          @"PH"
#define CARD_TYPE_TPH         @"TPH"
#define CARD_TYPE_PS          @"PS"
#define CARD_TYPE_ESL         @"ESL"
#define CARD_TYPE_TS          @"TS"
#define CARD_TYPE_PV          @"PV"
#define CARD_TYPE_SP          @"SP"
#define CARD_TYPE_BH          @"BH"
#define CARD_TYPE_CHI_COFFEE  @"CHICoffee"
#define CARD_TYPE_NWD         @"NWD"
#define CARD_TYPE_NWPMCL      @"NWPMCL"
#define CARD_TYPE_HKGTA       @"HKGTA"

// Facilities Payment Status
#define PAYMENT_STATUS_SETTLED     @"PAID"
#define PAYMENT_STATUS_PENDING     @"PEND"
#define PAYMENT_STATUS_OVERDUE     @"EXPI"

// Event Registration Status
#define EVENT_STATUS_CONFIRM           @"CONF"
#define EVENT_STATUS_PENDING_APPROVAL  @"NCON"
#define EVENT_STATUS_WAITING           @"WAIT"
#define EVENT_STATUS_FAIL              @"FAIL"
#define EVENT_STATUS_PENDING_PAYMENT   @"PAY"
#define EVENT_STATUS_PAID              @"PAID"
#define EVENT_STATUS_CANCEL            @"CAN"
#define EVENT_STATUS_REJECT            @"REJ"

// Property Type
#define PROPERTY_TYPE_RESIDENT    @"Resident"
#define PROPERTY_TYPE_OWNER       @"Owner"
#define PROPERTY_TYPE_TENANT      @"Tenant"

// Push Notification Type
#define PUSH_NOTIFICATION_TYPE_NOTICE                @"notice"
#define PUSH_NOTIFICATION_TYPE_NOTICE_FILE           @"noticefile"
#define PUSH_NOTIFICATION_TYPE_PRIVILEGE             @"privilege"
#define PUSH_NOTIFICATION_TYPE_CRM_PRIVILEGE         @"crmprivilege"
#define PUSH_NOTIFICATION_TYPE_PRIVILEGE_IMAGE       @"privilegeimage"
#define PUSH_NOTIFICATION_TYPE_PRIVILEGE_FILE        @"privilegefile"
#define PUSH_NOTIFICATION_TYPE_FACILITY_BOOKING      @"facilitybooking"
#define PUSH_NOTIFICATION_TYPE_ASK_UPDATE            @"askupdate"

/*************************************************
 *  NSNotificationCenter
 */
#define NWD_POST_NOTIF(__name,__object,__userInfo) \
[[NSNotificationCenter defaultCenter] postNotificationName:__name object:__object userInfo:__userInfo]

#define NWD_CLEAN_ADD_NOTIF(__target,__selector,__name,__object) do{\
[[NSNotificationCenter defaultCenter] removeObserver:__target name:__name object:__object]; \
[[NSNotificationCenter defaultCenter] addObserver:__target selector:__selector name:__name object:__object];}while(0)

#define NWD_ADD_NOTIF(__target,__selector,__name,__object) \
[[NSNotificationCenter defaultCenter] addObserver:__target selector:__selector name:__name object:__object]

#define NWD_DEL_NOTIF(__target,__name,__object) \
[[NSNotificationCenter defaultCenter] removeObserver:__target name:__name object:__object]

#define NWD_DEL_NOTIFS(__target) \
[[NSNotificationCenter defaultCenter] removeObserver:__target]


/*************************************************
 *  Get Managers
 */
#define BASE_API_MANAGER                  (BaseAPIManager *)[[AppManager sharedAppManager] baseApiManager]
#define API_MANAGER                       (APIManager *)[[AppManager sharedAppManager] apiManager]
#define STRING_MANAGER                    (StringManager *)[[AppManager sharedAppManager] stringManager]
#define COMMON_MANAGER                    (CommonManager *)[[AppManager sharedAppManager] commonManager]
#define SNS_MANAGER                       (SNSManager *)[[AppManager sharedAppManager] snsManager]


/*************************************************
 *  Notifications
 */
#define kWelcomeToHomeNotification            @"kWelcomeToHomeNotification"
#define kHomeToWelcomeNotification            @"kHomeToWelcomeNotification"
#define kLanguageDidChangeNotification        @"kLanguageDidChangeNotification"
#define kBookedFacilityDidChangeNotification  @"kBookedFacilityDidChangeNotification"
#define kBookedEventDidChangeNotification     @"kBookedEventDidChangeNotification"
#define kOpenSideMenuNotification             @"kOpenSideMenuNotification"
#define kBookmarkOfferNotification            @"kBookmarkOfferNotification"
#define kBookmarkEventNotification            @"kBookmarkEventNotification"
#define kViewCountEventNotification           @"kViewCountEventNotification"
#define kNoticeReadNotification               @"kNoticeReadNotification"
#define kOfferRedeemNotification              @"kOfferRedeemNotification"
#define kGetRewardNotification                @"kGetRewardNotification"
#define kReceivePushNotification              @"kReceivePushNotification"
#define kAddPropertiesNotification            @"kAddPropertiesNotification"
#define kUpdatePrimaryPropertyNotification    @"kUpdatePrimaryPropertyNotification"

/*************************************************
 *  API Params
 */
#define kK11CallUserCode            @"strCallUserCode"  // General API Webservice UserName
#define kK11CallPassword            @"strCallPassword"  // General API Webservice Password
#define kK11MemberCode              @"strMemberCode"
#define kK11Password                @"strPassword"
#define kK11IsArtsClub              @"strIsArtsClub"

#define kIsBookmarked               @"isBookmarked"

/*************************************************
 *  NSUserDefaults
 */
#define kIsAgreeTncUserDefault             @"isAgreeTnc"
#define kUserInfoUserDefault               @"userInfo"
#define kEstateUserDefault                 @"estate"
#define kCodeMaintDictUserDefault          @"codeMaintDict"
#define kEstateListUserDefault             @"estateList"
#define kSideMenuUserDefault               @"sideMenu"
#define kEstatePropertyDictUserDefault     @"estatePropertyDict"
#define kEstateIdUserDefault               @"estateId"
#define kActivateMemberIdUserDefault       @"activateMemberId"
#define kActivateEmailMobileIdUserDefault  @"activateEmailMobile"
#define kActivateClubMemberNoUserDefault   @"activateClubMemberNo"
//#define kRegistrationInfoUserDefault       @"registrationInfo"
#define kPushTokenUserDefault              @"pushToken"
#define kIsNeedForceAppUpdateUserDefault   @"isNeedForceAppUpdate"
#define kIsNeedAskAppUpdateUserDefault     @"isNeedAskAppUpdate"
#define kPushDictUserDefault               @"pushDict"
#define kIsPopUpAdvertisementUserDefault   @"isPopUpAdvertisement"
#define kIsShowStaffCoachMarksUserDefault  @"isShowStaffCoachMarks"

/*************************************************
 *  UIColor
 */
#define themeColor                  [UIColor colorWithHex:@"e1b6a4" alpha:1.0]
#define titlesColor                 [UIColor colorWithHex:@"3c3c3c" alpha:1.0]
#define contentColor                [UIColor colorWithHex:@"999999" alpha:1.0]
#define tapBarActiveColor           [UIColor colorWithHex:@"d2a38f" alpha:1.0]
#define tapBarInactiveColor         [UIColor colorWithHex:@"1e1e1e" alpha:1.0]
#define secondTapBarActiveColor     [UIColor colorWithHex:@"e1b6a4" alpha:1.0]
//#define secondTapBarInactiveColor   [UIColor colorWithHex:@"1e1e1e" alpha:1.0]
#define bottomTabActiveColor        [UIColor colorWithHex:@"e1b6a4" alpha:1.0]
//#define mainButtonColor             [UIColor colorWithHex:@"f0d0c3" alpha:1.0]
//#define subButtonColor              [UIColor colorWithHex:@"e1b6a4" alpha:1.0]
//#define tagButtonColor              [UIColor colorWithHex:@"d2a38f" alpha:1.0]
#define pendingStatusColor          [UIColor colorWithHex:@"e5c963" alpha:1.0]
#define overdueStatusColor          [UIColor colorWithHex:@"da9898" alpha:1.0]
#define settledStatusColor          [UIColor colorWithHex:@"aac98c" alpha:1.0]
#define meNoticeColor               [UIColor colorWithHex:@"ad907b" alpha:1.0]
#define fbBlueColor                 [UIColor colorWithHex:@"4267b2" alpha:1.0]
#define alphaBlackColor             [[UIColor blackColor] colorWithAlphaComponent:0.6f]
#define joinUsColor                 [UIColor colorWithHex:@"4b565c" alpha:1.0]

/*************************************************
 *  UIFont
 */
#define SweetSansBold           @"SweetSans-Bold"
#define SweetSansRegular        @"SweetSans-Regular"
#define RobotoBold              @"Roboto-Bold"
#define RobotoMedium            @"Roboto-Medium"
#define RobotoRegular           @"Roboto-Regular"

/*************************************************
 * debug log
 */
// DLog: debug log, only output log when product is in Debug
#ifdef DEBUG
//#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#   define DLog(...) NSLog(__VA_ARGS__)
#else
#   define DLog(...)
#endif


#endif
