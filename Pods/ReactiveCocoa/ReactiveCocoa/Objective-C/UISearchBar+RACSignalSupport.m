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

static void RACUseDelegateProxy(UISearchBar *self) {
    if (self.delegate == self.rac_delegateProxy) return;
    
    self.rac_delegateProxy.rac_proxiedDelegate = self.delegate;
    self.delegate = (id)self.rac_delegateProxy;
}

- (RACDelegateProxy *)rac_delegateProxy {
    RACDelegateProxy *proxy = objc_getAssociatedObject(self, _cmd);
    if (proxy == nil) {
        proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UISearchBarDelegate)];
        objc_setAssociatedObject(self, _cmd, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return proxy;
}

- (RACSignal *)rac_textSignal {
    @weakify(self);
    RACSignal *signal = [[[[[RACSignal
                             defer:^{
                                 @strongify(self);
                                 return [RACSignal return:RACTuplePack(self)];
                             }]
                            concat:[self.rac_delegateProxy signalForSelector:@selector(searchBar:textDidChange:)]]
                           reduceEach:^(UISearchBar *_, NSString *searchText) {
                               return searchText;
                           }]
                          takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ -rac_textSignal", [self rac_description]];
    
    RACUseDelegateProxy(self);
    
    return signal;
}

- (RACCommand *)rac_searchCommand {
    return objc_getAssociatedObject(self, UISearchBarRACCommandKey);
}

- (void)setRac_searchCommand:(RACCommand *)command {
    objc_setAssociatedObject(self, UISearchBarRACCommandKey, command, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // Dispose of any active command associations.
    [objc_getAssociatedObject(self, UISearchBarDisposableKey) dispose];
    
    if (command == nil) return;
    
    RACDisposable *executionDisposable = [[[[self.rac_delegateProxy
                                             signalForSelector:@selector(searchBarSearchButtonClicked:)]
                                            reduceEach:^(UISearchBar *x) {
                                                return [[[command
                                                          execute:x]
                                                         catchTo:[RACSignal empty]]
                                                        then:^{
                                                            return [RACSignal return:x];
                                                        }];
                                            }]
                                           concat]
                                          subscribeNext:^(UISearchBar *x) {
                                              [x resignFirstResponder];
                                          }];
    
    RACDisposable *commandDisposable = [RACCompoundDisposable compoundDisposableWithDisposables:@[ executionDisposable ]];
    objc_setAssociatedObject(self, UISearchBarDisposableKey, commandDisposable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)rac_description {
    return self.description;
}

@end