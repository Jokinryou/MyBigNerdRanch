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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    // Call the init method implemented by the superclass
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Create two arrays filled with questions and answers
        // and make the pointers point to them

        self.questions = @[@"From what is cognac made?", @"What is 1+1?", @"What is the capital of Vermont?"];

        self.answers = @[@"Grapes", @"2", @"Montpelier"];
    }

    // Return the address of the new object
    return self;
}

- (IBAction)showQuestion:(id)sender {

    // Step to the next question
    self.currentQuestionIndex++;

    // Am I past the last question?
    if (self.currentQuestionIndex == [self.questions count]) {

        // Go back to the first question
        self.currentQuestionIndex = 0;
    }

    //  Get the string at that index in the questions array
    NSString *question = self.questions[self.currentQuestionIndex];

    // Diskplay the string in the question label
    self.questionLabel.text = question;

    // Reset the answer lable
    self.answerLabel.text = @"???";

}

- (IBAction)showAnswer:(id)sender {

    // What is the answer to the current question?
    NSString *answer = self.answers[self.currentQuestionIndex];

    // Display it in the answer label
    self.answerLabel.text = answer;

}

@end
