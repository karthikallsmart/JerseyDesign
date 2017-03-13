//
//  ViewController.m
//  JerseyDesign
//
//  Created by User1 on 3/3/17.
//  Copyright © 2017 User1. All rights reserved.
//

#import "ViewController.h"
#import "TGDrawSvgPathView.h"
#import <QuartzCore/QuartzCore.h>
#import "TableViewCell.h"
@interface ViewController ()
{
    BOOL isNextSelected,isFirstTimeLoad;
    NSInteger indexValue,countForPatterns;;
    NSMutableArray *arrayForImages,*arrayForColors;
}
@property (nonatomic, strong) CAShapeLayer* shapeView;
@property (nonatomic, strong) TGDrawSvgPathView* tgView;
@property (nonatomic) CFTimeInterval animationDuration;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    indexValue=0;
    _animationDuration=0;
    
    CGFloat widthOfVw=self.view.frame.size.width-40;
  
    _widthOfVw.constant=widthOfVw;
    _heightOfVw.constant = widthOfVw;
    
    [self.vwForImage updateConstraints];
    self.vwForImage.backgroundColor=[UIColor clearColor];
    
//    _tgView = [[TGDrawSvgPathView alloc] initWithFrame:CGRectMake(0,0, widthOfVw,widthOfVw)];
//    [_tgView setPathFromSvg:@"04_tykaPattern2" strokeColor:[UIColor blackColor] fillColor:[UIColor lightGrayColor] duration:_animationDuration];
//    [self.vwForImage addSubview:_tgView];
    
//    [_tgView setPathFromSvg:@"04_tykaPattern2" strokeColor:[UIColor blackColor] fillColor:[UIColor lightGrayColor] duration:_animationDuration];
//    [self.vwForImage addSubview:_tgView];
//    [_tgView setPathFromSvg:@"02_Newpattern" strokeColor:[UIColor blackColor] fillColor:[UIColor lightGrayColor] duration:_animationDuration];
//    [self.vwForImage addSubview:_tgView];
    
    arrayForImages=[[NSMutableArray alloc] init];
    
    [arrayForImages addObject:@"07_mask.png"];
    [arrayForImages addObject:@"03_pattern.png"];
    [arrayForImages addObject:@"04_pattern.png"];
    [arrayForImages addObject:@"05_pattern"];
    [arrayForImages addObject:@"06_collar_1.png"];

    
    arrayForColors=[[NSMutableArray alloc] init];
    [arrayForColors addObject:[UIColor lightGrayColor]];
    [arrayForColors addObject:[UIColor blueColor]];
    [arrayForColors addObject:[UIColor redColor]];
    [arrayForColors addObject:[UIColor whiteColor]];
    [arrayForColors addObject:[UIColor redColor]];
    
    
    _tableVw.delegate=self;
    _tableVw.dataSource=self;
    indexValue=0;

    _imgVw.hidden = YES;
    [self setLayers:[UIColor lightGrayColor]];
    [self setUpColorBtns];
    self.vwForImage.userInteractionEnabled = YES;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveImage)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    countForPatterns=0;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.vwForImage addGestureRecognizer:swipeLeft];
    [self.vwForImage addGestureRecognizer:swipeRight];
    
    swipeLeft.delegate=self;
    swipeRight.delegate=self;
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)gesture{

    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft){

        if (countForPatterns < arrayForImages.count-1) {
            CATransition *animation = [CATransition animation];
            [animation setDelegate:self];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromRight];
            [animation setDuration:0.50];
            [animation setTimingFunction:
             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.vwForImage.layer addAnimation:animation forKey:kCATransition];
         countForPatterns++;
        }
    }else if (gesture.direction == UISwipeGestureRecognizerDirectionRight){
        
        if (countForPatterns <= arrayForImages.count && countForPatterns != 0){
        
            CATransition *animation = [CATransition animation];
            [animation setDelegate:self];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromLeft];
            [animation setDuration:0.50];
            [animation setTimingFunction:
             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.vwForImage.layer addAnimation:animation forKey:kCATransition];
            countForPatterns--;
        }
    }
}

- (UIColor *)averageColor:(UIImage*)img {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), img.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

-(void)saveImage{
 
    UIImage *imag=[self imageWithView:_vwForImage];
    
    UIImageWriteToSavedPhotosAlbum(imag,
                                   nil,
                                   nil,
                                   nil);
    
}

-(UIImage *)imageWithView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

-(void)setUpColorBtns{
    
    self.btnForBlue.backgroundColor=[UIColor blueColor];
    self.btnForGray.backgroundColor=[UIColor lightGrayColor];
    self.btnForGreen.backgroundColor=[UIColor greenColor];
    self.btnForOrange.backgroundColor=[UIColor orangeColor];
    self.btnForRed.backgroundColor=[UIColor redColor];
    self.btnForYellow.backgroundColor=[UIColor yellowColor];
    
    [self roundCornerBtn:self.btnForBlue];
    [self roundCornerBtn:self.btnForGray];
    [self roundCornerBtn:self.btnForGreen];
    [self roundCornerBtn:self.btnForOrange];
    [self roundCornerBtn:self.btnForRed];
    [self roundCornerBtn:self.btnForYellow];
    
    [self.btnForBlue addTarget:self action:@selector(onClickBlue) forControlEvents:UIControlEventTouchUpInside];
    [self.btnForGray addTarget:self action:@selector(onClickGray) forControlEvents:UIControlEventTouchUpInside];
    [self.btnForGreen addTarget:self action:@selector(onClickGreen) forControlEvents:UIControlEventTouchUpInside];
    [self.btnForOrange addTarget:self action:@selector(onClickOrange) forControlEvents:UIControlEventTouchUpInside];
    [self.btnForRed addTarget:self action:@selector(onClickRed) forControlEvents:UIControlEventTouchUpInside];
    [self.btnForYellow addTarget:self action:@selector(onClickYellow) forControlEvents:UIControlEventTouchUpInside];
}

-(void)roundCornerBtn:(UIButton*)sender{
    sender.layer.cornerRadius = sender.frame.size.height/2;
    sender.layer.masksToBounds = YES;
}

- (IBAction)onClickNext:(UIButton *)sender {
    if (sender.tag == 1) {
        indexValue=0;
    }else{
        indexValue=1;
    }
}

-(void)onClickBlue{
    [self setColor:[UIColor blueColor]];
}

-(void)onClickGray{
     [self setColor:[UIColor lightGrayColor]];
}

-(void)onClickGreen{
       [self setColor:[UIColor greenColor]];
}

-(void)onClickOrange{
       [self setColor:[UIColor orangeColor]];
}

-(void)onClickRed{
        [self setColor:[UIColor redColor]];
}

-(void)onClickYellow{
       [self setColor:[UIColor yellowColor]];
}

-(void)setColor:(UIColor*)color{

//    NSMutableArray *array=[[NSMutableArray alloc] init];
//    array =[_tgView.layer.sublayers mutableCopy];
//    
//    for (CAShapeLayer *layer in _tgView.layer.sublayers) {
//        if ([_tgView.layer.sublayers indexOfObject:layer] == indexValue) {
//            layer.fillColor=color.CGColor;
//            layer.strokeColor=[UIColor clearColor].CGColor;
//            [array replaceObjectAtIndex:indexValue withObject:layer];
//            _tgView.layer.sublayers = array;
//        }
//    }
    _vwForImage.layer.sublayers=nil;
    [arrayForColors replaceObjectAtIndex:indexValue withObject:color];
    [self setLayers:color];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    for (UITouch *touch in touches) {
//        CGPoint touchLocation = [touch locationInView:_tgView];
//        for (id sublayer in _tgView.layer.sublayers) {
//            if ([sublayer isKindOfClass:[CAShapeLayer class]]) {
//                CAShapeLayer *shapeLayer = sublayer;
//                if (CGPathContainsPoint(shapeLayer.path, 0, touchLocation, YES)) {
//                    indexValue=[_tgView.layer.sublayers indexOfObject:sublayer];
//                }
//            } else {
//                CALayer *layer = sublayer;
//                if (CGRectContainsPoint(layer.frame, touchLocation)) {
//                }
//            }
//        }
//    }
    
    //for (UITouch *touch in touches) {
//        CGPoint touchLocation = [touch locationInView:_vwForImage];
//        for (id sublayer in _vwForImage.layer.sublayers) {
//            if ([sublayer isKindOfClass:[CAShapeLayer class]]) {
//                CAShapeLayer *shapeLayer = sublayer;
                
//                if (CGRectContainsPoint(shapeLayer.frame, touchLocation)) {
                    //  indexValue=[_vwForImage.layer.sublayers indexOfObject:sublayer];
//                    NSLog(@"Got it===%i",indexValue);
//                }
//            } else {
//                CALayer *layer = sublayer;
//                if (CGRectContainsPoint(layer.frame, touchLocation)) {
//                }
//            }
//        }
//    }
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayForImages.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell==nil) {
        cell=[[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.imgVw.image=[UIImage imageNamed:[arrayForImages objectAtIndex:indexPath.row]];
   // cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //237,237,238
    cell.backgroundColor=[UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(238/255.0) alpha:1.0];
    
    cell.imgVw.layer.borderColor=[UIColor blackColor].CGColor;
    cell.imgVw.layer.borderWidth=0.5;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    indexValue=indexPath.row;
}

-(void)setLayers:(UIColor*)color{
    
    CGFloat widthOfVw=self.view.frame.size.width-40;
    CAShapeLayer *sublayer = [[CAShapeLayer alloc] init];
    
    if (indexValue == 0) {
        sublayer.backgroundColor = color.CGColor;
    }else{
        UIColor *color=[arrayForColors objectAtIndex:0];
        sublayer.backgroundColor = color.CGColor;
    }
    
    UIImage *image=[UIImage imageNamed:[arrayForImages objectAtIndex:0]];
    sublayer.contents = (id) image.CGImage;
    sublayer.frame = CGRectMake(0, 0, widthOfVw, widthOfVw);
    [self.vwForImage.layer addSublayer:sublayer];
    
   for (char i=0;i<arrayForImages.count-1;i++) {
       
        CAShapeLayer *sublayer2 = [[CAShapeLayer alloc] init];
        UIImage *image;
        UIImage *newImage;
        image=[UIImage imageNamed:[arrayForImages objectAtIndex:i+1]];
        newImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIGraphicsBeginImageContextWithOptions(image.size, NO, newImage.scale);
        if (indexValue == i+1) {
                 [color set];
        }else{
            UIColor *color=[arrayForColors objectAtIndex:i+1];
            [color set];
        }
        [newImage drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
       
       sublayer2.contents = (id)newImage.CGImage;
        sublayer2.frame = CGRectMake(0, 0, widthOfVw, widthOfVw);
        [self.vwForImage.layer addSublayer:sublayer2];
   }
   // isFirstTimeLoad=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
