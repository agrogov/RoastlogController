//
//  MainViewController.m
//  HM10Controller
//
//  Created by Musawir Shah on 2/14/14.
//  Copyright (c) 2014 Musawir Shah. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *connectionLabel;
@property (weak, nonatomic) IBOutlet UITextView *bleOut;
@property (weak, nonatomic) IBOutlet UITextField *cmdText;

@end

@implementation MainViewController
@synthesize connectdPeri = _connectdPeri;
@synthesize centralManager = _centralManager;

- (void)setCentralManager:(CBCentralManager *)centralManager
{
    _centralManager = centralManager;
    _centralManager.delegate = self;
}

- (void)setConnectdPeri:(CBPeripheral *)connectdPeri
{
    [self.navigationController popToViewController:self animated:TRUE];

    _connectdPeri = connectdPeri;
    _connectdPeri.delegate = self;
    for (CBService * service in [self.connectdPeri services])
    {
        for (CBCharacteristic * characteristic in [service characteristics])
        {
            [_connectdPeri setNotifyValue:TRUE forCharacteristic:characteristic];
        }
    }
    
    self.connectionLabel.text = [NSString stringWithFormat:@"Connected to %@", _connectdPeri.name];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_cmdText endEditing:YES];
}

- (IBAction)pressUp:(id)sender {
    [self sendValue:@"W"];
}
- (IBAction)pressLeft:(id)sender {
    [self sendValue:@"A"];
}
- (IBAction)pressRight:(id)sender {
    [self sendValue:@"D"];
}
- (IBAction)pressDown:(id)sender {
    [self sendValue:@"S"];
}
- (IBAction)cmdSend:(id)sender {
    [self sendValue:[NSString stringWithFormat:@"%@", _cmdText.text]];
    _cmdText.text = nil;
}


- (void)sendValue:(NSString *) str
{
    for (CBService * service in [self.connectdPeri services])
    {
        for (CBCharacteristic * characteristic in [service characteristics])
        {
            [self.connectdPeri writeValue:[str dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
        }
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSString * str = [[NSString alloc] initWithData:[characteristic value] encoding:NSUTF8StringEncoding];
    self.bleOut.text = [NSString stringWithFormat:@"%@\n%@", self.bleOut.text, str];
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    int x = 0;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    int x = 0;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
