/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <Foundation/Foundation.h>

@class ABI40_0_0RCTJSStackFrame;

/**
 * An ObjC wrapper for ABI40_0_0React Native errors.
 */
@interface ABI40_0_0RCTErrorInfo : NSObject
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, copy, readonly) NSArray<ABI40_0_0RCTJSStackFrame *> *stack;

- (instancetype)initWithErrorMessage:(NSString *)errorMessage stack:(NSArray<ABI40_0_0RCTJSStackFrame *> *)stack;

@end
