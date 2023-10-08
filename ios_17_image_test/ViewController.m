//
//  ViewController.m
//  ios_17_image_test
//
//  Created by 李扬 on 2023/10/8.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *normalImageView;

@property (weak, nonatomic) IBOutlet UIImageView *abnormalImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // process image
    NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test_image" ofType:@"png"]];
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef scale:1 orientation:UIImageOrientationUp];
    
    // load image directly
    [self.normalImageView setImage:image];
    
    
    
    // use UIGraphicsImageRenderer to decode
    UIGraphicsImageRendererFormat *format = [UIGraphicsImageRendererFormat preferredFormat];
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:image.size format:format];

    UIImage * resultImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        [image drawInRect:rect];
    }];
    
    // image decode issue occurred. only on iOS 17
    [self.abnormalImageView setImage:resultImage];
}


@end
