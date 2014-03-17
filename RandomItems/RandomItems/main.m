//
//  main.m
//  RandomItems
//
//  Created by 徐金良 on 14-3-16.
//  Copyright (c) 2014年 Jokinryou Tsui. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        NSMutableArray *items = [[NSMutableArray alloc] init];

        [items addObject:@"One"];
        [items addObject:@"Two"];
        [items addObject:@"Three"];

        [items insertObject:@"Zero" atIndex:0];

        for (NSString *item in items) {
            NSLog(@"%@", item);
        }

        items = nil;

    }
    return 0;
}

