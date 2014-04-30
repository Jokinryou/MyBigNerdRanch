//
// Created by Jokinryou Tsui on 4/29/14.
// Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView {

    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end