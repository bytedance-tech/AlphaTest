//
//  PangleNativeCustomEvent.h
//  BUDemo
//
//  Created by Pangle on 2020/1/8.
//  Copyright © 2020 Pangle. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MPNativeCustomEvent.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface PangleNativeCustomEvent : MPNativeCustomEvent 

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup;
- (void)requestAdWithCustomEventInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
