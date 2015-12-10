//
//  ViewController.m
//  PhotoCraftKit
//
//  Created by beihaiSellshou on 11/18/15.
//  Copyright © 2015 JXHDev. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"
#import "UIBezierPathPool.h"

@interface ViewController ()<SettingViewControllerDelegate,UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, assign)BOOL navigationBarIsOpen;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationLeading;
@property (weak, nonatomic) IBOutlet UIImageView *RealImageView;
@property (weak, nonatomic) IBOutlet UIImageView *TempImageView;
//photo editting pane
@property (weak, nonatomic)UIImageView *backupImgView;
@property (weak, nonatomic)UIImageView *edittingImgView;
@property(assign, nonatomic)CGFloat effectIntensity;

//end
//photo distort pane
@property (weak, nonatomic) IBOutlet UIView *photoDistortPaneToolbar;

//end


- (IBAction)enterDrawingContext;
- (IBAction)enterPhotoEdit;
- (IBAction)enterPatternZone;
- (IBAction)enterClipZone;

//drawing panel
- (IBAction)colorBtnPressed:(UIButton *)sender;
@property(strong, nonatomic)NSMutableArray *colors;
@property (weak, nonatomic) IBOutlet UIScrollView *drawingPaneToolBar;

//end
//photoClipToolbar
@property (weak, nonatomic) IBOutlet UIView *photoClipToolbar;


//end
//right navigation pane right constraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightNavigationConstraint;
@property(nonatomic, assign)BOOL rightNavigationPaneIsOpen;
@property (weak, nonatomic) IBOutlet UIView *rightNavigationPane;

//end

@property(weak, nonatomic)UIView *coverView;
@end

@implementation ViewController

- (IBAction)navigationPressed {
    if (self.navigationBarIsOpen == NO) {
        _isDrawingZone = NO;
        _isPatternZone = NO;
        [self.navigationView setNeedsLayout];
        [self.contentView setNeedsLayout];
        self.navigationLeading.constant = 0;
        self.contentView.userInteractionEnabled = NO;
        self.navigationView.userInteractionEnabled = NO;
        [UIView animateWithDuration:1.8f animations:^{
            [self.navigationView layoutIfNeeded];
            [self.contentView layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.contentView.userInteractionEnabled = YES;
            self.navigationView.userInteractionEnabled = YES;
        }];

    }else{
        
        [self.navigationView setNeedsLayout];
        [self.contentView setNeedsLayout];
        self.navigationLeading.constant = -90.0;
        self.contentView.userInteractionEnabled = NO;
        self.navigationView.userInteractionEnabled = NO;
        [UIView animateWithDuration:1.8f animations:^{
            [self.navigationView layoutIfNeeded];
            [self.contentView layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.contentView.userInteractionEnabled = YES;
            self.navigationView.userInteractionEnabled = YES;
        }];

    }
    self.navigationBarIsOpen = !self.navigationBarIsOpen;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationBarIsOpen = NO;
    _opacity = 1.0;
    _brushWidth = 5.0;
    _isDrawingZone = false;
    self.drawingPaneToolBar.hidden = YES;
    self.photoDistortPaneToolbar.hidden = YES;
    _red = 0.0;
    _blue = 0.0;
    _green = 0.0;
    //set up pattern panel
    self.pathType = 100;
    self.sizePickerIndex = 0;
    self.fillOrStrokePickerIndex = 0;
    self.size = CGSizeMake(20, 20);
    self.distance = 30;
    self.lineWidth = 3;
    _isPatternZone = false;
    //set up 1st photo pane
    self.effectIntensity = 0.5f;
    self.color4Mono = CGRectMake(0.0, 0.0, 1.0, 0.9);
    _isPhotoZone = true;
    
    //set up 2nd pane
    _isPhotoDistortZone = false;
    _isReflectionPhoto = false;
    //end
    
    //set up 3rd zone
    _isClipZone = false;
    self.photoClipToolbar.hidden = YES;
    //end
    //set up right navigation pane
    self.rightNavigationPaneIsOpen = NO;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Pick a photo"
                                                    message:@"Please select a photo for editting"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil   ];
    alert.delegate = self;
    [alert show];
    
}
#pragma alertView delegates
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
        
        
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 2.添加图片到相册中
    UIImageView *realImgView = [[UIImageView alloc]initWithFrame:[self imageAdjust4Screen:image]];
    realImgView.contentMode = UIViewContentModeScaleAspectFill;
    realImgView.image = image;
    if (self.edittingImgView) {
        [self.edittingImgView removeFromSuperview];
        [self.backupImgView removeFromSuperview];
    }
    
    [self.RealImageView addSubview:realImgView];
    self.backupImgView = realImgView;
    self.backupImgView.hidden = YES;
    
    UIImageView *tempImgView = [[UIImageView alloc]initWithFrame:[self imageAdjust4Screen:image]];
    tempImgView.contentMode = UIViewContentModeScaleAspectFill;
    tempImgView.image = image;
    [self.TempImageView addSubview:tempImgView];
    self.edittingImgView = tempImgView;


}

-(CGRect)imageAdjust4Screen:(UIImage *)img{
    CGSize tempSize;
    CGSize imgSize = img.size;
    CGSize screenSize = self.RealImageView.bounds.size;
    CGFloat xFactor = imgSize.width/screenSize.width;
    CGFloat yFactor = imgSize.height/screenSize.height;
    if (xFactor>yFactor) {
        tempSize = CGSizeMake(imgSize.width/xFactor, imgSize.height/xFactor);
    }else{
        tempSize = CGSizeMake(imgSize.width/yFactor, imgSize.height/yFactor);
    }
    CGFloat xOffset = (screenSize.width - tempSize.width)/2;
    CGFloat yOffset = (screenSize.height - tempSize.height)/2;
    return CGRectMake(xOffset, yOffset, tempSize.width, tempSize.height);
}
#pragma endAlertView Delegate
//fist panel zone
- (IBAction)pickPhoto {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}


- (IBAction)photoEffectBtnClick:(UIButton *)sender {
    
    if (sender.tag == 300) {
        CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"];
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        [sepia setValue:ref forKey:kCIInputImageKey];
        [sepia setValue:@(self.effectIntensity) forKey:kCIInputIntensityKey];
        
        CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
        
        CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
        [lighten setValue:random.outputImage forKey:kCIInputImageKey];
        [lighten setValue:@(1 - self.effectIntensity)  forKey:@"inputBrightness"];
        [lighten setValue:@0.0f forKey:@"inputSaturation"];
        CIImage *croppedImage = [[lighten outputImage] imageByCroppingToRect:ref.extent];
        
        CIFilter *composite = [CIFilter filterWithName:@"CIHardLightBlendMode"];
        [composite setValue:sepia.outputImage forKey:kCIInputImageKey];
        [composite setValue:croppedImage forKey:kCIInputBackgroundImageKey];

        CIImage *result = [composite outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];

        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }else if(sender.tag == 301){
        CIFilter *filter = [CIFilter filterWithName:@"CIFalseColor"];
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        [filter setValue:ref forKey:kCIInputImageKey];
        [filter setValue:[CIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forKey:@"inputColor1"];
        [filter setValue:[CIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] forKey:@"inputColor0"];
        
        CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
        
        CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
        [lighten setValue:random.outputImage forKey:kCIInputImageKey];
        [lighten setValue:@(self.effectIntensity) forKey:@"inputBrightness"];
        [lighten setValue:@0.0f forKey:@"inputSaturation"];
        CIImage *croppedImage = [[lighten outputImage] imageByCroppingToRect:ref.extent];
        
        CIFilter *composite = [CIFilter filterWithName:@"CIHardLightBlendMode"];
        [composite setValue:filter.outputImage forKey:kCIInputImageKey];
        [composite setValue:croppedImage forKey:kCIInputBackgroundImageKey];
//        加阴影
//        CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
//        [vignette setValue:composite.outputImage forKey:kCIInputImageKey];
//        [vignette setValue:@(self.effectIntensity*2) forKey:@"inputIntensity"];
//        [vignette setValue:@40.0f forKey:@"inputRadius"];
        
        CIImage *result = [composite outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }else if(sender.tag == 302){
        CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        
        [filter setValue:ref forKey:kCIInputImageKey];
        [filter setValue:@(self.effectIntensity) forKey:@"inputIntensity"];
        CIColor *color = [CIColor colorWithRed:self.color4Mono.origin.x green:self.color4Mono.origin.y blue:self.color4Mono.size.width alpha:self.color4Mono.size.height];
        [filter setValue:color forKey:@"inputColor"];
        
        CIImage *result = [filter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }else if(sender.tag == 303){
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        
        [filter setValue:ref forKey:kCIInputImageKey];
        
        
        CIImage *result = [filter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }else if(sender.tag == 304){
        CIFilter *filter = [CIFilter filterWithName:@"CISRGBToneCurveToLinear"];
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        
        [filter setValue:ref forKey:kCIInputImageKey];
        
        
        CIImage *result = [filter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }
    else if(sender.tag == 305){
        CIFilter *filter = [CIFilter filterWithName:@"CIExposureAdjust"];
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        
        [filter setValue:ref forKey:kCIInputImageKey];
        [filter setValue:@(self.effectIntensity) forKey:kCIInputEVKey];
        
        CIImage *result = [filter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }else if(sender.tag == 306){
        CIFilter *filter = [CIFilter filterWithName:@"CIVibrance"];
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        
        
        CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
        
        CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
        [lighten setValue:random.outputImage forKey:kCIInputImageKey];
        [lighten setValue:@(1 - self.effectIntensity)  forKey:@"inputBrightness"];
        [lighten setValue:@0.0f forKey:@"inputSaturation"];
        CIImage *croppedImage = [[lighten outputImage] imageByCroppingToRect:ref.extent];
        
        CIFilter *composite = [CIFilter filterWithName:@"CIHardLightBlendMode"];
        [composite setValue:ref forKey:kCIInputImageKey];
        [composite setValue:croppedImage forKey:kCIInputBackgroundImageKey];
        
        [filter setValue:composite.outputImage forKey:kCIInputImageKey];
        [filter setValue:@(self.effectIntensity) forKey:@"inputAmount"];
       
        
        CIImage *result = [filter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }
}
//end
//2nd pane

- (IBAction)photoDistortPressed:(UIButton *)sender {
    if (self.backupImgView.image == nil) {
        return;
    }
    if (sender.tag == 500) {
        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        [filter setValue:ref forKey:kCIInputImageKey];
        [filter setValue:@(self.effectIntensity*15) forKey:kCIInputRadiusKey];
        
        CIImage *result = [filter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }else if(sender.tag == 501){
        CIFilter *filter = [CIFilter filterWithName:@"CIZoomBlur"];
        
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        [filter setValue:ref forKey:kCIInputImageKey];
        CIVector *centerVector = [CIVector vectorWithX:0 Y:0];
        [filter setValue:centerVector forKey:kCIInputCenterKey];
        [filter setValue:@(self.effectIntensity*5) forKey:@"inputAmount"];
        
        CIImage *result = [filter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }else if(sender.tag == 502){
        CIImage *ciImage = [[CIImage alloc] initWithImage:self.backupImgView.image];
        NSDictionary *params = @{
                                 kCIInputImageKey: ciImage,
                                 };
        CIFilter *filter = [CIFilter filterWithName:@"CIGlassDistortion"
                                withInputParameters:params];
        [filter setDefaults];
        
        // 输入变形参数
        if ([filter respondsToSelector:NSSelectorFromString(@"inputTexture")]) {
            CIImage *ciTextureImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"texture.png"]];
            [filter setValue:ciTextureImage forKey:@"inputTexture"];
        }

        CIImage *result = [filter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        // 释放资源
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage;
    }else if(sender.tag == 503){
        CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
        
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        [filter setValue:ref forKey:kCIInputImageKey];
//        CIVector *centerVector = [CIVector vectorWithX:150 Y:150];
//        
//        [filter setValue:centerVector forKey:kCIInputCenterKey];
//        
//        [filter setValue:@(0.00) forKey:kCIInputAngleKey];
//        [filter setValue:@(50) forKey:kCIInputWidthKey];
        
        CIImage *result = [filter outputImage];
        
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        
        CGImageRef cgimg = [context createCGImage:result fromRect:result.extent];
        
        UIImageOrientation origentation = self.backupImgView.image.imageOrientation;
        UIImage *newImage1 = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:origentation];
        
        CGImageRelease(cgimg);
        self.edittingImgView.image = newImage1;

    }else if (sender.tag == 504){
        _isReflectionPhoto = true;
        CGSize originSize = self.edittingImgView.bounds.size;
        CGSize frameSize = CGSizeMake(originSize.width, originSize.height * 2);
        UIGraphicsBeginImageContext(frameSize);
        [self.backupImgView.image drawInRect:CGRectMake(0, 0, originSize.width, originSize.height)];
        UIImage *bottomImg = [self getReflectionImg:originSize inputImg:self.backupImgView.image];
        [bottomImg drawInRect:CGRectMake(0, originSize.height, originSize.width, originSize.height)];
        UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        self.edittingImgView.image = output;
    }
}
-(UIImage *)getReflectionImg:(CGSize) originSize inputImg:(UIImage *)origin{
    
    UIGraphicsBeginImageContext(originSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient;
    //	2. 采用彩色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //	3. 定义渐变颜色组件
    //	  每四个数一组，分别对应r,g,b,透明度
    CGFloat components[8] = {1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.8};
    CGFloat locations[2] = {1,0};
    
    //	5. 创建颜色渐进，3表示有三个点
    gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    // 6. 控制渐变方向是水平线或者垂直线，3表示超过250后继续填上最后那个颜色，2不填颜色留白, 1表示超过0还填色而0表示两边都不填
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, originSize.height), 3);
    UIImage *mask = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    //开始将图片转灰度
    CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceGray();
    int width1 = mask.size.width;
    int height1 = mask.size.height;
    CGContextRef context1 = CGBitmapContextCreate(NULL, width1, height1, 8, width1, colorSpace1, (CGBitmapInfo)kCGImageAlphaNone);
    
    CGContextDrawImage(context1, CGRectMake(0, 0, width1, height1), mask.CGImage);
    CGImageRef imageRef = CGBitmapContextCreateImage(context1);
    CGContextRelease(context1);
    CGColorSpaceRelease(colorSpace1);
    // 传出灰度图片，结束灰度加工
    UIImage *output = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    UIGraphicsBeginImageContext(originSize);
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context2, CGRectMake(0, 0, originSize.width, originSize.height), output.CGImage);
    CGContextSaveGState(context2);
    CGContextTranslateCTM(context2, originSize.width/2, originSize.height/2);
    CGContextScaleCTM(context2, 1.0, -1.0);
    CGContextTranslateCTM(context2, -originSize.width/2, -originSize.height/2);
    [origin drawInRect:CGRectMake(0, 0, originSize.width, originSize.height)];
    CGContextRestoreGState(context2);
    UIImage *mask1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return mask1;
}

//end
//3rd zone
- (IBAction)getClipImg:(UIButton *)sender {
    CGSize imgSize = self.backupImgView.frame.size;
    CGFloat minLength = imgSize.width > imgSize.height ? imgSize.height:imgSize.width;
    CGRect drawRect = CGRectMake(0, 0, imgSize.width, imgSize.height);
    if (self.backupImgView.image == nil) {
        return;
    }
    if (sender.tag == 600) {
        UIGraphicsBeginImageContext(imgSize);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:drawRect cornerRadius:minLength*self.effectIntensity/2];
        [path addClip];
        [self.backupImgView.image drawInRect:drawRect];
        UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.edittingImgView.image = tempImg;
        
    }else if(sender.tag == 601){
        CGRect realDrawRect = CGRectMake(imgSize.width/2 - minLength/2, imgSize.height/2 - minLength/2, minLength, minLength);
        UIGraphicsBeginImageContext(imgSize);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:realDrawRect];
        UIBezierPath *inner = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(imgSize.width/2 - minLength*self.effectIntensity/2, imgSize.height/2 - minLength*self.effectIntensity/2, minLength*self.effectIntensity, minLength*self.effectIntensity)];
        [path appendPath:inner];
        path.usesEvenOddFillRule = YES;
        [path addClip];
        [self.backupImgView.image drawInRect:drawRect];
        UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.edittingImgView.image = tempImg;
    }
}


//end
//for 1st - 3rd zone
- (IBAction)refreshScreen {
    [self rightNavigationBtnPressed];
    if (_isPhotoZone == true||_isPhotoDistortZone == true) {
        CIImage *ref = [CIImage imageWithCGImage:self.backupImgView.image.CGImage];
        
        self.edittingImgView.image = [UIImage imageWithCIImage:ref];
    }
}

- (IBAction)saveEditingImage {
    [self rightNavigationBtnPressed];
    if (_isPhotoZone == true || _isPhotoDistortZone == true) {
        if(self.edittingImgView.image){
            self.backupImgView.image = self.edittingImgView.image;
            UIImageWriteToSavedPhotosAlbum(self.edittingImgView.image,nil,nil,nil);
        }
        if (_isReflectionPhoto == true) {
            // 2.添加图片到相册中
            UIImageView *realImgView = [[UIImageView alloc]initWithFrame:[self imageAdjust4Screen:self.edittingImgView.image]];
            realImgView.contentMode = UIViewContentModeScaleAspectFill;
            realImgView.image = self.edittingImgView.image;
            if (self.edittingImgView) {
                [self.edittingImgView removeFromSuperview];
                [self.backupImgView removeFromSuperview];
            }
            
            [self.RealImageView addSubview:realImgView];
            self.backupImgView = realImgView;
            self.backupImgView.hidden = YES;
            
            UIImageView *tempImgView = [[UIImageView alloc]initWithFrame:[self imageAdjust4Screen:realImgView.image]];
            tempImgView.contentMode = UIViewContentModeScaleAspectFill;
            tempImgView.image = realImgView.image;
            [self.TempImageView addSubview:tempImgView];
            self.edittingImgView = tempImgView;
            _isReflectionPhoto = false;
        }
        
    }
}
- (IBAction)shareProduct {
    [self rightNavigationBtnPressed];
    UIImage *myImage = self.edittingImgView.image;
    
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[myImage]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *presentationController = [controller popoverPresentationController];
    
    presentationController.sourceView = self.view;
}

//end
-(void)setSizePickerIndex:(int)sizePickerIndex{
    _sizePickerIndex = sizePickerIndex;
    if (sizePickerIndex == 0) {
        self.size = CGSizeMake(20, 20);
    }else if(sizePickerIndex == 1){
        self.size = CGSizeMake(40, 40);
    }else{
        self.size = CGSizeMake(60, 60);
    }
}

-(void)closeAllContextToolBars{
    self.photoDistortPaneToolbar.hidden = YES;
    self.drawingPaneToolBar.hidden = YES;
    self.photoClipToolbar.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterDrawingContext {
    [self closeAllContextToolBars];
    [self navigationPressed];
    [self initAllZoneTag];
    _isDrawingZone = true;
    self.drawingPaneToolBar.hidden = NO;
}

- (IBAction)enterPhotoEdit {
    [self closeAllContextToolBars];
    [self navigationPressed];
    [self initAllZoneTag];
    _isPhotoZone = true;
}

- (IBAction)enterPatternZone {
    [self closeAllContextToolBars];
    [self navigationPressed];
    [self initAllZoneTag];
    _isPatternZone = true;
    self.drawingPaneToolBar.hidden = NO;
}


- (IBAction)photoDistortBtnPressed {
    [self closeAllContextToolBars];
    [self navigationPressed];
    [self initAllZoneTag];
    _isPhotoDistortZone = true;
    self.photoDistortPaneToolbar.hidden = NO;
    if(self.edittingImgView.image){
        self.edittingImgView.image = self.backupImgView.image;
        
    }
    
}
- (IBAction)enterClipZone {
    [self closeAllContextToolBars];
    [self navigationPressed];
    [self initAllZoneTag];
    _isClipZone = true;
    self.photoClipToolbar.hidden = NO;
    if(self.edittingImgView.image){
        self.edittingImgView.image = self.backupImgView.image;
        
    }
}
-(void)initAllZoneTag{
    _isPatternZone = false;
    _isDrawingZone = false;
    _isPhotoZone = false;
    _isPhotoDistortZone = false;
    _isClipZone = false;
}
// for drawing panel
-(NSMutableArray *)colors{
    if (_colors == nil) {
        NSMutableArray *tempColors = [[NSMutableArray alloc]init];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(0, 0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(1.0, 0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(0, 0, 1.0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(51.0 / 255.0, 204.0 / 255.0, 1.0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(102.0 / 255.0, 204.0 / 255.0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(102.0 / 255.0, 1.0, 0,1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(1.0, 102.0 / 255.0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(1.0, 1.0, 0, 1)]];
        [tempColors addObject:[NSValue valueWithCGRect:CGRectMake(1.0, 1.0, 1.0, 1)]];
        _colors = tempColors;
        return _colors;
    }
    return _colors;
}
- (IBAction)colorBtnPressed:(UIButton *)sender {
    // 1
    int index = (int)sender.tag;
    
    // 2
    CGRect tempRect = [self.colors[index] CGRectValue];
    _red = tempRect.origin.x;
    _green = tempRect.origin.y;
    _blue = tempRect.size.width;
    
    
    // 3
    if (index == self.colors.count - 1) {
        _opacity = 1.0;
    }
    
}
// MARK: - Actions
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_isDrawingZone == true) {
        _swiped = false;
        UITouch *touch=[[event allTouches]anyObject];
        if (touch) {
            CGPoint tempLast = [touch locationInView:self.TempImageView];
            _lastpoint = tempLast;
            
        }
    }else if(_isPatternZone){
        _swiped = false;
        UITouch *touch=[[event allTouches]anyObject];
        if (touch) {
            CGPoint tempLast = [touch locationInView:self.TempImageView];
            _lastpoint = tempLast;
            
        }
    }
    

}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isDrawingZone == true) {
        _swiped = true;
        UITouch *touch=[[event allTouches]anyObject];
        if (touch) {
            CGPoint tempLast = [touch locationInView:self.TempImageView];
            
            
            [self drawLineFrom:_lastpoint toPoint: tempLast];
            _lastpoint = tempLast;
        }
    }else if(_isPatternZone){
        _swiped = true;
        UITouch *touch=[[event allTouches]anyObject];
        if (touch) {
            CGPoint currentPoint = [touch locationInView:self.TempImageView];
            CGFloat deltaX = currentPoint.x - _lastpoint.x;
            CGFloat deltaY = currentPoint.y - _lastpoint.y;
            
            CGFloat powX = pow(deltaX,2);
            CGFloat powY = pow(deltaY,2);
            
            CGFloat distance = sqrt(powX + powY);
            if (distance >= self.distance){
                [self drawPatternFromPoint:_lastpoint toPoint:currentPoint];
                _lastpoint = currentPoint;
            }
        }
    }
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isDrawingZone == true) {
        if (_swiped ==false) {
            // draw a single point
            [self drawLineFrom:_lastpoint toPoint:_lastpoint];
        }
    }else if(_isPatternZone){
        if (_swiped ==false) {
            // draw a single point
            [self drawPatternFromPoint:_lastpoint toPoint:_lastpoint];
        }
    }

    
    // Merge tempImageView into mainImageView
//    UIGraphicsBeginImageContext(mainImageView.frame.size)
//    mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: .Normal, alpha: 1.0)
//    tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: .Normal, alpha: opacity)
//    mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    
//    tempImageView.image = nil
}




-(void)drawPatternFromPoint:(CGPoint)lastPoint toPoint:(CGPoint)currentPoint{

    UIGraphicsBeginImageContext(self.TempImageView.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    [self.TempImageView.image drawInRect:self.TempImageView.bounds];
    
    UIBezierPath *path1;
    CGRect rect4Offset;
    if (self.pathType == 100) {
        path1  = [UIBezierPathPool getCirclePath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 101) {
        path1  = [UIBezierPathPool getTrianglePath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 102) {
        path1  = [UIBezierPathPool getSnowPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 103) {
        path1  = [UIBezierPathPool getGearPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 104) {
        path1  = [UIBezierPathPool getGiftPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 105) {
        path1  = [UIBezierPathPool getMaplePath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 106) {
        path1  = [UIBezierPathPool getHeartPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }
    else if (self.pathType == 107) {
        path1  = [UIBezierPathPool getStarPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }else if (self.pathType == 108) {
        path1  = [UIBezierPathPool getPawPath:self.sizePickerIndex];
        rect4Offset = path1.bounds;
    }
    
    CGFloat offsetX = currentPoint.x - rect4Offset.size.width/2;
    CGFloat offsetY = currentPoint.y - rect4Offset.size.height/2;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, offsetX, offsetY);
    
    [path1 applyTransform:transform];
    if (self.fillOrStrokePickerIndex == 0) {
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGContextSetRGBStrokeColor(context, _red, _green, _blue, _opacity);
        path1.lineWidth = _lineWidth;
        [path1 stroke];
    }else{
        CGContextSetBlendMode(context, kCGBlendModeHardLight);
        CGContextSetRGBFillColor(context, _red, _green, _blue, _opacity);
        [path1 fill];
        
    }

    //很重要因为在
    self.TempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)drawLineFrom:(CGPoint)lastPoint toPoint:(CGPoint)currentPoint{
    // 1
    UIGraphicsBeginImageContext(self.TempImageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.TempImageView.image drawInRect:self.TempImageView.bounds];
    
    // 2
    CGContextMoveToPoint(context, lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    
    // 3
    //不设置这个看到线条画出的效果是稀疏有横向有竖向的线段，效果非常难看
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, _brushWidth);
    CGContextSetRGBStrokeColor(context, _red, _green, _blue, 1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    // 4
    CGContextStrokePath(context);
    
    // 5
    self.TempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    self.TempImageView.alpha = _opacity;
    UIGraphicsEndImageContext();
}
//end
//delegate method
-(void)settingsViewControllerFinished:(SettingViewController *)SettingsViewController{
    
    _brushWidth= SettingsViewController.brushSlide.value;
     _opacity = SettingsViewController.alphaSlide.value;
     _red = SettingsViewController.redSlide.value;
    _green = SettingsViewController.greenSlide.value;
    _blue = SettingsViewController.blackSlide.value;
    
    self.pathType = SettingsViewController.pathType;
    self.sizePickerIndex = (int)SettingsViewController.sizePicker.selectedSegmentIndex;
    self.fillOrStrokePickerIndex = (int)SettingsViewController.fillOrStroke.selectedSegmentIndex;
    self.distance = SettingsViewController.distantPicker.value;
    self.lineWidth = SettingsViewController.strokeWidth.value;
    
    //1st pane
    self.effectIntensity = SettingsViewController.effectIntensitySlider.value;
    self.color4Mono = SettingsViewController.color4Mono;
    
}

//prepare jump to settingViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SettingViewController *destinationVC = (SettingViewController *)segue.destinationViewController;
    destinationVC.settingDelegate = self;
    destinationVC.brushWidth = _brushWidth;
    destinationVC.opacity = _opacity;
    destinationVC.red = _red;
    destinationVC.green = _green;
    destinationVC.blue = _blue;
    
    destinationVC.pathType = self.pathType;
    destinationVC.sizePickerIndex = self.sizePickerIndex;
    destinationVC.isFill = self.fillOrStrokePickerIndex;
    destinationVC.distance= self.distance;
    destinationVC.lineWidth = self.lineWidth;
    
    //for first pane
    destinationVC.effectIntensity = self.effectIntensity;
    destinationVC.color4Mono = self.color4Mono;
    
    destinationVC.isPatternZone = _isPatternZone;
    destinationVC.isPhotoZone = _isPhotoZone;
    destinationVC.isDrawingZone = _isDrawingZone;

    
}
- (IBAction)rightNavigationBtnPressed {
    
    if (self.rightNavigationPaneIsOpen == NO) {
        
        [self.rightNavigationPane setNeedsLayout];
        self.rightNavigationConstraint.constant = 0;
        self.contentView.userInteractionEnabled = NO;
        self.rightNavigationPane.userInteractionEnabled = NO;
        [UIView animateWithDuration:1.8f animations:^{
            [self.rightNavigationPane layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            self.contentView.userInteractionEnabled = YES;
            self.rightNavigationPane.userInteractionEnabled = YES;
        }];
        
    }else{
        
        [self.rightNavigationPane setNeedsLayout];
        self.rightNavigationConstraint.constant = -90.0;
        self.contentView.userInteractionEnabled = NO;
        self.rightNavigationPane.userInteractionEnabled = NO;
        [UIView animateWithDuration:1.8f animations:^{
            [self.rightNavigationPane layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            self.contentView.userInteractionEnabled = YES;
            self.rightNavigationPane.userInteractionEnabled = YES;
        }];
        
    }
    self.rightNavigationPaneIsOpen = !self.rightNavigationPaneIsOpen;
}
//right navigation panel

@end
