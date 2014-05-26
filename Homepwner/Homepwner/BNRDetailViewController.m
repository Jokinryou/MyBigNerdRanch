//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Jokinryou Tsui on 4/25/14.
//  Copyright (c) 2014 Jokinryou Tsui. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;

@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController

- (IBAction)backgroundTapped:(id)sender {

    [self.view endEditing:YES];

}

- (IBAction)takePicture:(id)sender {

    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];

    // If the device has a camera, take a picture, otherwise,
    // just pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    imagePickerController.delegate = self;

    // Place image picker on the screen
    [self presentViewController:imagePickerController animated:YES completion:nil];

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];

    // You need an NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {

        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }

    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];

    NSString *imagekey = self.item.itemKey;

    // Get the image for its image key from the image store
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imagekey];

    // Use that image to put on the screen in the imageView
    self.imageView.image = imageToDisplay;

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    // Clear first responder
    [self.view endEditing:YES];

    // "Save" changes to item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)viewDidLoad {

    [super viewDidLoad];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:nil];

    // The contentMode of the image view in the XIB was Aspect Fit:
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    // Do not produce a translated constraint for the view
    imageView.translatesAutoresizingMaskIntoConstraints = NO;

    // The image view was a subview of the view
    [self.view addSubview:imageView];

    self.imageView = imageView;

    // Set the vertical priorities to be less than
    // those of the other subviews
    [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    [self.imageView setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisVertical];

    NSDictionary *nameMap = @{@"imageView": self.imageView, @"dateLabel" : self.dateLabel, @"toolbar" : self.toolbar};

    // imageView is 0 pts from superview at left and right edges
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:nameMap];

    // imageView is 8 pts from dateLabel at its top edge...
    // ...and 8 pts from toolbar at its bottom edge
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-8-[imageView]-8-[toolbar]" options:0 metrics:nil views:nameMap];

    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
}

- (void)setItem:(BNRItem *)item {

    _item = item;
    self.navigationItem.title = _item.itemName;
}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    // Store the image in the BNRImageStore for this key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];

    // Put that image onto the screen in our image view
    self.imageView.image = image;

    // Take image picker off the screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;

}

@end
