// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FLTFirebasePerformancePlugin+Internal.h"

@implementation FLTFirebasePerformancePlugin
static NSMutableDictionary<NSNumber *, id<MethodCallHandler>> *methodHandlers;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  methodHandlers = [NSMutableDictionary new];

  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"plugins.flutter.io/firebase_performance"
                                  binaryMessenger:[registrar messenger]];

  FLTFirebasePerformancePlugin *instance = [FLTFirebasePerformancePlugin new];
  [registrar addMethodCallDelegate:instance channel:channel];

  SEL sel = NSSelectorFromString(@"registerLibrary:withVersion:");
  if ([FIRApp respondsToSelector:sel]) {
    [FIRApp performSelector:sel withObject:LIBRARY_NAME withObject:LIBRARY_VERSION];
  }
}

- (instancetype)init {
  self = [super init];
  return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSNumber *handle = call.arguments[@"handle"];
  if (![handle isEqual:[NSNull null]]) {
    if (![methodHandlers objectForKey:handle]) {
      FLTFirebasePerformance *performance = [FLTFirebasePerformance sharedInstance];
      [FLTFirebasePerformancePlugin addMethodHandler:handle methodHandler:performance];
    }
    [methodHandlers[handle] handleMethodCall:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

+ (void)addMethodHandler:(NSNumber *)handle methodHandler:(id<MethodCallHandler>)handler {
  if (methodHandlers[handle]) {
    NSString *reason =
        [[NSString alloc] initWithFormat:@"Object for handle already exists: %d", handle.intValue];
    @throw [[NSException alloc] initWithName:NSInvalidArgumentException reason:reason userInfo:nil];
  }

  methodHandlers[handle] = handler;
}

+ (void)removeMethodHandler:(NSNumber *)handle {
  [methodHandlers removeObjectForKey:handle];
}
@end
