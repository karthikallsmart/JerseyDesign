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
    BOOL isNextSelected;
    NSInteger indexValue;
    NSMutableArray *arrayForImages;
    NSMutableArray *arrayForColors;
    BOOL isFirstTimeLoad;
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
    
    _tgView = [[TGDrawSvgPathView alloc] initWithFrame:CGRectMake(0,0, widthOfVw,widthOfVw)];
//    [_tgView setPathFromSvg:@"01_Body" strokeColor:[UIColor blackColor] fillColor:[UIColor lightGrayColor] duration:_animationDuration];
//    [self.vwForImage addSubview:_tgView];
//    [_tgView setPathFromSvg:@"image2vector" strokeColor:[UIColor blackColor] fillColor:[UIColor lightGrayColor] duration:_animationDuration];
//    [self.vwForImage addSubview:_tgView];
//
    //
    //        [_tgView setPathFromSvg:@"02_Newpattern" strokeColor:[UIColor blackColor] fillColor:[UIColor lightGrayColor] duration:_animationDuration];
    //        [self.vwForImage addSubview:_tgView];

    arrayForImages=[[NSMutableArray alloc] init];
    
    [arrayForImages addObject:@"1.png"];
    [arrayForImages addObject:@"4.png"];
    [arrayForImages addObject:@"2.png"];
    [arrayForImages addObject:@"5.png"];
    [arrayForImages addObject:@"6.png"];
    [arrayForImages addObject:@"7.png"];
    [arrayForImages addObject:@"3.png"];

    arrayForColors=[[NSMutableArray alloc] init];
    
    [arrayForColors addObject:[UIColor lightGrayColor]];
    [arrayForColors addObject:[UIColor blackColor]];
    [arrayForColors addObject:[UIColor blackColor]];
    [arrayForColors addObject:[UIColor blackColor]];
    [arrayForColors addObject:[UIColor blackColor]];
    [arrayForColors addObject:[UIColor blackColor]];
    [arrayForColors addObject:[UIColor blackColor]];
    
    _tableVw.delegate=self;
    _tableVw.dataSource=self;
    indexValue=0;
    //isFirstTimeLoad=YES;
    
    _imgVw.hidden = YES;
    [self setLayers:[UIColor lightGrayColor]];
    
    [self setUpColorBtns];
    self.vwForImage.userInteractionEnabled = YES;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveImage)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}
-(void)saveImage{
 
    UIImage *imag=[self imageWithView:_vwForImage];
    
    UIImageWriteToSavedPhotosAlbum(imag,
                                   nil,
                                   nil,
                                   nil);
    
}

-(UIImage *)imageWithView:(UIView *)view
{
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
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
    
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInView:_vwForImage];
        for (id sublayer in _vwForImage.layer.sublayers) {
            if ([sublayer isKindOfClass:[CAShapeLayer class]]) {
                CAShapeLayer *shapeLayer = sublayer;

                if (CGRectContainsPoint(shapeLayer.frame, touchLocation)) {
                    indexValue=[_vwForImage.layer.sublayers indexOfObject:sublayer];
                    NSLog(@"Got it===%i",indexValue);
                }
                
            } else {
                CALayer *layer = sublayer;
                if (CGRectContainsPoint(layer.frame, touchLocation)) {
                }
            }
        }
    }
}

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
    cell.backgroundColor=[UIColor lightGrayColor];
    
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
    
    sublayer.contents = (id) [UIImage imageNamed:@"1.png"].CGImage;
    sublayer.frame = CGRectMake(0, 0, widthOfVw, widthOfVw);
    [self.vwForImage.layer addSublayer:sublayer];
    
    for (char i=0;i<6;i++) {
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
