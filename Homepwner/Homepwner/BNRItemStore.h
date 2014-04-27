//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Jokinryou Tsui on 4/19/14.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRItem *)createItem;

- (void)removeItem:(BNRItem *)item;

- (void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end
