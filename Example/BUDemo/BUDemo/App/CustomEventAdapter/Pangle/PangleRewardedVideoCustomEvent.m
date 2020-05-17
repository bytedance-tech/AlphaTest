//
//  PangleRewardedVideoCustomEvent.m
//  mopub_adaptor
//
//  Created by Pangle on 2018/9/18.
//  Copyright © 2018年 Pangle. All rights reserved.
//

#import "PangleRewardedVideoCustomEvent.h"
#import <BUAdSDK/BUAdSDK.h>
#if __has_include("MoPub.h")
#import "MPLogging.h"
#import "MPRewardedVideoError.h"
#import "MPRewardedVideoReward.h"
#endif
#import "PangleAdapterConfiguration.h"

@interface PangleRewardedVideoCustomEvent ()<BURewardedVideoAdDelegate>
@property (nonatomic, strong) BURewardedVideoAd *rewardVideoAd;
@property (nonatomic, copy) NSString *adPlacementId;

@end

@implementation PangleRewardedVideoCustomEvent

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    BOOL hasAdMarkup = adMarkup.length > 0;
    NSString * appId = [info objectForKey:@"app_id"];
    if (appId != nil){
        [PangleAdapterConfiguration updateInitializationParameters:info];
    }
    self.adPlacementId = [info objectForKey:@"ad_placement_id"];
    if (self.adPlacementId == nil) {
        NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:@{NSLocalizedDescriptionKey: @"Invalid Pangle placement ID"}];
        MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
        [self.delegate rewardedVideoDidFailToPlayForCustomEvent:self error:error];
        return;
    }
    
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"pangle";
    
    BURewardedVideoAd *RewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:self.adPlacementId rewardedVideoModel:model];
    RewardedVideoAd.delegate = self;
    self.rewardVideoAd = RewardedVideoAd;
    if (hasAdMarkup) {
        [RewardedVideoAd setMopubAdMarkUp:adMarkup];
    }else{
        [RewardedVideoAd loadAdData];
    }
}

- (BOOL)hasAdAvailable {
    return self.rewardVideoAd.isAdValid;
}
    
- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController {
    [self.rewardVideoAd showAdFromRootViewController:viewController];
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return NO;
}

#pragma mark BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    MPLogAdEvent([MPLogEvent adLoadSuccessForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
}

- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:error];
}

- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd {
    MPLogAdEvent([MPLogEvent adWillPresentModalForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoWillAppearForCustomEvent:self];
    [self.delegate trackImpression];
    [self.delegate rewardedVideoDidAppearForCustomEvent:self];
    MPLogAdEvent([MPLogEvent adDidAppearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    MPLogAdEvent([MPLogEvent adWillDisappearForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    MPLogAdEvent([MPLogEvent adTappedForAdapter:NSStringFromClass(self.class)], [self getAdNetworkId]);
    [self.delegate rewardedVideoDidReceiveTapEventForCustomEvent:self];
    [self.delegate trackClick];
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    MPLogAdEvent([MPLogEvent adLoadFailedForAdapter:NSStringFromClass(self.class) error:error], [self getAdNetworkId]);
    if(error != nil)
        [self.delegate rewardedVideoDidFailToPlayForCustomEvent:self error:error];
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
    if (verify) {
        MPRewardedVideoReward *reward = [[MPRewardedVideoReward alloc] initWithCurrencyType:self.rewardVideoAd.rewardedVideoModel.rewardName amount:[NSNumber numberWithInteger:self.rewardVideoAd.rewardedVideoModel.rewardAmount]];
        MPLogAdEvent([MPLogEvent adShouldRewardUserWithReward:reward],[self getAdNetworkId]);
        [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:reward];
    }
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
}

- (NSString *) getAdNetworkId {
    return (self.adPlacementId != nil) ? self.adPlacementId : @"";
}

@end
