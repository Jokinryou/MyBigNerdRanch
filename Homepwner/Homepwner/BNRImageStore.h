//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Jokinryou Tsui on 4/27/14.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
