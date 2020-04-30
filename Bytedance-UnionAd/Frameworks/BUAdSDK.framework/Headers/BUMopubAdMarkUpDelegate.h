//
//  BUMopubAdMarkUpDelegate.h
//  BUAdSDK
//
//  Created by Siwant on 2020/4/24.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BUMopubAdMarkUpDelegate <NSObject>
@optional

/** Mopub AdMarkUp
  */
- (void)setMopubAdMarkUp:(NSString *)adm;

/** Mopub Adaptor get AD type from rit
  *   @return  @{@"adSlotType": @(1), @"renderType": @(1)}
  *   adSlotTyore refer from BUAdSlotAdType in "BUAdSlot.h"
  *   showType: @"1" express AD   @"2" native AD
  */
+ (NSDictionary *)AdTypeWithRit:(NSString *)rit;

/** Mopub bidding Adaptor get AD type from adm
  *  @return  @{@"adSlotType": @(1), @"renderType": @(1), @"adSlotID": @"900546859"}
  *  adSlotTyore refer from BUAdSlotAdType in "BUAdSlot.h"
  *  showType: @"1" express AD   @"2" native AD
  */
+ (NSDictionary *)AdTypeWithAdMarkUp:(NSString *)adm;


/// Mopub Bidding Token
+ (NSString *)mopubBiddingToken;
@end

NS_ASSUME_NONNULL_END