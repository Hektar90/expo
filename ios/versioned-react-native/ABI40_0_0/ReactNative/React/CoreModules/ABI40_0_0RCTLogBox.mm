/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI40_0_0RCTLogBox.h"

#import <ABI40_0_0FBReactNativeSpec/ABI40_0_0FBReactNativeSpec.h>
#import <ABI40_0_0React/ABI40_0_0RCTBridge.h>
#import <ABI40_0_0React/ABI40_0_0RCTConvert.h>
#import <ABI40_0_0React/ABI40_0_0RCTDefines.h>
#import <ABI40_0_0React/ABI40_0_0RCTErrorInfo.h>
#import <ABI40_0_0React/ABI40_0_0RCTEventDispatcher.h>
#import <ABI40_0_0React/ABI40_0_0RCTJSStackFrame.h>
#import <ABI40_0_0React/ABI40_0_0RCTRedBoxSetEnabled.h>
#import <ABI40_0_0React/ABI40_0_0RCTReloadCommand.h>
#import <ABI40_0_0React/ABI40_0_0RCTRootView.h>
#import <ABI40_0_0React/ABI40_0_0RCTSurface.h>
#import <ABI40_0_0React/ABI40_0_0RCTUtils.h>

#import <objc/runtime.h>

#import "ABI40_0_0CoreModulesPlugins.h"

#if ABI40_0_0RCT_DEV_MENU

@class ABI40_0_0RCTLogBoxView;

@interface ABI40_0_0RCTLogBoxView : UIWindow
@end

@implementation ABI40_0_0RCTLogBoxView {
  ABI40_0_0RCTSurface *_surface;
}

- (instancetype)initWithFrame:(CGRect)frame bridge:(ABI40_0_0RCTBridge *)bridge
{
  if ((self = [super initWithFrame:frame])) {
    self.windowLevel = UIWindowLevelStatusBar - 1;
    self.backgroundColor = [UIColor clearColor];

    _surface = [[ABI40_0_0RCTSurface alloc] initWithBridge:bridge moduleName:@"LogBox" initialProperties:@{}];

    [_surface start];
    [_surface setSize:frame.size];

    if (![_surface synchronouslyWaitForStage:ABI40_0_0RCTSurfaceStageSurfaceDidInitialMounting timeout:1]) {
      ABI40_0_0RCTLogInfo(@"Failed to mount LogBox within 1s");
    }

    UIViewController *_rootViewController = [UIViewController new];
    _rootViewController.view = (UIView *)_surface.view;
    _rootViewController.view.backgroundColor = [UIColor clearColor];
    _rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    self.rootViewController = _rootViewController;
  }
  return self;
}

- (void)dealloc
{
  [ABI40_0_0RCTSharedApplication().delegate.window makeKeyWindow];
}

- (void)show
{
  [self becomeFirstResponder];
  [self makeKeyAndVisible];
}

@end

@interface ABI40_0_0RCTLogBox () <ABI40_0_0NativeLogBoxSpec>
@end

@implementation ABI40_0_0RCTLogBox {
  ABI40_0_0RCTLogBoxView *_view;
}

@synthesize bridge = _bridge;

ABI40_0_0RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

ABI40_0_0RCT_EXPORT_METHOD(show)
{
  if (ABI40_0_0RCTRedBoxGetEnabled()) {
    __weak ABI40_0_0RCTLogBox *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
      __strong ABI40_0_0RCTLogBox *strongSelf = weakSelf;
      if (!strongSelf) {
        return;
      }
      if (!strongSelf->_view) {
        strongSelf->_view = [[ABI40_0_0RCTLogBoxView alloc] initWithFrame:[UIScreen mainScreen].bounds bridge:self->_bridge];
      }
      [strongSelf->_view show];
    });
  }
}

ABI40_0_0RCT_EXPORT_METHOD(hide)
{
  if (ABI40_0_0RCTRedBoxGetEnabled()) {
    __weak ABI40_0_0RCTLogBox *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
      __strong ABI40_0_0RCTLogBox *strongSelf = weakSelf;
      if (!strongSelf) {
        return;
      }
      strongSelf->_view = nil;
    });
  }
}

- (std::shared_ptr<ABI40_0_0facebook::ABI40_0_0React::TurboModule>)
    getTurboModuleWithJsInvoker:(std::shared_ptr<ABI40_0_0facebook::ABI40_0_0React::CallInvoker>)jsInvoker
                  nativeInvoker:(std::shared_ptr<ABI40_0_0facebook::ABI40_0_0React::CallInvoker>)nativeInvoker
                     perfLogger:(id<ABI40_0_0RCTTurboModulePerformanceLogger>)perfLogger
{
  return std::make_shared<ABI40_0_0facebook::ABI40_0_0React::NativeLogBoxSpecJSI>(self, jsInvoker, nativeInvoker, perfLogger);
}

@end

#else // Disabled

@interface ABI40_0_0RCTLogBox () <ABI40_0_0NativeLogBoxSpec>
@end

@implementation ABI40_0_0RCTLogBox

+ (NSString *)moduleName
{
  return nil;
}

- (void)show
{
  // noop
}

- (void)hide
{
  // noop
}

- (std::shared_ptr<ABI40_0_0facebook::ABI40_0_0React::TurboModule>)
    getTurboModuleWithJsInvoker:(std::shared_ptr<ABI40_0_0facebook::ABI40_0_0React::CallInvoker>)jsInvoker
                  nativeInvoker:(std::shared_ptr<ABI40_0_0facebook::ABI40_0_0React::CallInvoker>)nativeInvoker
                     perfLogger:(id<ABI40_0_0RCTTurboModulePerformanceLogger>)perfLogger
{
  return std::make_shared<ABI40_0_0facebook::ABI40_0_0React::NativeLogBoxSpecJSI>(self, jsInvoker, nativeInvoker, perfLogger);
}
@end

#endif

Class ABI40_0_0RCTLogBoxCls(void)
{
  return ABI40_0_0RCTLogBox.class;
}
