//
//  FlurryManager.m
//  BeautyNow
//
//  Created by zedoul on 12/18/12.
//  Copyright (c) 2012 scipi. All rights reserved.
//

#import "FlurryManager.h"
#import "Flurry.h"

#define FLURRY_EVENT_START @"START"
#define FLURRY_EVENT_FINISH @"START"
#define FLURRY_EVENT_PAUSE @"PAUSE"
#define FLURRY_EVENT_RESUME @"RESUME"

@implementation FlurryManager

static FlurryManager* InstanceofFlurryManager= nil;

+ (FlurryManager*) getSingleton {
    if( nil == InstanceofFlurryManager){
		InstanceofFlurryManager = [[FlurryManager alloc] init];
        InstanceofFlurryManager->mode = FLURRY_MODE_NULL;
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
            NSLog(@"- user [%@]",[[UIDevice currentDevice] uniqueIdentifier]);
            NSLog(@"- logevent [%@]", FLURRY_EVENT_START);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry startSession:ID];
            [Flurry setUserID:[[UIDevice currentDevice] uniqueIdentifier]];
            [Flurry logEvent:FLURRY_EVENT_START timed:YES];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) pause {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"- logevent [%@]", FLURRY_EVENT_PAUSE);
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
            NSLog(@"- logevent [%@]", FLURRY_EVENT_RESUME);
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
            NSLog(@"- logevent [%@]", FLURRY_EVENT_FINISH);
            return -1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry endTimedEvent:FLURRY_EVENT_FINISH withParameters:nil];
            return 1;
            
        default:
            return -1;
            break;
    }
}

- (int) action:(NSString*)action key:(NSString*)event value:(NSString*)msg {
    switch (mode) {
        case FLURRY_MODE_DEVELOP:
            NSLog(@"- logevent [%@]:(%@=%@)", action, event, msg);
            return 1;
            
        case FLURRY_MODE_RELEASE:
            [Flurry logEvent:action
              withParameters:[NSDictionary dictionaryWithObjectsAndKeys:msg, event, nil]
                       timed:YES];
            return 1;
            
        default:
            return -1;
            break;
    }
}


@end
