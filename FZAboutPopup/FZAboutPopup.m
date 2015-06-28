//
//  FZAboutPopup.m
//  FZAboutPopup
//
//  Created by Zhou Weiou on 15-6-27.
//  Copyright (c) 2015年 Zhou Weiou. All rights reserved.
//

#import "FZAboutPopup.h"

@interface FZAboutPopup ()
@property (nonatomic,strong) UIImageView *logoView;
@property (nonatomic, assign) float cornerRadius;
@property (nonatomic, assign) bool isDisplayed;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * versionLabel;
@property (nonatomic, strong) UIButton *rateButton;
@property (nonatomic, strong) UIButton *dismissButton;

@property (nonatomic,strong) UIView *alertView;
@end

@implementation FZAboutPopup

- (instancetype)initWithIconImage:(UIImage *)image
{
    if (self=[super init]) {
        self.frame=[self screenFrame];
        self.backgroundColor=[UIColor clearColor];
        _alertView=[self alertPopupView];
        [self addSubview:_alertView];
        [self labelSetup];
        [self buttonSetup];
        [self circleIconSetupWithImage:image];
    }
    return self;
}

- (void)show
{
    [self dropAnimation];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}

#pragma mark - Populate subviews
- (UIView*) alertPopupView
{
    UIView * alertSquare;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        alertSquare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 180)];
    } else {
        alertSquare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    }
    alertSquare.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];
    alertSquare.center = CGPointMake([self screenFrame].size.width/2, -[self screenFrame].size.height/2);
    
    [alertSquare.layer setShadowColor:[UIColor blackColor].CGColor];
    [alertSquare.layer setShadowOpacity:0.4];
    [alertSquare.layer setShadowRadius:20.0f];
    [alertSquare.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
    [alertSquare.layer setCornerRadius:5.0f];
    return alertSquare;
}

- (void)labelSetup
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _titleLabel.center = CGPointMake(_alertView.frame.size.width/2, 50);
        _versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 50)];
        _versionLabel.center = CGPointMake(_alertView.frame.size.width/2, 80);
    } else {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _titleLabel.center = CGPointMake(_alertView.frame.size.width/2, 45);
        _versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 50)];
        _versionLabel.center = CGPointMake(_alertView.frame.size.width/2, 80);
    }
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
    NSString *appName=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    _titleLabel.text=appName;
    _titleLabel.font=[UIFont boldSystemFontOfSize:20.0f];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [_alertView addSubview:_titleLabel];
    _versionLabel.text=[NSString stringWithFormat:@"%@(%@)",version,build];
    _versionLabel.font=[UIFont systemFontOfSize:12.0f];
    _versionLabel.textAlignment=NSTextAlignmentCenter;
    [_alertView addSubview:_versionLabel];
}

- (void)buttonSetup
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        _rateButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _rateButton.center = CGPointMake(_alertView.frame.size.width/2, 120);
        _dismissButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _dismissButton.center=CGPointMake(_alertView.frame.size.width/2, 155);
    } else {
        _rateButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _rateButton.center = CGPointMake(_alertView.frame.size.width/2, 120);
        _dismissButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _dismissButton.center=CGPointMake(_alertView.frame.size.width/2, 155);
    }
    [_rateButton setTitle:NSLocalizedString(@"Rate me", @"Rate me") forState:UIControlStateNormal];
    _rateButton.titleLabel.font=[UIFont boldSystemFontOfSize:18.0f];
    _rateButton.titleLabel.textColor=[UIColor whiteColor];
    [_rateButton.layer setCornerRadius:3.0f];
    [_rateButton addTarget:self action:@selector(onRateButton:) forControlEvents:UIControlEventTouchUpInside];
    _rateButton.backgroundColor=[UIColor colorWithRed:0.906 green:0.296 blue:0.235 alpha:1];
    
    [_dismissButton setTitle:NSLocalizedString(@"Dismiss", @"Dismiss") forState:UIControlStateNormal];
    _dismissButton.titleLabel.font=[UIFont boldSystemFontOfSize:18.0f];
    _dismissButton.titleLabel.textColor=[UIColor whiteColor];
    [_dismissButton.layer setCornerRadius:3.0f];
    [_dismissButton addTarget:self action:@selector(onDismissButton:) forControlEvents:UIControlEventTouchUpInside];
    _dismissButton.backgroundColor=[UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:1];
    
    [_alertView addSubview:_rateButton];
    [_alertView addSubview:_dismissButton];
}

- (void)circleIconSetupWithImage:(UIImage *)image
{
    _logoView=[[UIImageView alloc] initWithImage:image];
    _logoView.contentMode=UIViewContentModeScaleToFill;
    CGRect screenFrame=[self screenFrame];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        _logoView.frame=CGRectMake(screenFrame.size.width/2-30, (screenFrame.size.height-_alertView.frame.size.height)/2-30, 60, 60);
        _logoView.layer.masksToBounds=YES;// otherwise, setCornerRadius will not work
        [_logoView.layer setCornerRadius:30.0f];
    } else {
        
    }
    [self addSubview:_logoView];
    _logoView.alpha=0.0;
}

#pragma mark - Action
- (void)onDismissButton:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        _logoView.frame = [self scaleFrameWithWidth:10 height:10 forView:_logoView];
        _logoView.alpha=0.0;
        _alertView.center = CGPointMake([self screenFrame].size.width/2, -[self screenFrame].size.height/2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)onRateButton:(UIButton *)sender
{
    //
}

#pragma mark - Helper

- (CGRect)scaleFrameWithWidth:(CGFloat)width height:(CGFloat)height forView:(UIView *)view
{
    return CGRectMake(view.frame.origin.x + ((view.frame.size.width - width)/2),
                      view.frame.origin.y + ((view.frame.size.height - height)/2),
                      width,
                      height);
}

- (CGRect) screenFrame
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect;
}

#pragma mark - Animation

- (void)dropAnimation
{
    NSMutableArray* animationBlocks = [NSMutableArray new];
    
    typedef void(^animationBlock)(BOOL);
    
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };
    
    CGRect screenRect=[self screenFrame];
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _alertView.center = CGPointMake(screenRect.size.width/2, (screenRect.size.height/2)+_alertView.frame.size.height*0.3);
        } completion: getNextAnimation()];
    }];
    
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _alertView.center = CGPointMake(screenRect.size.width/2, (screenRect.size.height/2));
        } completion: getNextAnimation()];
    }];
    
    [animationBlocks addObject:^(BOOL finished){;
        [self circleAnimation];
    }];
    
    getNextAnimation()(YES);
}

- (void)circleAnimation
{
    NSMutableArray* animationBlocks = [NSMutableArray new];
    
    typedef void(^animationBlock)(BOOL);
    
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };
    
    NSArray *scale;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        scale=@[@85,@50,@60];
    } else {
        scale=@[@85,@50,@60];
    }
    
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _logoView.frame = [self scaleFrameWithWidth:[scale[0] integerValue] height:[scale[0] integerValue] forView:_logoView];
            _logoView.alpha=1.0;
        } completion: getNextAnimation()];
    }];
    
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _logoView.frame = [self scaleFrameWithWidth:[scale[1] integerValue] height:[scale[1] integerValue] forView:_logoView];
        } completion: getNextAnimation()];
    }];
    
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _logoView.frame = [self scaleFrameWithWidth:[scale[2] integerValue] height:[scale[2] integerValue] forView:_logoView];
        } completion: getNextAnimation()];
    }];
    
    getNextAnimation()(YES);
}

@end
