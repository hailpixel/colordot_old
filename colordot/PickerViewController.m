//
//  UIColorPickerViewController.m
//  colordot
//
//  Created by Devin Hunt on 6/28/13.
//  Copyright (c) 2013 Devin Hunt. All rights reserved.
//

#import "PickerViewController.h"

@implementation PickerViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.pickerMode = UIColorPickerTypeCamera;
        
        _lastHue = 0.5f;
        _lastSaturation = 0.5f;
        _lastBrightness = 0.5f;
    }
    return self;
}

- (void)loadView {
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    CGRect pickerFrame = CGRectMake(0.0f, 0.0f, appFrame.size.width, appFrame.size.width);
    
    self.mainView = [[SlidingView alloc] initWithFrame:pickerFrame];
    self.mainView.autoresizesSubviews = YES;
    self.view = self.mainView;
    
    self.pickerView = [[ColorPickerView alloc] initWithFrame:pickerFrame];
    self.pickerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.mainView.centerView = self.pickerView;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPan:)];
    panRecognizer.delegate = self;
    panRecognizer.maximumNumberOfTouches = 1;
    panRecognizer.minimumNumberOfTouches = 1;
    [self.pickerView addGestureRecognizer:panRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(respondToPinch:)];
    [self.pickerView addGestureRecognizer:pinchRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.delegate = self;
    [self.pickerView addGestureRecognizer:tapRecognizer];
    
    self.cameraView = [[CameraPickerView alloc] initWithFrame:pickerFrame];
    self.cameraView.backgroundColor = [UIColor redColor];
    self.mainView.rightView = self.cameraView;
    
    self.cameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cameraButton.frame = CGRectMake(self.pickerView.bounds.size.width - 46.0f, (self.pickerView.bounds.size.width / 2.0f) - 15.0f, 30.0f, 30.0f);
    self.cameraButton.titleLabel.text = @"C";
    [self.cameraButton addTarget:self action:@selector(onCameraButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerView addSubview:self.cameraButton];
    
    self.fingerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.fingerButton.frame = CGRectMake(16.0f, (self.cameraView.bounds.size.width / 2.0f) - 15.0f, 30.0f, 30.0f);
    self.fingerButton.titleLabel.text = @"F";
    [self.fingerButton addTarget:self action:@selector(onFingerButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.cameraView addSubview:self.fingerButton];
    
    [self initCamera];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lastPickedColor = [UIColor colorWithHue:_lastHue saturation:_lastSaturation brightness:_lastBrightness alpha:1.0f];
    [self.pickerView setColor:lastPickedColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Interaction for Finger Mode color picker

- (void)respondToPan:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
    CGRect bounds = self.view.bounds;
    
    _lastHue = location.x / bounds.size.width;
    _lastBrightness = location.y / bounds.size.height;
    
    lastPickedColor = [UIColor colorWithHue:_lastHue saturation:_lastSaturation brightness:_lastBrightness alpha:1.0f];
    [self.pickerView setColor:lastPickedColor];
}

- (void)respondToTap:(UITapGestureRecognizer *) sender {
    [delegate colorPicked:lastPickedColor];
}

- (void)respondToPinch:(UIPinchGestureRecognizer *)sender {
    _lastSaturation = MIN(1.0f, MAX(0.0f, (log10f([sender scale]) + 0.7f * 0.8f)));
    
    lastPickedColor = [UIColor colorWithHue:_lastHue saturation:_lastSaturation brightness:_lastBrightness alpha:1.0f];
    [self.pickerView setColor:lastPickedColor];
}

#pragma mark Tapping between views
- (void)onCameraButtonTap {
    self.mainView.state = SlidingViewRightOpen;
    [cameraSession startRunning];
}

- (void)onFingerButtonTap {
    self.mainView.state = SlidingViewDefault;
    [cameraSession stopRunning];
}

#pragma mark Gesture delegate methods
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.pickerView];
    
    if(CGRectContainsPoint(self.cameraButton.frame, point)) {
        return NO;
    }
    return YES;
}

#pragma mark Camera methods
- (void)initCamera {
    cameraSession = [[AVCaptureSession alloc] init];
    cameraSession.sessionPreset = AVCaptureSessionPresetHigh;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if(! input) {
        NSLog(@"Problem with grabbing input device");
        return;
    }
    [cameraSession addInput:input];
    
    previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:cameraSession];
    self.cameraView.previewLayer = previewLayer;
    
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    output.alwaysDiscardsLateVideoFrames = YES;
    output.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    [output setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [cameraSession addOutput:output];
}

#pragma mark AVCapture delegate methods
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    int bufferWidth = CVPixelBufferGetWidth(pixelBuffer);
    int bufferHeight = CVPixelBufferGetHeight(pixelBuffer);
    
    int videoPointX = round((self.view.bounds.size.width / 2) * (CGFloat)bufferHeight / self.view.bounds.size.width);
    int videoPointY = round((self.view.bounds.size.height / 2) * (CGFloat)bufferWidth / self.view.bounds.size.height);
    
    unsigned char *rowBase = (unsigned char *)CVPixelBufferGetBaseAddress(pixelBuffer);
    int bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer);
    unsigned char *pixel = NULL;
    int avgRed = 0, avgGreen = 0, avgBlue = 0, x, y;
    
    for(y = videoPointY - 5; y < videoPointY + 5; y ++) {
        for(x = videoPointX - 5; x < videoPointX + 5; x ++) {
            pixel = rowBase + (x * bytesPerRow) + (y * 4);
            avgBlue += pixel[0];
            avgGreen += pixel[1];
            avgRed += pixel[2];
        }
    }
    
    avgBlue /= 100;
    avgGreen /= 100;
    avgRed /= 100;
    
    UIColor *sampledColor = [UIColor colorWithRed:avgRed / 255.0f green:avgGreen / 255.0f blue:avgBlue / 255.0f alpha:1.0f];
    self.cameraView.backgroundColor = sampledColor;
}

@end
