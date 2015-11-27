//
//  UIBezierPathPool.m
//  PhotoCraftKit
//
//  Created by beihaiSellshou on 11/26/15.
//  Copyright © 2015 JXHDev. All rights reserved.
//

#import "UIBezierPathPool.h"

@implementation UIBezierPathPool

+(UIBezierPath *)getTrianglePath:(int)sizePickerIndex{
    if (sizePickerIndex == 0) {
        UIGraphicsBeginImageContext(CGSizeMake(20, 20));
        UIBezierPath* polygonPath = UIBezierPath.bezierPath;
        [polygonPath moveToPoint: CGPointMake(10, 0)];
        [polygonPath addLineToPoint: CGPointMake(18.66, 15)];
        [polygonPath addLineToPoint: CGPointMake(1.34, 15)];
        [polygonPath closePath];
        UIGraphicsEndImageContext();
        return polygonPath;
    }else if(sizePickerIndex == 1){
        UIGraphicsBeginImageContext(CGSizeMake(40.0, 40.0));
        UIBezierPath* polygonPath = UIBezierPath.bezierPath;
        [polygonPath moveToPoint: CGPointMake(20, 0)];
        [polygonPath addLineToPoint: CGPointMake(37.32, 30)];
        [polygonPath addLineToPoint: CGPointMake(2.68, 30)];
        [polygonPath closePath];
        UIGraphicsEndImageContext();
        return polygonPath;
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(80, 80));
        UIBezierPath* polygonPath = UIBezierPath.bezierPath;
        [polygonPath moveToPoint: CGPointMake(40, 0)];
        [polygonPath addLineToPoint: CGPointMake(74.64, 60)];
        [polygonPath addLineToPoint: CGPointMake(5.36, 60)];
        [polygonPath closePath];
        UIGraphicsEndImageContext();
        return polygonPath;
    }
}

+(UIBezierPath *)getCirclePath:(int)sizePickerIndex{
    
    if (sizePickerIndex == 0) {
        UIGraphicsBeginImageContext(CGSizeMake(20.0, 20.0));
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0, 20.0, 20.0)];
        UIGraphicsEndImageContext();
        return path;
    }else if(sizePickerIndex == 1){
        UIGraphicsBeginImageContext(CGSizeMake(40.0, 40.0));
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0, 40.0, 40.0)];
        UIGraphicsEndImageContext();
        return path;
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(80.0, 80.0));
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0, 80.0, 80.0)];
        UIGraphicsEndImageContext();
        return path;
    }
}

+(UIBezierPath *)getSnowPath:(int)sizePickerIndex{
    
    if (sizePickerIndex == 0) {
        UIGraphicsBeginImageContext(CGSizeMake(20.0, 20.0));
        UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
        [bezier2Path moveToPoint: CGPointMake(10, 6.75)];
        [bezier2Path addLineToPoint: CGPointMake(13.09, 9)];
        [bezier2Path addLineToPoint: CGPointMake(11.91, 12.63)];
        [bezier2Path addLineToPoint: CGPointMake(8.09, 12.63)];
        [bezier2Path addLineToPoint: CGPointMake(6.91, 9)];
        [bezier2Path addLineToPoint: CGPointMake(10, 6.75)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(5, 4)];
        [bezier2Path addCurveToPoint: CGPointMake(4, 3) controlPoint1: CGPointMake(5, 3.45) controlPoint2: CGPointMake(4.55, 3)];
        [bezier2Path addCurveToPoint: CGPointMake(3, 4) controlPoint1: CGPointMake(3.45, 3) controlPoint2: CGPointMake(3, 3.45)];
        [bezier2Path addCurveToPoint: CGPointMake(4, 5) controlPoint1: CGPointMake(3, 4.55) controlPoint2: CGPointMake(3.45, 5)];
        [bezier2Path addCurveToPoint: CGPointMake(5, 4) controlPoint1: CGPointMake(4.55, 5) controlPoint2: CGPointMake(5, 4.55)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(17, 4)];
        [bezier2Path addCurveToPoint: CGPointMake(16, 3) controlPoint1: CGPointMake(17, 3.45) controlPoint2: CGPointMake(16.55, 3)];
        [bezier2Path addCurveToPoint: CGPointMake(15, 4) controlPoint1: CGPointMake(15.45, 3) controlPoint2: CGPointMake(15, 3.45)];
        [bezier2Path addCurveToPoint: CGPointMake(16, 5) controlPoint1: CGPointMake(15, 4.55) controlPoint2: CGPointMake(15.45, 5)];
        [bezier2Path addCurveToPoint: CGPointMake(17, 4) controlPoint1: CGPointMake(16.55, 5) controlPoint2: CGPointMake(17, 4.55)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(5, 16)];
        [bezier2Path addCurveToPoint: CGPointMake(4, 15) controlPoint1: CGPointMake(5, 15.45) controlPoint2: CGPointMake(4.55, 15)];
        [bezier2Path addCurveToPoint: CGPointMake(3, 16) controlPoint1: CGPointMake(3.45, 15) controlPoint2: CGPointMake(3, 15.45)];
        [bezier2Path addCurveToPoint: CGPointMake(4, 17) controlPoint1: CGPointMake(3, 16.55) controlPoint2: CGPointMake(3.45, 17)];
        [bezier2Path addCurveToPoint: CGPointMake(5, 16) controlPoint1: CGPointMake(4.55, 17) controlPoint2: CGPointMake(5, 16.55)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(17, 16)];
        [bezier2Path addCurveToPoint: CGPointMake(16, 15) controlPoint1: CGPointMake(17, 15.45) controlPoint2: CGPointMake(16.55, 15)];
        [bezier2Path addCurveToPoint: CGPointMake(15, 16) controlPoint1: CGPointMake(15.45, 15) controlPoint2: CGPointMake(15, 15.45)];
        [bezier2Path addCurveToPoint: CGPointMake(16, 17) controlPoint1: CGPointMake(15, 16.55) controlPoint2: CGPointMake(15.45, 17)];
        [bezier2Path addCurveToPoint: CGPointMake(17, 16) controlPoint1: CGPointMake(16.55, 17) controlPoint2: CGPointMake(17, 16.55)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(1, 19)];
        [bezier2Path addLineToPoint: CGPointMake(19, 1)];
        [bezier2Path moveToPoint: CGPointMake(19, 19)];
        [bezier2Path addLineToPoint: CGPointMake(1, 1)];
        [bezier2Path moveToPoint: CGPointMake(10, 1)];
        [bezier2Path addLineToPoint: CGPointMake(10, 19)];
        [bezier2Path moveToPoint: CGPointMake(19, 10)];
        [bezier2Path addLineToPoint: CGPointMake(1, 10)];
        UIGraphicsEndImageContext();
        return bezier2Path;
    }else if(sizePickerIndex == 1){
        UIGraphicsBeginImageContext(CGSizeMake(40.0, 40.0));
        UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
        [bezier2Path moveToPoint: CGPointMake(20, 13.25)];
        [bezier2Path addLineToPoint: CGPointMake(26.42, 17.91)];
        [bezier2Path addLineToPoint: CGPointMake(23.97, 25.46)];
        [bezier2Path addLineToPoint: CGPointMake(16.03, 25.46)];
        [bezier2Path addLineToPoint: CGPointMake(13.58, 17.91)];
        [bezier2Path addLineToPoint: CGPointMake(20, 13.25)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(8, 6)];
        [bezier2Path addCurveToPoint: CGPointMake(6, 4) controlPoint1: CGPointMake(8, 4.9) controlPoint2: CGPointMake(7.1, 4)];
        [bezier2Path addCurveToPoint: CGPointMake(4, 6) controlPoint1: CGPointMake(4.9, 4) controlPoint2: CGPointMake(4, 4.9)];
        [bezier2Path addCurveToPoint: CGPointMake(6, 8) controlPoint1: CGPointMake(4, 7.1) controlPoint2: CGPointMake(4.9, 8)];
        [bezier2Path addCurveToPoint: CGPointMake(8, 6) controlPoint1: CGPointMake(7.1, 8) controlPoint2: CGPointMake(8, 7.1)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(35, 6)];
        [bezier2Path addCurveToPoint: CGPointMake(33, 4) controlPoint1: CGPointMake(35, 4.9) controlPoint2: CGPointMake(34.1, 4)];
        [bezier2Path addCurveToPoint: CGPointMake(31, 6) controlPoint1: CGPointMake(31.9, 4) controlPoint2: CGPointMake(31, 4.9)];
        [bezier2Path addCurveToPoint: CGPointMake(33, 8) controlPoint1: CGPointMake(31, 7.1) controlPoint2: CGPointMake(31.9, 8)];
        [bezier2Path addCurveToPoint: CGPointMake(35, 6) controlPoint1: CGPointMake(34.1, 8) controlPoint2: CGPointMake(35, 7.1)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(8, 34)];
        [bezier2Path addCurveToPoint: CGPointMake(6, 32) controlPoint1: CGPointMake(8, 32.9) controlPoint2: CGPointMake(7.1, 32)];
        [bezier2Path addCurveToPoint: CGPointMake(4, 34) controlPoint1: CGPointMake(4.9, 32) controlPoint2: CGPointMake(4, 32.9)];
        [bezier2Path addCurveToPoint: CGPointMake(6, 36) controlPoint1: CGPointMake(4, 35.1) controlPoint2: CGPointMake(4.9, 36)];
        [bezier2Path addCurveToPoint: CGPointMake(8, 34) controlPoint1: CGPointMake(7.1, 36) controlPoint2: CGPointMake(8, 35.1)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(36, 34)];
        [bezier2Path addCurveToPoint: CGPointMake(34, 32) controlPoint1: CGPointMake(36, 32.9) controlPoint2: CGPointMake(35.1, 32)];
        [bezier2Path addCurveToPoint: CGPointMake(32, 34) controlPoint1: CGPointMake(32.9, 32) controlPoint2: CGPointMake(32, 32.9)];
        [bezier2Path addCurveToPoint: CGPointMake(34, 36) controlPoint1: CGPointMake(32, 35.1) controlPoint2: CGPointMake(32.9, 36)];
        [bezier2Path addCurveToPoint: CGPointMake(36, 34) controlPoint1: CGPointMake(35.1, 36) controlPoint2: CGPointMake(36, 35.1)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(2, 2)];
        [bezier2Path addLineToPoint: CGPointMake(38, 38)];
        [bezier2Path moveToPoint: CGPointMake(2, 38)];
        [bezier2Path addLineToPoint: CGPointMake(37, 2)];
        [bezier2Path moveToPoint: CGPointMake(2, 20)];
        [bezier2Path addLineToPoint: CGPointMake(37, 20)];
        [bezier2Path moveToPoint: CGPointMake(20, 2)];
        [bezier2Path addLineToPoint: CGPointMake(20, 37)];
        UIGraphicsEndImageContext();
        return bezier2Path;
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(80.0, 80.0));
        UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
        [bezier2Path moveToPoint: CGPointMake(40, 26)];
        [bezier2Path addLineToPoint: CGPointMake(53.31, 35.67)];
        [bezier2Path addLineToPoint: CGPointMake(48.23, 51.33)];
        [bezier2Path addLineToPoint: CGPointMake(31.77, 51.33)];
        [bezier2Path addLineToPoint: CGPointMake(26.69, 35.67)];
        [bezier2Path addLineToPoint: CGPointMake(40, 26)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(20, 14.5)];
        [bezier2Path addCurveToPoint: CGPointMake(15.5, 10) controlPoint1: CGPointMake(20, 12.01) controlPoint2: CGPointMake(17.99, 10)];
        [bezier2Path addCurveToPoint: CGPointMake(11, 14.5) controlPoint1: CGPointMake(13.01, 10) controlPoint2: CGPointMake(11, 12.01)];
        [bezier2Path addCurveToPoint: CGPointMake(15.5, 19) controlPoint1: CGPointMake(11, 16.99) controlPoint2: CGPointMake(13.01, 19)];
        [bezier2Path addCurveToPoint: CGPointMake(20, 14.5) controlPoint1: CGPointMake(17.99, 19) controlPoint2: CGPointMake(20, 16.99)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(71, 14.5)];
        [bezier2Path addCurveToPoint: CGPointMake(66.5, 10) controlPoint1: CGPointMake(71, 12.01) controlPoint2: CGPointMake(68.99, 10)];
        [bezier2Path addCurveToPoint: CGPointMake(62, 14.5) controlPoint1: CGPointMake(64.01, 10) controlPoint2: CGPointMake(62, 12.01)];
        [bezier2Path addCurveToPoint: CGPointMake(66.5, 19) controlPoint1: CGPointMake(62, 16.99) controlPoint2: CGPointMake(64.01, 19)];
        [bezier2Path addCurveToPoint: CGPointMake(71, 14.5) controlPoint1: CGPointMake(68.99, 19) controlPoint2: CGPointMake(71, 16.99)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(71, 67.5)];
        [bezier2Path addCurveToPoint: CGPointMake(66.5, 63) controlPoint1: CGPointMake(71, 65.01) controlPoint2: CGPointMake(68.99, 63)];
        [bezier2Path addCurveToPoint: CGPointMake(62, 67.5) controlPoint1: CGPointMake(64.01, 63) controlPoint2: CGPointMake(62, 65.01)];
        [bezier2Path addCurveToPoint: CGPointMake(66.5, 72) controlPoint1: CGPointMake(62, 69.99) controlPoint2: CGPointMake(64.01, 72)];
        [bezier2Path addCurveToPoint: CGPointMake(71, 67.5) controlPoint1: CGPointMake(68.99, 72) controlPoint2: CGPointMake(71, 69.99)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(17, 67.5)];
        [bezier2Path addCurveToPoint: CGPointMake(12.5, 63) controlPoint1: CGPointMake(17, 65.01) controlPoint2: CGPointMake(14.99, 63)];
        [bezier2Path addCurveToPoint: CGPointMake(8, 67.5) controlPoint1: CGPointMake(10.01, 63) controlPoint2: CGPointMake(8, 65.01)];
        [bezier2Path addCurveToPoint: CGPointMake(12.5, 72) controlPoint1: CGPointMake(8, 69.99) controlPoint2: CGPointMake(10.01, 72)];
        [bezier2Path addCurveToPoint: CGPointMake(17, 67.5) controlPoint1: CGPointMake(14.99, 72) controlPoint2: CGPointMake(17, 69.99)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(5, 4)];
        [bezier2Path addLineToPoint: CGPointMake(73, 75)];
        [bezier2Path moveToPoint: CGPointMake(4, 76)];
        [bezier2Path addLineToPoint: CGPointMake(75, 4)];
        [bezier2Path moveToPoint: CGPointMake(4, 39)];
        [bezier2Path addLineToPoint: CGPointMake(75, 39)];
        [bezier2Path moveToPoint: CGPointMake(40, 4)];
        [bezier2Path addLineToPoint: CGPointMake(40, 75)];
        UIGraphicsEndImageContext();
        return bezier2Path;
    }
}
@end
