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

+ (BOOL) isBiometryEnabled;

+ (BOOL) isFaceIdEnabled;

@property (nonatomic, copy) NSString * reason;

@property (nonatomic, assign) LAPolicy policy;

- (void) authenticateWithCompletion:(RMTouchIDCompletionBlock) success;

@end
