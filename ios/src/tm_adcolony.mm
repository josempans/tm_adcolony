/*
    AdColony module for Godot
    by José M. Pan
*/

#include "tm_adcolony.h"
#import "tm_adcolony_objc.h"


@implementation AdColonyModule
@synthesize ad = _ad;
@synthesize rootView = _rootView;
@synthesize appId = _appId;
@synthesize zoneId = _zoneId;

-(id) init {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    _rootView = window.rootViewController;
    _ad = nil;
    _appId = @"";
    _zoneId = @"";

    return self;
}

-(void) setup:(NSString*)appId withZone:(NSString*)zoneId {
    [self setAppId: appId];
    [self setZoneId: zoneId];

    [AdColony
    configureWithAppID:_appId
    zoneIDs:@[_zoneId]
    options:nil
    completion:^(NSArray<AdColonyZone *> * zones) {
            [self requestInterstitial];
        }
    ];
}

-(void) requestInterstitial {
    if (_ad != nil && !_ad.expired) return;

    [AdColony
    requestInterstitialInZone:[self zoneId]
    options:nil
    success:^(AdColonyInterstitial *ad) {
        ad.close = ^{
                [self setAd: nil];
                [self requestInterstitial];
        };
        ad.expire = ^{
                [self setAd: nil];
                [self requestInterstitial];
        };

        [self setAd: ad];
        [_ad setClose:^{
                [self emitSignal];
            }
        ];
    }

    failure:^(AdColonyAdRequestError *error) {
        NSLog(@"SAMPLE_APP: Request failed with error: %@ and suggestion: %@", [error localizedDescription], [error localizedRecoverySuggestion]);
    }
    ];
}

-(void) launchInterstitial {
    if (!_ad.expired) {
        [_ad showWithPresentingViewController:[self rootView]];
    }
}

-(void) emitSignal {
    return TMAdColony::getInstance()->emitAdFinishedSignal();
}
@end

static AdColonyModule* s_adColonyModule = nil;
TMAdColony* TMAdColony::instance = NULL;

void TMAdColony::setup(String app_id, String zone_id) {
    if (!initialized) {
        NSString *appId = [NSString stringWithCString:app_id.utf8().get_data() encoding:NSUTF8StringEncoding];
        NSString *zoneId = [NSString stringWithCString:zone_id.utf8().get_data() encoding:NSUTF8StringEncoding];

        s_adColonyModule = [[AdColonyModule alloc] init];
        [s_adColonyModule setup:appId withZone:zoneId];

        initialized = true;
    }
}

void TMAdColony::requestInterstitial() {
    if (!initialized) return;
    [s_adColonyModule requestInterstitial];
}

void TMAdColony::launchInterstitial() {
    if (!initialized) return;
    [s_adColonyModule launchInterstitial];
}

void TMAdColony::emitAdFinishedSignal() {
    emit_signal("video_ad_finished");
}

void TMAdColony::_bind_methods() {
    ADD_SIGNAL(MethodInfo("video_ad_finished"));

    ObjectTypeDB::bind_method(_MD("setup"), &TMAdColony::setup);
    ObjectTypeDB::bind_method(_MD("request_interstitial"), &TMAdColony::requestInterstitial);
    ObjectTypeDB::bind_method(_MD("launch_interstitial"), &TMAdColony::launchInterstitial);
}

TMAdColony::TMAdColony() {
    ERR_FAIL_COND(instance != NULL);
    instance = this;
    initialized = false;
}

TMAdColony::~TMAdColony(){}

