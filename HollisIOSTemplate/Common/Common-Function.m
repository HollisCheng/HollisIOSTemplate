//
//  Common-Function.m
//  TestNWD
//
//  Created by Gary on 29/11/15.
//  Copyright (c) 2015 garyhuang. All rights reserved.
//

#import "Common-Function.h"

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

// for In-App Browser, Gary
#import "InAppBrowserWebViewController.h"
#import "PDFViewController.h"

#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>
#import <EventKit/EventKit.h>

#import "Estate.h"
#import "Property.h"

#import "CocoaSecurity.h"

#pragma mark - NSUserDefaults

void setObjectToUserDefaults(NSString *key, NSObject *obj) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];
}

void setDataObjectToUserDefaults(NSString *key, NSObject *obj) {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

void setBoolToUserDefaults(NSString *key, BOOL obj) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:obj forKey:key];
    [defaults synchronize];
}

NSObject *getObjectFromUserDefaults(NSString *key) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

NSObject *getDataObjectFromUserDefaults(NSString *key) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *obj = [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:key]];
    return obj;
}

NSString *getStringFromUserDefaults(NSString *key) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:key];
}

BOOL getBoolFromUserDefaults(NSString *key) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:key];
}

BOOL getUserDefaultsExist(NSString *key){
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:key]){
        return YES;
    }
    return NO;
}

MemberInfo *getUserInfo() {
    return (MemberInfo *)getDataObjectFromUserDefaults(kUserInfoUserDefault);
}

NSString *getEstateId() {
    NSString *estateId = getStringFromUserDefaults(kEstateIdUserDefault);
    if ([STRING_MANAGER isEmpty:estateId]) {
        return @"0";
    }else{
        return getStringFromUserDefaults(kEstateIdUserDefault);
    }
}

NSString *getPushToken() {
    NSString *pushToken = getStringFromUserDefaults(kPushTokenUserDefault);
    if ([STRING_MANAGER isEmpty:pushToken]) {
        return @"";
    }else{
        return getStringFromUserDefaults(kPushTokenUserDefault);
    }
}

BOOL isUserLogin(){
    MemberInfo *userInfo = getUserInfo();
    return userInfo?YES:NO;
}

BOOL isShowContent(){
    Estate *estate = (Estate *)getDataObjectFromUserDefaults(kEstateUserDefault);
    return estate.isShowContent;
}

BOOL isOtherPropertyPrimary(){
    MemberInfo *userInfo = getUserInfo();
    NSArray *propertyArray = userInfo.propertyArray;
    
    BOOL isOtherProperty = NO;
    for (Property *property in propertyArray) {
        NSString *estateID = [NSString stringWithFormat:@"%@",property.estateID];
        if (property.isPrimary == YES && [estateID isEqualToString:@"0"]) {
            isOtherProperty = YES;
        }
    }
    if (propertyArray.count == 0) {
        isOtherProperty = YES;
    }
    return isOtherProperty;
}

BOOL isNeedForceAppUpdate(){
    BOOL isForceAppUpdate = getBoolFromUserDefaults(kIsNeedForceAppUpdateUserDefault);
    return isForceAppUpdate;
}

BOOL isNeedAskAppUpdate(){
    BOOL isAskAppUpdate = getBoolFromUserDefaults(kIsNeedAskAppUpdateUserDefault);
    return isAskAppUpdate;
}

#pragma mark - App Language

void setAppLanguage(NSString *lang) {
    setObjectToUserDefaults(kAppLanguage, lang);
}

NSString *appLanguage(void) {
    NSString *appLang = getStringFromUserDefaults(kAppLanguage);
    if (appLang) {
        return appLang;
    } else {
        // Use device language
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        DLog(@"preferredLang:%@",language);
        if ([language rangeOfString:@"zh"].location != NSNotFound) {
            setAppLanguage(LANG_TC);
            return LANG_TC;
        }else{
            setAppLanguage(LANG_EN);
            return LANG_EN;
        }
//        return LANG_EN;
    }
}

BOOL isAppLanguage(NSString *lang) {
    return [appLanguage() isEqualToString:lang];
}

NSString* localizedString(NSString* string) {
    return NSLocalizedStringFromTable(string, appLanguage(), @"");
}

NSString *apiAppLanguage(void) {
    if (isAppLanguage(LANG_EN)) {
        return API_LANG_EN;
    }else if (isAppLanguage(LANG_TC)){
        return API_LANG_TC;
    }else{
        return API_LANG_SC;
    }
}

#pragma mark - Text Font and Color

void getTextFontAndColorByKey(NSString *key, UIFont **font, UIColor **color) {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([a-z,A-Z]{1,4})([0-9]{1,3})([a-z,A-Z]{1})"
                                                                           options:0 error:&error];
    NSArray *matches = [regex matchesInString:key
                                      options:0
                                        range:NSMakeRange(0, [key length])];
    for (NSTextCheckingResult *match in matches) {
        if ([match numberOfRanges] == 4) {      // range 0 hold the full string
            NSString *colorKey = [key substringWithRange:[match rangeAtIndex:1]];
            NSString *sizeKey = [key substringWithRange:[match rangeAtIndex:2]];
            NSString *fontKey = [key substringWithRange:[match rangeAtIndex:3]];
            *font = [UIFont fontWithName:getFontNameByFontType(fontKey) size:[sizeKey floatValue]];
            *color = [UIColor colorForKey:colorKey];
        }
    }
}

UIFont *getFontByKey(NSString *key) {
    UIFont *font = nil;
    UIColor *color = nil;
    getTextFontAndColorByKey(key, &font, &color);
    return font;
}

static NSDictionary *fontDictionary = nil;

NSString *getFontNameByFontType(NSString *fontType) {
    if (fontDictionary == nil) {
        fontDictionary = @{
                           @"L":@{LANG_EN:@"Lato-Light", LANG_TC:@"HelveticaNeue-Light", LANG_SC:@"HelveticaNeue-Light"},
                           @"I":@{LANG_EN:@"Lato-Italic", LANG_TC:@"HelveticaNeue-Light", LANG_SC:@"HelveticaNeue-Light"},
                           @"N":@{LANG_EN:@"Lato-Regular", LANG_TC:@"HelveticaNeue", LANG_SC:@"HelveticaNeue"},
                           @"B":@{LANG_EN:@"Lato-Bold", LANG_TC:@"HelveticaNeue-Medium", LANG_SC:@"HelveticaNeue-Medium"},
                           };
    }
    NSString *font = [[fontDictionary objectForKey:[fontType uppercaseString]] objectForKey:appLanguage()];
    return (font == nil)?[[fontDictionary objectForKey:[fontType uppercaseString]] objectForKey:LANG_TC]:font;
}

#pragma mark - API Domain
void setApiDomain(NSString *domain) {
    setObjectToUserDefaults(kApiDomain, domain);
}

NSString *apiDomain(void) {
    NSString *domain = getStringFromUserDefaults(kApiDomain);
    if (domain) {
        return domain;
    } else {
        setApiDomain(API_DOMAIN);
        return API_DOMAIN;
    }
}

#pragma mark - AES-256
NSString *aesEncrypt(NSString *encryptStr, NSString *keyStr, NSString *ivStr) {
    NSData* secretKeyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding]; //32 length
    NSData* ivData = [ivStr dataUsingEncoding:NSUTF8StringEncoding]; //16 length
    
    CocoaSecurityResult *aesEncrypt = [CocoaSecurity aesEncrypt:encryptStr key:secretKeyData iv:ivData];
    return aesEncrypt.base64;
}

NSString *aesDecrypt(NSString *encryptBase64, NSString *keyStr, NSString *ivStr) {
    NSData* secretKeyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding]; //32 length
    NSData* ivData = [ivStr dataUsingEncoding:NSUTF8StringEncoding]; //16 length
    
    CocoaSecurityResult *aesDecrypt = [CocoaSecurity aesDecryptWithBase64:encryptBase64 key:secretKeyData iv:ivData];
    return aesDecrypt.utf8String;
}

#pragma mark - Other

BOOL isSupportPhoneCall() {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    NSString *carrierName = [carrier carrierName];
    return ([carrierName length] > 0 && [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]);
}

void openPhoneCall(NSString *phone) {
    NSString *phoneNumber = [@"telprompt://" stringByAppendingString:phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

void openEmail(NSString *emailAddress) {
    NSString *email = [@"mailto:" stringByAppendingString:emailAddress];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

void openSMS(UIViewController *viewController, id delegate) {
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    MFMessageComposeViewController *composeVC = [[MFMessageComposeViewController alloc] init];
    composeVC.messageComposeDelegate = delegate;
    composeVC.recipients = @[@"14085551212"];
    composeVC.body = @"Hello from California!";
    
    [viewController presentViewController:composeVC animated:YES completion:nil];
}

void openInAppBrowser(NSString *url, NSString *title, BOOL isFromSideMenu, BOOL isShowBottomToolbar, BOOL isPushViewController, UIViewController *viewController) {
    
    InAppBrowserWebViewController *webViewController = [[InAppBrowserWebViewController alloc] init];
    webViewController.webTitle = title;
    webViewController.url = url;
    webViewController.isFromSideMenu = isFromSideMenu;
    webViewController.actionButtonHidden = YES;
    webViewController.isShowBottomToolbar = isShowBottomToolbar;
    webViewController.isPushViewController = isPushViewController;
    
    if (isPushViewController) {
        [viewController.navigationController pushViewController:webViewController animated:YES];
    }else{
        UINavigationController *inAppBrowserViewController = [[UINavigationController alloc] initWithRootViewController:webViewController];
        if (viewController) {
            [viewController presentViewController:inAppBrowserViewController animated:YES completion:nil];
        }else{
            [[SlideNavigationController sharedInstance] presentViewController:inAppBrowserViewController animated:YES completion:nil];
        }
    }
}

void openMapApplication(CLLocationCoordinate2D coordinate) {
//    NSDictionary *addressDict = @{ (NSString*)kABPersonAddressCountryKey : @"台灣",
//                                   (NSString*)kABPersonAddressCityKey : @"台北市",
//                                   (NSString*)kABPersonAddressStreetKey : @"信義區市府路45號"};
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"Here"];
        // Pass the map item to the Maps app
        [mapItem openInMapsWithLaunchOptions:nil];
    }
}

void addToCalendar(NSString *title, NSString *location, NSString *notes, NSDate *startDate, NSDate *endDate, UIViewController *viewController) {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted) {
            EKEvent* myEvent = [EKEvent eventWithEventStore:eventStore];
            myEvent.calendar = eventStore.defaultCalendarForNewEvents;
            myEvent.title = title;
            myEvent.location = location;
            myEvent.notes = notes;
            myEvent.startDate = startDate;
            myEvent.endDate = endDate;
            
            NSError* error;
            BOOL result = [eventStore saveEvent:myEvent span:EKSpanThisEvent commit:YES error:&error];
            if (result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    showAlertView(nil,
                                  localizedString(@"facilities_add_to_calendar_success"),
                                  nil,
                                  localizedString(@"general_ok"),
                                  viewController,
                                  ^{
                                  },
                                  ^{
                                  });
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    showAlertView(nil,
                                  localizedString(@"facilities_add_to_calendar_fail"),
                                  nil,
                                  localizedString(@"general_ok"),
                                  viewController,
                                  ^{
                                  },
                                  ^{
                                  });
                });
            }
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                showAlertView(nil,
                              localizedString(@"facilities_add_to_calendar_cannot_access"),
                              nil,
                              localizedString(@"general_ok"),
                              viewController,
                              ^{
                              },
                              ^{
                              });
            });
        }
    }];
}

BOOL isPresentViewController(UIViewController *controller) {
    if(controller.presentingViewController) {
        return YES;
    }
    return NO;
}

BOOL isSameDay(NSDate *day1, NSDate *day2) {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:day1];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:day2];
    return ([comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year]);
}

NSString *getDateTimeIntervalDisplay(NSDate *previousDate) {
    NSDate *currentDate = [NSDate date];
    if (isSameDay(previousDate, currentDate)) {
        NSTimeInterval interval = [currentDate timeIntervalSinceDate:previousDate];
        //long min = (long)interval / 60;    // divide two longs, truncates
        //long sec = (long)interval % 60;    // remainder of long divide
        int min = (int)interval / 60;
        if (min == 0) {
            return @"Just Now";
        } else if (min >= 1 && min <= 60) {
            return [NSString stringWithFormat:@"%d mins ago", min];
        } else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
            return [NSString stringWithFormat:@"Today %@", [formatter stringFromDate:previousDate]];
        }
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [formatter stringFromDate:previousDate];
    }
    return @"";
}

NSString *getLastUpdatedTimeDisplay(NSString *lastUpdatedTimeKey) {
    NSDate *lastUpdatedTime = (NSDate *)getObjectFromUserDefaults(lastUpdatedTimeKey);
    NSString *lastUpdatedTime_str = @"";
    if (lastUpdatedTime) {
        lastUpdatedTime_str = getDateTimeIntervalDisplay(lastUpdatedTime);
    } else {
        lastUpdatedTime_str = @"Never";
    }
    return [NSString stringWithFormat:@"Last Updated: %@", lastUpdatedTime_str];
}

NSInteger getDaysDifference(NSDate *fromDate, NSDate *toDate)
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDate];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDate];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                    fromDate:fromDate
                                                      toDate:toDate
                                                     options:0];
    return components.day+1;
}

void showAlertView(NSString *title,
                   NSString *message,
                   NSString *cancelButtonTitle,
                   NSString *confirmButtonTitle,
                   UIViewController *viewController,
                   UIAlertViewCancelBlock cancelBlock,
                   UIAlertViewConfirmBlock confirmBlock) {
    if ([UIAlertController class]) {
        /* UIAlertController is preferable on >= iOS 8, as the destructive button will be in red */
        [UIAlertController showAlertInViewController:viewController
                                           withTitle:title
                                             message:message
                                   cancelButtonTitle:cancelButtonTitle
                              destructiveButtonTitle:nil
                                   otherButtonTitles:(confirmButtonTitle)?@[confirmButtonTitle]:nil
                                            tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex) {
                                                if (buttonIndex == controller.cancelButtonIndex) {
                                                    cancelBlock();
                                                } else if (buttonIndex == controller.firstOtherButtonIndex) {
                                                    confirmBlock();
                                                }
                                            }];
    } else {
        [UIAlertView showWithTitle:title
                           message:message
                 cancelButtonTitle:cancelButtonTitle
                 otherButtonTitles:(confirmButtonTitle)?@[confirmButtonTitle]:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                              if (buttonIndex == alertView.cancelButtonIndex) {
                                  cancelBlock();
                              } else if (buttonIndex == alertView.firstOtherButtonIndex) {
                                  confirmBlock();
                              }
                          }];
    }
}

void showActionSheet(UIView *view,
                     UIViewController *viewController,
                     NSString *title,
                     NSString *message,
                     NSString *cancelButtonTitle,
                     NSArray *otherButtonTitles,
                     UIActionSheetCancelBlock cancelBlock,
                     UIActionSheetFirstButtonBlock firstButtonBlock,
                     UIActionSheetSecondButtonBlock secondButtonBlock) {
    if ([UIAlertController class]) {
        /* UIAlertController is preferable on >= iOS 8, as the destructive button will be in red */
        [UIAlertController showActionSheetInViewController:viewController
                                                 withTitle:title
                                                   message:message
                                         cancelButtonTitle:cancelButtonTitle
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:otherButtonTitles
                        popoverPresentationControllerBlock:nil
                                                  tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex) {
                                                      if (buttonIndex == controller.cancelButtonIndex) {
                                                          cancelBlock();
                                                      } else if (buttonIndex == controller.firstOtherButtonIndex) {
                                                          firstButtonBlock();
                                                      } else {
                                                          secondButtonBlock(buttonIndex);
                                                      }
                                                  }];
    } else {
        [UIActionSheet showInView:view
                        withTitle:title
                cancelButtonTitle:cancelButtonTitle
           destructiveButtonTitle:nil
                otherButtonTitles:otherButtonTitles
                         tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                             if (buttonIndex == actionSheet.cancelButtonIndex) {
                                 cancelBlock();
                             } else if (buttonIndex == actionSheet.firstOtherButtonIndex) {
                                 firstButtonBlock();
                             } else {
                                 secondButtonBlock(buttonIndex);
                             }
                         }];
    }
}

void openShare(UIViewController *viewController){
//    NSString *textToShare = @"share text";
    UIImage * imgToShare = [UIImage imageNamed:@"img_card_demo"];
//    NSURL *urlToShare = [NSURL URLWithString:@"https://www.google.com.hk/"];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[imgToShare] applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeAddToReadingList,
                                                     UIActivityTypeAssignToContact,
                                                     UIActivityTypePrint,
                                                     UIActivityTypeSaveToCameraRoll,
                                                     UIActivityTypeCopyToPasteboard,
                                                     UIActivityTypeAirDrop,
                                                     UIActivityTypePostToWeibo,
                                                     UIActivityTypePostToVimeo,
                                                     UIActivityTypePostToFlickr,
                                                     UIActivityTypePostToTwitter,
                                                     UIActivityTypePostToTencentWeibo];
    [viewController presentViewController:activityViewController animated:YES completion:nil];
    
}

//BOOL useDiamondToReplaceInfinity(void) {
//    // After 1/5/2016, use Diamond instead of Infinity
//    NSString *dateString = @"01/05/2016";
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"dd/MM/yyyy";
//    NSDate *date = [dateFormatter dateFromString:dateString];
//    if ([[NSDate date] compare:date] == NSOrderedAscending){
//        return false;
//    } else {
//        return true;
//    }
//}

void showAppUpdate(UIViewController *viewController, BOOL isForceUpdate){
    if (isForceUpdate) {
        UIView *blockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        blockView.backgroundColor = [UIColor lightGrayColor];
        
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootViewController.view addSubview:blockView];
        
        showAlertView(localizedString(@"app_update_download"),
                      @"",
                      nil,
                      localizedString(@"app_update_now"),
                      viewController,
                      ^{
                      },
                      ^{
                          [blockView removeFromSuperview];
                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/hk/app/artisanal-living/id1110673793"]];
                      });
    }else{
        showAlertView(localizedString(@"app_update_download"),
                      @"",
                      localizedString(@"app_update_later"),
                      localizedString(@"app_update_now"),
                      viewController,
                      ^{
                      },
                      ^{
                          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/hk/app/artisanal-living/id1110673793"]];
                      });
    }
}
