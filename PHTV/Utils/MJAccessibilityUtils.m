//
//  MJAccessibilityUtils.m
//  PHTV
//
//  Modified by Phạm Hùng Tiến on 2026.
//  Copyright © 2026 Phạm Hùng Tiến. All rights reserved.
//
//  Source: https://github.com/Hammerspoon/hammerspoon/blob/master/Hammerspoon/MJAccessibilityUtils.m
//  License: MIT


#import "MJAccessibilityUtils.h"
#import "../Managers/PHTVManager.h"
#import <AppKit/AppKit.h>
// #import "HSLogger.h"

extern Boolean AXAPIEnabled(void);
extern Boolean AXIsProcessTrustedWithOptions(CFDictionaryRef options) __attribute__((weak_import));
extern CFStringRef kAXTrustedCheckOptionPrompt __attribute__((weak_import));


BOOL MJAccessibilityIsEnabled(void) {
    // CRITICAL FIX: Use PHTVManager's test tap check
    // AXIsProcessTrusted() is unreliable and can return YES even when permission is broken
    return [PHTVManager canCreateEventTap];
}

void MJAccessibilityOpenPanel(void) {
    // Attempt to open System Settings directly to Privacy & Security -> Accessibility
    // This bypasses AXIsProcessTrusted() which might fail to prompt if it falsely thinks it's trusted
    NSURL *url = [NSURL URLWithString:@"x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"];
    if ([[NSWorkspace sharedWorkspace] openURL:url]) {
        return;
    }

    if (AXIsProcessTrustedWithOptions != NULL) {
        AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)@{(__bridge id)kAXTrustedCheckOptionPrompt: @YES});
    }
    else {
        static NSString* script = @"tell application \"System Preferences\"\nactivate\nset current pane to pane \"com.apple.preference.universalaccess\"\nend tell";
        [[[NSAppleScript alloc] initWithSource:script] executeAndReturnError:nil];
    }
}
