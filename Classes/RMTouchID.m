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

static RMTouchID *sharedInstance;

+ (RMTouchID *) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RMTouchID alloc] init];
    });

    return sharedInstance;
}

#pragma mark - Class methods
+ (BOOL) isBiometryEnabled
{
    if ([NSClassFromString(@"LAContext") class]) {
        RMTouchID *instance = [RMTouchID sharedInstance];
        if ([instance.context canEvaluatePolicy: instance.policy error:nil]) {
            return YES;
        }
        return NO;
    }
    return NO;
}

#pragma mark - Class methods
+ (BOOL) isFaceIdEnabled
{
    BOOL isBiometryEnabled = [RMTouchID isBiometryEnabled];
    
    if (isBiometryEnabled) {
        NSString *version = [[UIDevice currentDevice] systemVersion];
        float versionInFloat = [version floatValue];
        if (versionInFloat < 11.0) {
            return NO;
        } else {
            RMTouchID *instance = [RMTouchID sharedInstance];
            if (instance.context.biometryType == LABiometryTypeFaceID) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    return NO;
}

#pragma mark - Constructor
- (instancetype) init
{
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
