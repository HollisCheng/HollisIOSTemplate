//
//  Common-Enum.h
//  TestNWD
//
//  Created by Gary on 29/11/15.
//  Copyright (c) 2015 garyhuang. All rights reserved.
//

#ifndef TestNWD_Common_Enum_h
#define TestNWD_Common_Enum_h

typedef enum {
    APIRequestFormatHTTP,
    APIRequestFormatJSON,
} APIRequestFormat;

typedef enum {
    APIResponseFormatHTTP,
    APIResponseFormatJSON,
    APIResponseFormatXML,
} APIResponseFormat;

typedef enum {
    TabTypeMe,
    TabTypeCardWallet,
    TabTypeEvent,
    TabTypeFacilities,
    TabTypeUpdates,
} TabType;

//typedef enum {
//    SideMenuResidentArea,
//    SideMenuMyRewards,
//    SideMenuPromotions,
//    SideMenuFeedback,
//    SideMenuSetting,
//    SideMenuAbout,
//    SideMenuTnC,
//    SideMenuContactUs,
//} SideMenuItemType;

typedef enum {
    LanguageTC,
    LanguageSC,
    LanguageEN,
} LanguageType;

typedef enum {
    SegmentedControlFirst = 0,  // must start from 0, since used as object index in data array
    SegmentedControlSecond,
    SegmentedControlThird,
} SegmentedControlTab;

typedef enum {
    ResidentAreaMap,
    ResidentAreaFloorPlan,
    ResidentAreaGallery,
    ResidentAreaEnvironment,
    ResidentAreaEstateNotice,
    ResidentAreaValueAddedService,
    ResidentAreaOwnersArea,
    ResidentAreaHotSpots,
    ResidentAreaUsefulContacts,
} ResidentAreaItemType;

typedef enum {
    CardTypeResident,
    CardTypeNWC,
    CardTypeK11,
    EnumCount_CardType,  // must be the last item
} CardType;

typedef enum {
    MeFirstLevelTab_Facilities,
    MeFirstLevelTab_Hotspots,
    MeFirstLevelTab_Privileges,
    MeFirstLevelTab_Events,
} MeFirstLevelTab;

typedef enum {
    EventFirstLevelTab_Events,
    EventFirstLevelTab_My_Events,
} EventFirstLevelTab;

typedef enum {
    DetailButton,
    DetailDescription,
    DetailInfo,
    DetailMap,
    DetailTnC,
} DetailItemType;

typedef enum {
    DetailButtonBookmark,
    DetailButtonCall,
    DetailButtonShare,
    DetailButtonMail,
    DetailButtonCalendar,
} DetailButtonItemType;

#endif
