//
//  BUAdSDKAdapterConfiguration.h
//  BUADDemo
//
//  Created by Siwant on 2019/8/9.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPBaseAdapterConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BURenderMethod) {
    BURenderMethodOrigin    = 1,    // native express
    BURenderMethodDynamic   = 2,    // general
};

@interface BUAdSDKAdapterConfiguration :MPBaseAdapterConfiguration

@property (nonatomic, copy, readonly) NSString * adapterVersion;
@property (nonatomic, copy, readonly) NSString * biddingToken;
@property (nonatomic, copy, readonly) NSString * moPubNetworkName;
@property (nonatomic, copy, readonly) NSString * networkSdkVersion;
/// @required   render Method
@property (nonatomic, assign) BURenderMethod renderMethod;

+ (void)updateInitializationParameters:(NSDictionary *)parameters;

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> * _Nullable)configuration complete:(void(^ _Nullable)(NSError * _Nullable))complete;
@end

NS_ASSUME_NONNULL_END
