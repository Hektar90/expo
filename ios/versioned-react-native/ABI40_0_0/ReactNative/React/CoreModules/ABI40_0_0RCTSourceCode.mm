/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI40_0_0RCTSourceCode.h"

#import <ABI40_0_0FBReactNativeSpec/ABI40_0_0FBReactNativeSpec.h>

#import <ABI40_0_0React/ABI40_0_0RCTBridge.h>

#import "ABI40_0_0CoreModulesPlugins.h"

using namespace ABI40_0_0facebook::ABI40_0_0React;

@interface ABI40_0_0RCTSourceCode () <ABI40_0_0NativeSourceCodeSpec>
@end

@implementation ABI40_0_0RCTSourceCode

ABI40_0_0RCT_EXPORT_MODULE()

@synthesize bridge = _bridge;

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

- (NSDictionary<NSString *, id> *)constantsToExport
{
  return [self getConstants];
}

- (NSDictionary<NSString *, id> *)getConstants
{
  return @{
    @"scriptURL" : self.bridge.bundleURL.absoluteString ?: @"",
  };
}

- (std::shared_ptr<TurboModule>)getTurboModuleWithJsInvoker:(std::shared_ptr<CallInvoker>)jsInvoker
                                              nativeInvoker:(std::shared_ptr<CallInvoker>)nativeInvoker
                                                 perfLogger:(id<ABI40_0_0RCTTurboModulePerformanceLogger>)perfLogger
{
  return std::make_shared<NativeSourceCodeSpecJSI>(self, jsInvoker, nativeInvoker, perfLogger);
}

@end

Class ABI40_0_0RCTSourceCodeCls(void)
{
  return ABI40_0_0RCTSourceCode.class;
}
