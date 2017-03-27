//
//  Common-Function.h
//  TestNWD
//
//  Created by Gary on 29/11/15.
//  Copyright (c) 2015 garyhuang. All rights reserved.
//

#ifndef TestNWD_Common_Function_h
#define TestNWD_Common_Function_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UserInfo.h"
#import "MemberInfo.h"

// NSUserDefaults
void setObjectToUserDefaults(NSString *key, NSObject *obj);
void setDataObjectToUserDefaults(NSString *key, NSObject *obj);
void setBoolToUserDefaults(NSString *key, BOOL obj);
NSObject *getObjectFromUserDefaults(NSString *key);
NSObject *getDataObjectFromUserDefaults(NSString *key);
NSString *getStringFromUserDefaults(NSString *key);
BOOL getBoolFromUserDefaults(NSString *key);
BOOL getUserDefaultsExist(NSString *key);

MemberInfo *getUserInfo();
NSString *getEstateId();
NSString *getPushToken();
BOOL isUserLogin();
BOOL isShowContent();
BOOL isOtherPropertyPrimary();
BOOL isNeedForceAppUpdate();
BOOL isNeedAskAppUpdate();

// App Language
void setAppLanguage(NSString *lang);
NSString* appLanguage(void);
BOOL isAppLanguage(NSString *lang);
NSString* localizedString(NSString* string);
NSString *apiAppLanguage(void);

// Text Font and Color
void getTextFontAndColorByKey(NSString *key, UIFont **font, UIColor **color);
UIFont *getFontByKey(NSString *key);
NSString *getFontNameByFontType(NSString *fontType);

// API Domain
void setApiDomain(NSString *domain);
NSString *apiDomain(void);

BOOL isSupportPhoneCall(void);
void openPhoneCall(NSString *phone);
void openEmail(NSString *emailAddress);
void openSMS(UIViewController *viewController, id delegate);

void openInAppBrowser(NSString *url, NSString *title, BOOL isFromSideMenu, BOOL isShowBottomToolbar, BOOL isPushViewController, UIViewController *viewController);
void openMapApplication(CLLocationCoordinate2D coordinate);
void addToCalendar(NSString *title, NSString *location, NSString *notes, NSDate *startDate, NSDate *endDate, UIViewController *viewController);

BOOL isPresentViewController(UIViewController *controller);

// NSDate and Interval
BOOL isSameDay(NSDate *day1, NSDate *day2);
NSString *getDateTimeIntervalDisplay(NSDate *previousDate);
NSString *getLastUpdatedTimeDisplay(NSString *lastUpdatedTimeKey);
NSInteger getDaysDifference(NSDate *fromDate, NSDate *toDate);

typedef void (^UIAlertViewCancelBlock)(void);
typedef void (^UIAlertViewConfirmBlock)(void);

void showAlertView(NSString *title,
                   NSString *message,
                   NSString *cancelButtonTitle,
                   NSString *confirmButtonTitle,
                   UIViewController *viewController,
                   UIAlertViewCancelBlock cancelBlock,
                   UIAlertViewConfirmBlock confirmBlock);

typedef void (^UIActionSheetCancelBlock)(void);
typedef void (^UIActionSheetFirstButtonBlock)(void);
typedef void (^UIActionSheetSecondButtonBlock)(NSInteger buttonIndex);

void showActionSheet(UIView *view,
                     UIViewController *viewController,
                     NSString *title,
                     NSString *message,
                     NSString *cancelButtonTitle,
                     NSArray *otherButtonTitles,
                     UIActionSheetCancelBlock cancelBlock,
                     UIActionSheetFirstButtonBlock firstButtonBlock,
                     UIActionSheetSecondButtonBlock secondButtonBlock);

void openShare(UIViewController *viewController);

void showAppUpdate(UIViewController *viewController, BOOL isForceUpdate);

#endif
