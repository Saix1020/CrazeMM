//
// Created by Eli Perkins on 3/18/14.
// Copyright (c) 2014 One Mighty Roar. All rights reserved.
//

#import <objc/runtime.h>
#import "ReactiveCocoa.h"
#import "UISearchBar+RACSignalSupport.h"
#import <ReactiveCocoa/EXTScope.h>
#import <Reactivecocoa/RACDelegateProxy.h>
#import <Reactivecocoa/RACCompoundDisposable.h>
#import <Reactivecocoa/RACDisposable.h>
#import <Reactivecocoa/RACSignal.h>
#import <Reactivecocoa/RACSubscriber.h>
#import <Reactivecocoa/NSObject+RACDeallocating.h>
#import <Reactivecocoa/NSObject+RACDescription.h>

static void *UISearchBarRACCommandKey = &UISearchBarRACCommandKey;
static void *UISearchBarDisposableKey = &UISearchBarDisposableKey;

@implementation UISearchBar (RACSignalSupport)

- (RACSignal *)rac_textSignal {
    self.delegate = self;
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if (signal != nil) return signal;
    
    /* Create signal from selector */
    signal = [[self rac_signalForSelector:@selector(searchBar:textDidChange:)
                             fromProtocol:@protocol(UISearchBarDelegate)] map:^id(RACTuple *tuple) {
        return tuple.second;
    }];
    
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
}

@end