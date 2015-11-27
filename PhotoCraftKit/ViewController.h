//
//  ViewController.h
//  PhotoCraftKit
//
//  Created by beihaiSellshou on 11/18/15.
//  Copyright © 2015 JXHDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    CGFloat _red;
    CGFloat _green;
    CGFloat _blue;
    CGFloat _opacity;
    BOOL _swiped;
    CGPoint _lastpoint;
    CGFloat _brushWidth;
    BOOL _isDrawingZone;
    BOOL _isPatternZone;
    BOOL _isPhotoZone;
}

@property(assign, nonatomic)int pathType;
@property(assign, nonatomic)int sizePickerIndex;
@property(assign, nonatomic)int fillOrStrokePickerIndex;
@property(assign, nonatomic)CGSize size;
@property(assign, nonatomic)CGFloat distance;
@property(assign, nonatomic)CGFloat lineWidth;
@end

