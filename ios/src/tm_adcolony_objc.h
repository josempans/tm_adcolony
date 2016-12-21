#ifndef TM_ADCOLONY_OBJC_H
#define TM_ADCOLONY_OBJC_H

#import <UIKit/UIKit.h>
#import <AdColony/AdColony.h>

@interface AdColonyModule : UIViewController

@property (nonatomic, retain) AdColonyInterstitial *ad;
@property (nonatomic, assign) UIViewController *rootView;
@property (nonatomic, retain) NSString *appId;
@property (nonatomic, retain) NSString *zoneId;

-(void) setup:(NSString*)appId withZone:(NSString*)zoneId;
-(void) requestInterstitial;
-(void) launchInterstitial;
-(void) emitSignal;
@end

#endif // TM_ADCOLONY_OBJC_H
