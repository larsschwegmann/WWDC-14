//
//  GameViewController.m
//  Lars Schwegmann
//
//  Created by Lars Schwegmann on 13.04.14.
//
//

//---------------------------------------------------------------------------------------------------------------

#import "GameViewController.h"

#define kGameStateRunning 1
#define kGameStatePaused  2

//---------------------------------------------------------------------------------------------------------------

@interface GameViewController ()

@property (nonatomic) int gameState;
@property (nonatomic) CGPoint ballSpeed;
@property (nonatomic) int ballSpeedJustChanged;
@property (nonatomic) int computerSpeed;
@property (nonatomic) int scoreToWin;
@property (nonatomic) BOOL firstLayout;

@end

//---------------------------------------------------------------------------------------------------------------

@implementation GameViewController

//---------------------------------------------------------------------------------------------------------------
#pragma mark - UIViewControllerMethods
//---------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Pong Neue";
    _leftPaddle.translatesAutoresizingMaskIntoConstraints = NO;
    //_leftPaddle.layer.masksToBounds = YES;
    //_leftPaddle.layer.cornerRadius = 5.0f;
    _rightPaddle.translatesAutoresizingMaskIntoConstraints = NO;
    //_rightPaddle.layer.masksToBounds = YES;
    //_rightPaddle.layer.cornerRadius = 5.0f;
    _ball.translatesAutoresizingMaskIntoConstraints = NO;
    _lineView.translatesAutoresizingMaskIntoConstraints = NO;
    _tapToBeginLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _yourPaddleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //_ball.layer.masksToBounds = YES;
    //_ball.layer.cornerRadius = 2.5f;
    
    _rightPaddle.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 30);
    _leftPaddle.center = CGPointMake(self.view.center.x, 64);
    _lineView.center = self.view.center;
    
    _gameState = kGameStatePaused;
    _ballSpeed = CGPointMake(2, 3); //easy
    _ballSpeedJustChanged = 0;
    _computerSpeed = 2;
    _scoreToWin = 5;
    _rightScore = 0;
    _leftScore = 0;
    _firstLayout = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:0.0075 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
}

- (void)gameLoop{
    if (_gameState == kGameStateRunning){
        _tapToBeginLabel.text = @"Tap to Start";
        
        //Move the ball
        _ball.center = CGPointMake(_ball.center.x + _ballSpeed.x, _ball.center.y + _ballSpeed.y);
        
        //Do wall check
        if (_ball.center.x > self.view.bounds.size.width || _ball.center.x < self.view.bounds.origin.x){
            _ballSpeed.x = -_ballSpeed.x;
        }
        if (_ball.center.y > self.view.bounds.size.height || _ball.center.y < 44){
            _ballSpeed.y = -_ballSpeed.y;
        }
        
        if (CGRectIntersectsRect(_ball.frame, _rightPaddle.frame) && _ballSpeedJustChanged == 0){
            int xOffset = _ball.center.x - _rightPaddle.center.x;
            _ballSpeed.x = xOffset/10;
			_ballSpeed.y = -_ballSpeed.y;
            _ballSpeedJustChanged = 30;
        }
        if (CGRectIntersectsRect(_ball.frame, _leftPaddle.frame) && _ballSpeedJustChanged == 0){
            if(_ball.center.x < _leftPaddle.center.x - 10) {
				_ballSpeed.x = -_ballSpeed.x;
			}
			
			_ballSpeed.y = -_ballSpeed.y;
            _ballSpeedJustChanged = 30;
        }
        //Stops the ball from clipping to the paddle
        if (_ballSpeedJustChanged > 0)
            _ballSpeedJustChanged--;
        
        //AI
        if(_ball.center.y <= self.view.center.y) {
            if(_ball.center.x < _leftPaddle.center.x) {
                CGPoint leftPaddleLocation = CGPointMake(_leftPaddle.center.x - _computerSpeed, _leftPaddle.center.y);
                _leftPaddle.center = leftPaddleLocation;
            }
            if(_ball.center.x > _leftPaddle.center.x) {
                CGPoint leftPaddleLocation = CGPointMake(_leftPaddle.center.x + _computerSpeed, _leftPaddle.center.y);
                _leftPaddle.center = leftPaddleLocation;
            }
		}
        
        if (_ball.center.y <= 44){
            //Player scores
            _rightScore++;
            if (_computerSpeed < 5)
                _computerSpeed++;
            self.title = [NSString stringWithFormat:@"%d-%d", _rightScore, _leftScore];
            [self reset:(_rightScore >= _scoreToWin)];
        }
        if (_ball.center.y >= self.view.bounds.size.height){
            //Computer scores
            _leftScore++;
            if (_computerSpeed > 1)
                _computerSpeed--;
            self.title = [NSString stringWithFormat:@"%d-%d", _rightScore, _leftScore];
            [self reset:(_leftScore >= _scoreToWin)];
        }
    }else{
        _yourPaddleLabel.hidden = NO;
        _tapToBeginLabel.hidden = NO;
        if (_firstLayout){
            _rightPaddle.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 30);
            _leftPaddle.center = CGPointMake(self.view.center.x, 64);
            _tapToBeginLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
            _yourPaddleLabel.center = CGPointMake(self.view.center.x, _rightPaddle.center.y - 50);
            _lineView.center = self.view.center;
            _ball.center = self.view.center;
        }
    }
}

- (void)reset:(BOOL)newGame{
    _gameState = kGameStatePaused;
    _ball.center = self.view.center;
    if (newGame){
        if (_rightScore > _leftScore){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You won!" message:@"Congrats! 😄" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You lost!" message:@"Please try again 😳" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles:nil];
            [alert show];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self resetPaddles];
}

- (void)resetPaddles{
    [UIView animateWithDuration:0.25f animations:^{
        _rightPaddle.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 30);
        _leftPaddle.center = CGPointMake(self.view.center.x, 64);
    }];
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(_gameState == kGameStatePaused) {
        _firstLayout = NO;
		_tapToBeginLabel.hidden = YES;
        _yourPaddleLabel.hidden = YES;
		_gameState = kGameStateRunning;
	} else if(_gameState == kGameStateRunning) {
		[self touchesMoved:touches withEvent:event];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:self.view];
	CGPoint xLocation = CGPointMake(location.x, _rightPaddle.center.y);
	_rightPaddle.center = xLocation;
}

//---------------------------------------------------------------------------------------------------------------
#pragma mark - Navigation
//---------------------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

@end
