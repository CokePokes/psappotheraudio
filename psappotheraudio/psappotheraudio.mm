//
//  psappotheraudio.mm
//  psappotheraudio
//
//  Created by CokePokes on 4/6/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#if TARGET_OS_SIMULATOR
#error Do not support the simulator, please use the real iPhone Device.
#endif

#import <Foundation/Foundation.h>
#import <CaptainHook/CaptainHook.h>
#include <notify.h> // not required; for examples only
#import <AVFoundation/AVFoundation.h>

CHDeclareClass(AVAudioSession); // declare class

CHOptimizedMethod3(self, void, AVAudioSession, setCategory, AVAudioSessionCategory, arg1, withOptions, AVAudioSessionCategoryOptions, arg2, error, NSError **, arg3) {
    CHSuper3(AVAudioSession, setCategory, arg1, withOptions, arg2|AVAudioSessionCategoryOptionMixWithOthers, error, arg3);
}

CHOptimizedMethod4(self, void, AVAudioSession, setCategory, AVAudioSessionCategory, arg1, mode, AVAudioSessionMode, arg2,options, AVAudioSessionCategoryOptions, arg3, error, NSError **, arg4) {
    CHSuper4(AVAudioSession, setCategory, arg1, mode, arg2, options, arg3|AVAudioSessionCategoryOptionMixWithOthers, error, arg4);
}

CHConstructor // code block that runs immediately upon load
{
	@autoreleasepool
	{
        CHLoadLateClass(AVAudioSession);
        CHHook3(AVAudioSession, setCategory, withOptions, error);
        CHHook4(AVAudioSession, setCategory, mode, options, error);
	}
}
