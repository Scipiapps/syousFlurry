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

@interface FlurryManager : NSObject {
    FLURRY_MODES mode;
}

+ (FlurryManager*) getSingleton;
- (int) setMode:(FLURRY_MODES) mode;
- (int) start:(NSString*)ID;
- (int) pause;
- (int) resume;
- (int) finish;
- (int) action:(NSString*)action msg:(NSString*)msg;

@end
