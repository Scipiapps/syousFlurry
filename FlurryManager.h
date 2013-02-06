//
//  FlurryManager.h
//  BeautyNow
//
//  Created by zedoul on 12/18/12.
//  Copyright (c) 2012 scipi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FLURRY_MODE_NULL,
    FLURRY_MODE_DEVELOP,
    FLURRY_MODE_RELEASE,
    FLURRY_MODE_MAX
} FLURRY_MODES;

typedef enum {
    FLURRY_GENDER_NULL,
    FLURRY_GENDER_M,
    FLURRY_GENDER_F,
    FLURRY_GENDER_MAX
} FLURRY_GENDERS;

@interface FlurryManager : NSObject {
    FLURRY_MODES mode;
}

+ (FlurryManager*) getSingleton;
- (int) setMode:(FLURRY_MODES) mode;
- (int) start:(NSString*)ID;
- (int) userID:(NSString*)ID;
- (int) userAge:(NSInteger) age;
- (int) userGender:(FLURRY_GENDERS)gender;
- (int) pause;
- (int) resume;
- (int) finish;
- (int) event:(NSString*)name;
- (int) event:(NSString*)name key:(NSString*)event value:(NSString*)msg;
- (int) event:(NSString*)name params:(NSDictionary*)data;

@end
