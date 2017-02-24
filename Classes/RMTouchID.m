//
//  RMTouchID.m
//  RMTouchID
//
//  Created by Allan Ederich on 12/26/16.
//  Copyright © 2016 Allan Ederich. All rights reserved.
//

#import "RMTouchID.h"

@interface RMTouchID()

@property (nonatomic, strong) LAContext * context;

@end

@implementation RMTouchID

#pragma mark - Static methods
+ (BOOL) canAuthenticateWithError:(NSError **) error
{
    if ([NSClassFromString(@"LAContext") class]) {
        RMTouchID *instance = [RMTouchID sharedInstance];
        if ([instance.context canEvaluatePolicy: instance.policy error:error]) {
            return YES;
        }
        return NO;
    }
    return NO;
}

static RMTouchID *sharedInstance;
+ (RMTouchID *) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RMTouchID alloc] init];
    });

    return sharedInstance;
}

#pragma mark - Constructor
- (instancetype)init{
    if (self = [super init]) {
        self.context = [[LAContext alloc] init];
        self.policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    }
    return self;
}

#pragma mark - Authenticate
- (void) authenticateWithCompletion:(RMTouchIDCompletionBlock) completion
{
    self.context = [[LAContext alloc] init];
    [self.context evaluatePolicy: LAPolicyDeviceOwnerAuthentication
                 localizedReason: self.reason
                           reply:^(BOOL authenticated, NSError *error) {
                               DispatchMainThread(^() {
                                   completion(authenticated, error);
                               });
                           }];
}

@end
