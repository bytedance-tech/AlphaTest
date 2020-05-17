//
//  PangleAdapterConfiguration.m
//  BUADDemo
//
//  Created by Pangle on 2019/8/9.
//  Copyright © 2019 Pangle. All rights reserved.
//

#import "PangleAdapterConfiguration.h"
#import <BUAdSDK/BUAdSDKManager.h>


@implementation PangleAdapterConfiguration

// Constants
static NSString * const kPangleAppIdKey = @"app_id";
static NSString * const kPanglePlacementIdKey = @"ad_placmenet_id";

- (NSString *)adapterVersion {
    return @"3.0.0.1.0";
}

- (NSString *)biddingToken {
    return [BUAdSDKManager mopubBiddingToken];
}

- (NSString *)moPubNetworkName {
    return @"pangle";
}

- (NSString *)networkSdkVersion {
    return [BUAdSDKManager SDKVersion]?:@"";
}

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> *)configuration complete:(void(^)(NSError *))complete {
    NSString *appkeyString = configuration[kPangleAppIdKey];
    NSNumber *Coppa = configuration[@"Coppa"];
    NSNumber *isPaidApp = configuration[@"isPaidApp"];
    NSNumber *GDPR = configuration[@"GDPR"];
    if (appkeyString == nil || [appkeyString isKindOfClass:[NSString class]] == NO) {
        NSError *theError = [NSError errorWithDomain:@"com.Pangle.AdapterConfiguration" code:1 userInfo:@{NSLocalizedDescriptionKey:@"appKey may be not right, please set networkConfig refer to method '-configCustomEvent' in 'AppDelegate' class"}];
        if (complete != nil) {
            complete(theError);
        }
    } else {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [BUAdSDKManager setAppID:appkeyString];
                [BUAdSDKManager setIsPaidApp:NO];
                [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
                if ((Coppa && [Coppa isKindOfClass:[NSNumber class]])) {
                    [BUAdSDKManager setCoppa:Coppa.integerValue];
                }
                if ((isPaidApp && [isPaidApp isKindOfClass:[NSNumber class]])) {
                    [BUAdSDKManager setIsPaidApp:isPaidApp.integerValue == 0 ? NO : YES];
                }
                if ((GDPR && [GDPR isKindOfClass:[NSNumber class]])) {
                    [BUAdSDKManager setGDPR:GDPR.integerValue];
                }
                // This is a example to set GDPR. You can change GDPR at right scence
                if ([[MoPub sharedInstance] isGDPRApplicable] != MPBoolUnknown) {
                    BOOL canCollect =  [[MoPub sharedInstance] canCollectPersonalInfo];
                    [BUAdSDKManager setGDPR:canCollect];
                }
                if (complete != nil) {
                    complete(nil);
                }
            });
        });
    }
}

#pragma mark - Class method
+ (void)updateInitializationParameters:(NSDictionary *)parameters
{
    NSString * appId = parameters[kPangleAppIdKey];
    if (appId != nil) {
        NSDictionary * configuration = @{kPangleAppIdKey: appId};
        [PangleAdapterConfiguration setCachedInitializationParameters:configuration];
    }
}
@end
