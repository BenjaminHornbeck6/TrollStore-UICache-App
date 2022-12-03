//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <Foundation/Foundation.h>

extern int spawnRoot(NSString* path, NSArray* args);

@class BSMonotonicReferenceTime, NSArray, NSNumber, NSString, NSURL, SBSApplicationShortcutService, SBSApplicationShortcutServiceFetchResult;
@interface SBFApplication : NSObject {
    NSURL * _bundleURL;
}

@property (nonatomic, readonly) NSURL *bundleURL;
- (void)cxx_destruct;
- (id)bundleURL;
- (id)init;
- (id)initWithApplicationBundleIdentifier:(id)arg1;
@end
