//
//  JasonVibrationAction.m
//  Jasonette
//
//  Created by Camilo Castro on 21-02-17.
//  Copyright (c) 2017 Ninjas.cl
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "JasonVibrationAction.h"
#import "JasonOptionHelper.h"

#import <AVFoundation/AVFoundation.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

// AudioServicesPlaySystemSound (1352) works for iPhones regardless of silent switch position
int const kForceVibrationId = 1352;

@implementation JasonVibrationAction

- (void) activate
{
    
    JasonOptionHelper * options = [[JasonOptionHelper alloc]
                                   initWithOptions:self.options];
    
    BOOL forceVibration = [[options getNumber:@"force"] boolValue];
    
    int vibrationId = kSystemSoundID_Vibrate;
    
    if (forceVibration && [[UIDevice currentDevice].model
                           isEqualToString:@"iPhone"])
    {
        vibrationId = kForceVibrationId;
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
    {

        AudioServicesPlayAlertSoundWithCompletion(vibrationId, nil);
    }
    else
    {
        AudioServicesPlayAlertSound(vibrationId);
    }

    [[Jason client] success];
}

@end