//
//  RMTouchID.h
//  RMTouchID
//
//  Created by Allan Ederich on 12/26/16.
//  Copyright © 2016 Allan Ederich. All rights reserved.
//
#define DispatchMainThread(block, ...) if(block) dispatch_async(dispatch_get_main_queue(), ^{ block(__VA_ARGS__); })

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

typedef void(^RMTouchIDCompletionBlock)(BOOL, NSError*);

@interface RMTouchID : NSObject

+ (RMTouchID *) sharedInstance;

// Reason string presented to the user in auth dialog
@property (nonatomic, copy) NSString * reason;

// Default value is LAPolicyDeviceOwnerAuthenticationWithBiometrics.
@property (nonatomic, assign) LAPolicy policy;

// Returns YES if device and Apple ID can use Touch ID. If there is an error, it returns NO and assigns error so that UI can respond accordingly
+ (BOOL) canAuthenticateWithError:(NSError **) error;

// Authenticate the user by showing the Touch ID dialog and calling your success or failure block.  Failure block will return an NSError with a code of enum type LAError: https://developer.apple.com/library/ios/documentation/LocalAuthentication/Reference/LAContext_Class/index.html#//apple_ref/c/tdef/LAError
// Use the error to handle different types of failure and fallback authentication.
- (void) authenticateWithCompletion:(RMTouchIDCompletionBlock) success;

@end
