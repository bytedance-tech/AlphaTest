//
//  BUDMopub_MPNativeCustomEvent.m
//  BUDemo
//
//  Created by Pangle on 2020/1/8.
//  Copyright © 2020 Pangle. All rights reserved.
//

#import "PangleNativeAdAdapter.h"
#import <mopub-ios-sdk/MPNativeAd.h>
#import <mopub-ios-sdk/MPNativeAdConstants.h>

@interface PangleNativeAdAdapter ()
@property (nonatomic, strong) UIView *mediaView;
@end

@implementation PangleNativeAdAdapter

- (instancetype)initWithBUNativeAd:(BUNativeAd *)nativeAd {
    if (self = [super init]) {
        self.properties = [self buNativeAdToDic:nativeAd];
    }
    return self;
}

- (NSDictionary *)buNativeAdToDic:(BUNativeAd *)nativeAd {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:nativeAd.data.AdTitle forKey:kAdTitleKey];
    [dic setValue:nativeAd.data.AdDescription forKey:kAdTextKey];
    [dic setValue:nativeAd.data.buttonText forKey:kAdCTATextKey];
    [dic setValue:nativeAd.data.icon.imageURL forKey:kAdIconImageKey];
    if (nativeAd.data.imageAry.count > 0) {
        [dic setValue:nativeAd.data.imageAry.firstObject.imageURL forKey:kAdMainImageKey];
    }
    self.mediaView = [[UIView alloc] init];
    [dic setValue:self.mediaView forKey:kAdMainMediaViewKey];
    // This is translate the Pangle nativeAd
    [dic setValue:nativeAd forKey:@"bu_nativeAd"];
    return [dic copy];
}

- (BOOL)enableThirdPartyClickTracking {
    return NO;
}

- (UIView *)mainMediaView
{
    return self.mediaView;
}

@end
