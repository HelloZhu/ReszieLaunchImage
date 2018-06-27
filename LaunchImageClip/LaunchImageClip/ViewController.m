//
//  ViewController.m
//  LaunchImageClip
//
//  Created by ap2 on 2018/6/27.
//  Copyright © 2018年 ap2. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    
}

- (IBAction)resizeImageAction:(NSButton *)sender
{
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:self.imageTX.stringValue];
    NSImage *image1334 = [self resizeImage:image size:NSMakeSize(750, 1334)];
    NSImage *image1136 = [self resizeImage:image size:NSMakeSize(640, 1136)];
    NSImage *image960 = [self resizeImage:image size:NSMakeSize(640, 960)];
    
    [self saveImage:image1334 name:@"image1334"];
    [self saveImage:image1136 name:@"image1136"];
    [self saveImage:image960 name:@"image960"];
    
}

- (void )saveImage:(NSImage *)image name:(NSString *)name
{
    [image lockFocus];
    //先设置 下面一个实例
    NSBitmapImageRep *bits = [[NSBitmapImageRep alloc]initWithFocusedViewRect:NSMakeRect(0, 0, image.size.width, image.size.height)];        //138.32为图片的长和宽
    [image unlockFocus];
    
    //再设置后面要用到得 props属性
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:0] forKey:NSImageCompressionFactor];
    
    //之后 转化为NSData 以便存到文件中
    NSData *imageData = [bits representationUsingType:NSPNGFileType properties:imageProps];

    NSString *path = [NSString stringWithFormat:@"/Users/apple2/Downloads/%@.png",name];
//    NSString *path = [[NSString stringWithFormat:@"~/Documents/%@.png",name] stringByExpandingTildeInPath];
    NSLog(@"path=%@",path);
    BOOL y = [imageData writeToFile:path atomically:YES];    //保存的文件路径一定要是绝对路径，相对路径不行
    
    //设定好文件路径后进行存储就ok了
//    BOOL y = [imageData writeToFile:path atomically:YES];    //保存的文件路径一定要是绝对路径，相对路径不行
    NSLog(@"Save Image: %d", y);
}

- (NSImage*)resizeImage:(NSImage*)sourceImage size:(NSSize)size
{
    NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
    NSImage* targetImage = nil;
    NSImageRep *sourceImageRep =
    [sourceImage bestRepresentationForRect:targetFrame
                                   context:nil
                                     hints:nil];
    
    targetImage = [[NSImage alloc] initWithSize:size];
    
    [targetImage lockFocus];
    [sourceImageRep drawInRect: targetFrame];
    [targetImage unlockFocus];
    return targetImage;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
