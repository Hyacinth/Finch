//
//  Share.m
//  Sharit
//
//  Created by Eugene Dorfman on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Share.h"
#import "MacroPreprocessor.h"

@implementation Share

- (NSString*) detailsDescription {
    return nil;
}

- (id) init {
    if ((self = [super init])) {
        [self loadSharedState];
        _isUpdated = NO;
    }
    return self;
}

- (id) initWithMacroPreprocessor:(MacroPreprocessor *)macroPreprocessor {
    if ((self = [self init])) {
        _macroPreprocessor = macroPreprocessor;
    }
    return self;
}

- (BOOL)isDetailsDescriptionAWarning {
    return NO;
}

- (NSMutableDictionary*)macrosDict {
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:@{
                                  @"is_shared":@(self.isShared),
                                  NSStringFromClass([self class]):@(YES)
                                }];
    [dict addEntriesFromDictionary:[self specificMacrosDict]];
    return dict;
}

- (void) processRequestData:(NSDictionary *)dict {
    
}

- (NSDictionary*)specificMacrosDict {
    return nil;
}

- (void) setIsShared:(BOOL)isShared {
    _isShared = isShared;
    [self saveSharedState];
}

- (void) saveSharedState {
    NSString* keyName = [self isSharedKey];
    [[NSUserDefaults standardUserDefaults] setBool:_isShared forKey:keyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) loadSharedState {
    NSNumber* isSharedObj = [[NSUserDefaults standardUserDefaults] objectForKey:[self isSharedKey]];
    if (nil==isSharedObj) {
        [self setIsShared:YES];
    } else {
        _isShared = [isSharedObj boolValue];
    }
}

- (NSString*) isSharedKey {
    return [NSString stringWithFormat:@"%@_isShared",NSStringFromClass([self class])];
}

- (UIImage*)thumbnail {
    return self.isShared ? [self thumbnailShared] : [self thumbnailNotShared];
}

- (UIImage*)thumbnailShared {
    return nil;
}

- (UIImage*)thumbnailNotShared {
    return nil;
}
@end