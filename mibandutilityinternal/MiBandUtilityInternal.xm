//
//  MiBandUtilityInternal.xm
//  MiBandUtilityInternal
//
//  Created by Pigi Galdi on 27.05.2015.
//  Copyright (c) 2015 Pigi Galdi. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <substrate.h>

%group mifit
// 	+ Hook MiBand app to intercept method.
%hook MainViewController
- (void)refreshWristbandCircleWithConnect {
	// connecting..
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.pigigaldi.mibandutilitypreferences.connectingfrommifit"), NULL, NULL, true);
	// call original method.
	%orig();
}
%end
%end

%ctor {
	@autoreleasepool {
		%init(mifit);
	}
}
