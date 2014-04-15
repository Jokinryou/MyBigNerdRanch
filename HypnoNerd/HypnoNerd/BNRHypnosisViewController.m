//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Jokinryou Tsui on 4/15/14.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisterView.h"

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {

        // Set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";

        // Create a UIImage from a file
        // This will use Hypno@2x.png on retina display devices
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];

        // put that image on the tab bar item
        self.tabBarItem.image = i;
    }

    return self;
}

- (void)loadView {

    // Create a view
    BNRHypnosisterView *backgroundView = [[BNRHypnosisterView alloc] init];

    // set it as *the* view of this view controller
    self.view = backgroundView;
}

@end
