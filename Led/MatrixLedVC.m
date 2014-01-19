//
//  MatrixLedVC.m
//  Led
//
//  Created by tam on 1/17/14.
//  Copyright (c) 2014 tam. All rights reserved.
//

#import "MatrixLedVC.h"
#import "LedView.h"
#import "Font.h"
#import "InputVC.h"

#define LED_W 24
#define LED_H 24

@interface MatrixLedVC ()
{
    LedView *newLed;
    NSString *currentCharecter;
    int *currentFont;
    NSTimer *timer;
    UIImage *on;
    UIImage *off;
}

@property (nonatomic, strong) NSMutableArray *arrayLed;
@property (nonatomic, strong) NSArray *font;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) int column;
@property (nonatomic) int index;

@end

@implementation MatrixLedVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    _column = 0;
    _index = 0;
    InputVC *inputVC = self.tabBarController.viewControllers.firstObject;
    
    if (inputVC.tf != NULL)
    {
        _text = [NSString stringWithFormat:@"%@", inputVC.tf.text];
        currentCharecter = [_text substringWithRange:NSMakeRange(0, 1)];
    }
    
    if (inputVC.tf == NULL) {
        _text = @"InputText";
    }
    
    currentFont = [self findFontForCharecter:currentCharecter];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.3f
                                             target:self
                                           selector:@selector(loop)
                                           userInfo:Nil
                                            repeats:YES];
    
    if (inputVC.hideShowLed != nil)
    {
        if (inputVC.hideShowLed.selectedSegmentIndex == 1)
            off = [UIImage imageNamed:@"off"];
        else off = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _column = 0;
    _index = 0;
    _arrayLed = [NSMutableArray new];
    on = [UIImage imageNamed:@"on"];
    self.view.backgroundColor = [UIColor grayColor];
    
    for (int i = 0; i < 7; i ++) {
        for (int j = 0; j < 22; j++) {
            newLed = [[LedView alloc] initWithFrame:CGRectMake(LED_W * j + 20 , LED_H * i + 50, LED_W, LED_H)];
            newLed.image = off;
            [self.view addSubview:newLed];
            [_arrayLed insertObject:newLed atIndex:(22 * i + j)];
        }
    }
    _font = [self readTextFromFile];
}

- (NSArray *)readTextFromFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fontForLedMatrix"
                                                     ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    NSArray *array = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *arrResult = [NSMutableArray new];
    
    for (int i = 0; i < [array count]; i++){
        Font *newFont = [Font new];
        newFont.character = [NSString stringWithFormat:@"%@", array[i]];
        for (int j = 0; j < 7; j++){
            for (int k = 0; k < 5; k++) {
                newFont.code[j * 5 + k] = [array[i + 1 + j] characterAtIndex: 2 * k] - '0';
            }
        }
        [arrResult addObject:newFont];
        i += 7;
    }
    return arrResult;
}

- (int *) findFontForCharecter:(NSString *) a
{
    for (Font *font in _font)
    {
        if ([font.character isEqual:a])
        {
            return font.code;
        }
    }
    
    int *i = (int *) malloc(sizeof(int) * 35);
    for (int k = 0; k < 35; k++)
    {
        i[k] = 0;
    }
    return i;
}

- (void) loop
{
    for (int i = 0; i < 7; i ++) {
        for (int j = 0; j < 21; j++)
        {
            ((UIImageView *)[_arrayLed objectAtIndex:(22 * i + j)]).image =
            ((UIImageView *)[_arrayLed objectAtIndex:(22 * i + j + 1)]).image;
        }
    }
    
    for (int i = 0; i < 7; i ++) {
        ((UIImageView *)[_arrayLed objectAtIndex:22 * i + 21]).image = off;
    }
    [self setLed];
}

- (void) setLed
{
    for (int i = 0; i < 7; i++){
        if (currentFont[5 * i + _column] == 1)
            ((UIImageView *)[_arrayLed objectAtIndex:22 * i + 21]).image = on;
    }
    
    _column++;
    
    if (_column >= 5)
    {
        _column = 0;
        _index++;
        if (_index >= _text.length)
        {
            _index = 0;
        }
        currentCharecter = [_text substringWithRange:NSMakeRange(_index, 1)];
        currentFont = [self findFontForCharecter:currentCharecter];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
