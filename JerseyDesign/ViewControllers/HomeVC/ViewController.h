//
//  ViewController.h
//  JerseyDesign
//
//  Created by User1 on 3/3/17.
//  Copyright © 2017 User1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *vwForImage;
@property (strong, nonatomic) IBOutlet UIImageView *imgVwForThumbnail;

@property (strong, nonatomic) IBOutlet UIButton *btnForRotate;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionVw;


- (IBAction)onClickRotate:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnAddText;

- (IBAction)onClickAddText:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableVw;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfVw;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfVw;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfImgVwThumb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfImgVwThumb;


@property (strong, nonatomic) IBOutlet UIButton *btnForRed;
@property (strong, nonatomic) IBOutlet UIButton *btnForGray;
@property (strong, nonatomic) IBOutlet UIButton *btnForGreen;
@property (strong, nonatomic) IBOutlet UIButton *btnForYellow;
@property (strong, nonatomic) IBOutlet UIButton *btnForBlue;
@property (strong, nonatomic) IBOutlet UIButton *btnForOrange;

@property (strong, nonatomic) IBOutlet UIImageView *imgVw;

// redColor lightGrayColor greenColor yellowColor blueColor orangeColor

- (IBAction)onClickNext:(UIButton *)sender;

@end

