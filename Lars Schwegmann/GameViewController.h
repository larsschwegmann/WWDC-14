//
//  GameViewController.h
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 13.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import <UIKit/UIKit.h>

//---------------------------------------------------------------------------------------------------------------

@interface GameViewController : UIViewController

@property (nonatomic) int leftScore;
@property (nonatomic) int rightScore;

@property (weak, nonatomic) IBOutlet UIView *leftPaddle;
@property (weak, nonatomic) IBOutlet UIView *rightPaddle;
@property (weak, nonatomic) IBOutlet UIView *ball;

@property (weak, nonatomic) IBOutlet UILabel *tapToBeginLabel;
@property (weak, nonatomic) IBOutlet UILabel *yourPaddleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

//---------------------------------------------------------------------------------------------------------------