//
//  BUDMopub_MPNativeCustomEvent.h
//  BUDemo
//
//  Created by Pangle on 2020/1/8.
//  Copyright © 2020 Pangle. All rights reserved.
//

#import <mopub-ios-sdk/MPNativeAdAdapter.h>
#import <BUAdSDK/BUNativeAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface PangleNativeAdAdapter : NSObject  <MPNativeAdAdapter>

- (instancetype)initWithBUNativeAd:(BUNativeAd *)nativeAd;
@property (nonatomic, strong) NSDictionary *properties;
@property (nonatomic, strong) NSURL *defaultActionURL;

@end

NS_ASSUME_NONNULL_END

