//
//  PangleInterstitialCustomEvent.h
//  BUAdSDKDemo
//
//  Created by Pangle on 2018/10/25.
//  Copyright © 2018年 Pangle. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
#import <MoPubSDKFramework/MoPub.h>
#else
#import "MPInterstitialCustomEvent.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface PangleInterstitialCustomEvent : MPInterstitialCustomEvent

@end

NS_ASSUME_NONNULL_END
