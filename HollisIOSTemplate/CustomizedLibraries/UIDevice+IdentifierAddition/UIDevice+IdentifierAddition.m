//
//  UIDevice(Identifier).m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import "UIDevice+IdentifierAddition.h"
//#import "KeychainItemWrapper.h"
//#import "SAMKeychain.h"
#import <SAMKeychain/SAMKeychain.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CommonCrypto/CommonDigest.h>


static NSString * const kMyDeviceIdentifierKey = @"appDeviceIdentifier";



@interface NSString(MD5Addition)
- (NSString *) stringFromMD5;
@end


@interface UIDevice (IdentifierAdditionForIOS7)


/*
 * @method appDeviceIdentifier
 * @description use this method when you need a unique identifier in one app.
 *  Based on your device OS version,
 *  For > iOS 7 , it return [UIDevice identifierForVendor]
 *  Otherwise, It generates a hash from the MAC-address only.
 *
 *  Once generate, it will store in UserDefaults.
 */
- (NSString *)appDeviceIdentifier;

@end


@interface UIDevice (IdentifierAddition)

/*
 * @method uniqueDeviceIdentifier
 * @description use this method when you need a unique identifier in one app.
 * It generates a hash from the MAC-address in combination with the bundle identifier
 * of your app.
 */

- (NSString *) uniqueDeviceIdentifier;


@end




@interface UIDevice(Private)

- (NSString *) macaddress;

@end

@implementation UIDevice (IdentifierAddition)

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to erica sadun & mlamb.
- (NSString *) macaddress {
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public Methods

- (NSString *) uniqueDeviceIdentifier {
    NSString *macaddress = [[UIDevice currentDevice] macaddress];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *stringToHash = [NSString stringWithFormat:@"%@%@",macaddress,bundleIdentifier];
    NSString *uniqueIdentifier = [stringToHash stringFromMD5];
    
    return uniqueIdentifier;
}

@end


@implementation UIDevice (IdentifierAdditionForIOS7)

- (NSString *)appDeviceIdentifier
{
    
    // Check UserDefaults first .
    NSString *cachedUDID = [[NSUserDefaults standardUserDefaults] objectForKey:kMyDeviceIdentifierKey];
    
    
    
    if (cachedUDID) {
        return cachedUDID;
    } else {
        
        NSString *uuidString = nil;
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        
        if ([currSysVer compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending ) {
            uuidString = [self uniqueDeviceIdentifier];
        } else {
            uuidString = [self uniqueDeviceIdentifierForIOS7];  // Only 7.0 or above will use -IdentifierForVendor
        }
        
        return uuidString;
        
    }
    
}

/**
 *  Generate UDID for iOS7, The UDID will be unique per app.
 */
- (NSString *)uniqueDeviceIdentifierForIOS7 {
    
    NSString *macaddress = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *stringToHash = [NSString stringWithFormat:@"%@%@",macaddress,bundleIdentifier];
    NSString *uniqueIdentifier = [stringToHash stringFromMD5];
    
    return uniqueIdentifier;
    
    
}

@end


@implementation UIDevice(DeviceIdentifier)

- (NSString *)DeviceIdentifier
{
    
//    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"AppUDID" accessGroup:nil];
//    
//    NSString* udid = [wrapper objectForKey:(__bridge id)kSecValueData];
//    
//    
//    if ([udid length] == 0)
//    {
//        // Generate iOS UDID
//        udid = [self appDeviceIdentifier];
//        
//        [wrapper setObject:udid forKey:(__bridge id)kSecValueData];
//    }
    
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    NSString * udid = [SAMKeychain passwordForService:bundleId account:@"AppUDID"];
    if (udid == nil || [udid isEqualToString:@""])
    {
        // Generate iOS UDID
        udid = [self appDeviceIdentifier];
        
        [SAMKeychain setPassword: udid forService:bundleId account:@"AppUDID"];
    }
    
    return udid;
}

@end



/*
 
 NSString Category
 
 */

@implementation NSString(MD5Addition)

- (NSString *) stringFromMD5 {
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}

@end

