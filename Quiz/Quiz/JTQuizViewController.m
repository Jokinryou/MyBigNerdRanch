//
//  JTQuizViewController.m
//  Quiz
//
//  Created by 徐金良 on 14-3-13.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

#import "JTQuizViewController.h"

@interface JTQuizViewController ()

@property (nonatomic) int currentQuestionIndex;
@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@end

@implementation JTQuizViewController

- (IBAction)showQuestion:(id)sender {

}

- (IBAction)showAnswer:(id)sender {

}

@end
