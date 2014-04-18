//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by Jokinryou Tsui on 4/15/14.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    NSLog(@"BNRReminderViewController loaded its view");
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {

        // Get the tab bar item
        UITabBarItem *tbi = self.tabBarItem;

        // Give it a label
        tbi.title = @"Reminder";

        // Give it an image
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        tbi.image = i;
    }

    return self;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (IBAction)addReminder:(id)sender {

    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);

    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Hypnotize me!";
    notification.fireDate = date;

    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
