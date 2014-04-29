//
//  BNRItem.h
//  RandomItems
//
//  Created by 徐金良 on 14-3-18.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//



@interface BNRItem : NSObject
//{
//
//    NSString *_itemName;
//    NSString *_serialNumber;
//    int _valueInDollars;
//    NSDate *_dateCreated;
//
//    BNRItem *_containedItem;
//    __weak BNRItem *_container;
//}

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;

+ (instancetype)randomItem;

// Designated initializer for BNRItem
- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;

//- (void)setContainedItem:(BNRItem *)item;
//- (NSString *)containedItem;
//
//- (void)setContainer:(BNRItem *)item;
//- (NSString *)container;
//
//- (void)setItemName:(NSString *)str;
//- (NSString *)itemName;
//
//- (void)setSerialNumber:(NSString *)str;
//- (NSString *)serialNumber;
//
//- (void)setValueInDollars:(int)v;
//- (int)valueInDollars;
//
//- (NSData *)dateCreated;

@end
