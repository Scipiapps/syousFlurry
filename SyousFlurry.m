//
//  FlurryManager.m
//  BeautyNow
//
//  Created by zedoul on 12/18/12.
//  Copyright (c) 2012 scipi. All rights reserved.
//

#import "SyousFlurry.h"
#import "Flurry.h"

#define FLURRY_EVENT_START @"START"
#define FLURRY_EVENT_FINISH @"START"
#define FLURRY_EVENT_PAUSE @"PAUSE"
#define FLURRY_EVENT_RESUME @"RESUME"

@implementation SyousFlurry

static SyousFlurry* InstanceofFlurryManager= nil;

+ (SyousFlurry*) getSingleton {
    if( nil == InstanceofFlurryManager){
		InstanceofFlurryManager = [[SyousFlurry alloc] init];
        InstanceofFlurryManager->mode = FLURRY_MODE_DEVELOP;
	}
	return InstanceofFlurryManager;
}

- (int) setMode:(FLURRY_MODES) mode_ {
    if (FLURRY_MODE_NULL >= mode_ || FLURRY_MODE_MAX <= mode_) {
        return -1;
    }
    
    switch (self->mode) {
        case FLURRY_MODE_NULL:
            self->mode = mode_;
            break;
        default:
            return -1;
    }
    
    return 1;
}

- (int) start:(NSString*)ID {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- logevent [%@]", FLURRY_EVENT_START);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry startSession:ID];
            [Flurry logEvent:FLURRY_EVENT_START timed:YES];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) userID:(NSString*) ID {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- userID [%@]",ID);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry setUserID:ID];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) userAge:(NSInteger) age {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- userAge [%d]",age);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry setAge:age];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) userGender:(FLURRY_GENDERS)gender {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- userGender [%d]",gender);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            if (FLURRY_GENDER_M == gender) {
                [Flurry setGender:@"m"];
            } else if (FLURRY_GENDER_F == gender){
                [Flurry setGender:@"f"];
            } else {
                assert(0);
            }
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) pause {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- logevent [%@]", FLURRY_EVENT_PAUSE);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry logEvent:FLURRY_EVENT_PAUSE timed:YES];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) resume {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- logevent [%@]", FLURRY_EVENT_RESUME);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry logEvent:FLURRY_EVENT_RESUME timed:YES];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) finish {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- logevent [%@]", FLURRY_EVENT_FINISH);
            return -1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry endTimedEvent:FLURRY_EVENT_FINISH withParameters:nil];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) event:(NSString*)name {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- logevent [%@]", name);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry logEvent:name timed:YES];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) event:(NSString*)name key:(NSString*)event value:(NSString*)msg {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- logevent [%@]:(%@=%@)", name, event, msg);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry logEvent:name
              withParameters:[NSDictionary dictionaryWithObjectsAndKeys:msg, event, nil]
                       timed:YES];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) event:(NSString*)name params:(NSDictionary*)data {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"[Flurry]- logevent [%@]:(%@)", name, data);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry logEvent:name
              withParameters:data
                       timed:YES];
            return 1;
            
        default:
            return -1;
            break;
    }
}

@end