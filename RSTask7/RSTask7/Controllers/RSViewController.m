//
//  RSViewController.m
//  RSTask7
//
//  Created by Вякулин Сергей on 04.07.2021.
//

#import "RSViewController.h"

@interface RSViewController () <UITextFieldDelegate>
// создаем outlet и свойства связанные с xib
@property (weak, nonatomic) IBOutlet UILabel *logo;
@property (weak, nonatomic) IBOutlet UITextField *loginTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *authorizeBT;

@property (weak, nonatomic) IBOutlet UIView *secureView;
@property (weak, nonatomic) IBOutlet UILabel *secureLabel;
@property (weak, nonatomic) IBOutlet UIButton *secureBT1;
@property (weak, nonatomic) IBOutlet UIButton *secureBT2;
@property (weak, nonatomic) IBOutlet UIButton *secureBT3;

@end


@implementation RSViewController
//проверочные login & password
NSString *login = @"username";
NSString *password = @"password";

- (void)viewDidLoad {
    [super viewDidLoad];
    //запускаем метод предварительной настройки
    [self preSet];
    //подписываем наблюдателя за нажатием на пустой экран, чтобы скрывать клавиатуру
    [self hideWhenTappedAround];
    //подписываемя под делегат TextField для проверки вводимой информации
    self.loginTF.delegate = self;
    self.passwordTF.delegate = self;
    //добавляем наблюдателей нажатий на кнопки + действия для кнопок
    [self.authorizeBT addTarget:self action:@selector(authButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.authorizeBT addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
    [self.secureBT1 addTarget:self action:@selector(secureBtTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.secureBT1 addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
    [self.secureBT2 addTarget:self action:@selector(secureBtTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.secureBT2 addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
    [self.secureBT3 addTarget:self action:@selector(secureBtTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.secureBT3 addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
}

//Метод для обработки нажатия на кнопку дополнительной проверки (когда пользователь отпустил кнопку)
-(void)secureBtTapped:(UIButton *)button{
    //отключаем подсвечивание, чтобы alpha не накладывалась
    [button setHighlighted:false];
    //восстанавливаем фон, после активного нажатия (custom Highlited)
    button.backgroundColor = UIColor.whiteColor;
    //восстанавливаем цвет текста
    button.titleLabel.tintColor = [UIColor colorNamed:@"Little Boy Blue"];
    //скрываем окантовку поля дополнительной проверки
    self.secureView.layer.borderWidth = 0;
    //выделяем память для переменной в которой будем хранить информацию о нажатой кнопке дополнительного поля
    NSMutableString *numberStr = [NSMutableString alloc];
    //определяем какая кнопка, и в соответствии записываем текст в переменную
    if ([button isEqual:self.secureBT1]){
        numberStr = [numberStr initWithString:@"1"];
    }
    if ([button isEqual:self.secureBT2]){
        numberStr = [numberStr initWithString:@"2"];
    }
    if ([button isEqual:self.secureBT3]){
        numberStr = [numberStr initWithString:@"3"];
    }
    //заполняем проверочны label
    if ([self.secureLabel.text isEqual: @"_"]) {
        //если только начало, то просто вписываем текст
        self.secureLabel.text = numberStr;
    } else if ([self.secureLabel.text length] == 1 && ![self.secureLabel.text isEqual: @"_"]) {
        //если один символ уже внесен, то добавляем к нему второй
        NSMutableString *newString = [[NSMutableString alloc] initWithString:self.secureLabel.text];
        [newString appendString:@" "];
        [newString appendString: numberStr];
        self.secureLabel.text = newString;
    } else if ([self.secureLabel.text length] == 3 && [self.secureLabel.text isEqual:@"1 3"] && [numberStr isEqual:@"2"]) {
        //если уже 2 символа внесено, проверяем последовательность, если она правильная то вносим последний и переводим в состояние success
        NSMutableString *newString = [[NSMutableString alloc] initWithString:self.secureLabel.text];
        [newString appendString:@" "];
        [newString appendString: numberStr];
        self.secureLabel.text = newString;
        //отрисовываем границу success
        self.secureView.layer.borderColor = [[UIColor colorNamed:@"Turquoise Green"] CGColor];
        self.secureView.layer.borderWidth = 2;
        
        //вызов алерта
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome" message:@"You are successfuly authorized!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *refreshAction = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self preSet];
        }];
        [alert addAction:refreshAction];
        [self presentViewController:alert animated:YES completion:nil];

    } else {
        //если последний символ не подошел, или последовательность из 2х была неверная, то отрисовываем границу error
        self.secureView.layer.borderColor = [[UIColor colorNamed:@"Venetian Red"] CGColor];
        self.secureView.layer.borderWidth = 2;
        self.secureLabel.text = @"_";
    }
}

//Метод для обработки нажатия на кнопку (любое нажатие, в том числе без отпускания пальца)
-(void)buttonTouch:(UIButton *)button{
    //убираем подсветку
    [button setHighlighted:false];
    //проводим настройки прозрачности в момент нажатия
    button.backgroundColor =[[UIColor colorNamed:@"Little Boy Blue"] colorWithAlphaComponent:0.2];
    //проверка на вид кнопки, т.к. метод работает для всех кнопок на экране
    if ([button isEqual:_authorizeBT]){
        button.titleLabel.tintColor = [[UIColor colorNamed:@"Little Boy Blue"] colorWithAlphaComponent:0.4];
        [button setImage:[UIImage imageNamed:@"personFill"] forState:UIControlStateNormal];
    }
}

//Метод для обработки завершенного нажатия на кнопку авторизации
-(void)authButtonTapped:(id)button{
    //отключаем подсветку
    [self.authorizeBT setHighlighted:false];
    //восстанавливаем прежний цвет, после обычного нажатия (без отпускания пальца)
    self.authorizeBT.backgroundColor = UIColor.whiteColor;
    self.authorizeBT.titleLabel.tintColor = [UIColor colorNamed:@"Little Boy Blue"];
    [self.authorizeBT setImage:[UIImage imageNamed:@"person"] forState:UIControlStateNormal];
    //дополнительные переменные, для хранения успешного ввода в TextField
    BOOL loginFlag = true;
    BOOL passwordFlag = true;
    //проверяем данные введенные в TextField, и окрашиваем в соответствии с корректностью
    if (![_loginTF.text isEqual:login]){
        self.loginTF.layer.borderColor = [[UIColor colorNamed:@"Venetian Red"] CGColor];
        loginFlag = false;
    } else {
        self.loginTF.layer.borderColor = [[UIColor colorNamed:@"Turquoise Green"] CGColor];
    }
    if (![_passwordTF.text isEqual:password]){
        self.passwordTF.layer.borderColor = [[UIColor colorNamed:@"Venetian Red"] CGColor];
        passwordFlag = false;
    } else {
        self.passwordTF.layer.borderColor = [[UIColor colorNamed:@"Turquoise Green"] CGColor];
    }
    //если валидна информация в обой TextField, то дизэйблим кнопку и текстфилд, и активируем поле дополнительной проверки
    if (loginFlag && passwordFlag){
        [self hideKeyboard]; //скрываем клавиатуру в случае успеха (обновление ТЗ)
        [self.authorizeBT setEnabled:false];
        [self.authorizeBT setAlpha:0.5];
        [self.authorizeBT.imageView setTintColor:[UIColor colorNamed:@"Little Boy Blue"]];
        [self.loginTF setEnabled:false];
        [self.passwordTF setEnabled:false];
        [self.loginTF setAlpha:0.5];
        [self.passwordTF setAlpha:0.5];
        self.loginTF.layer.borderColor = [[UIColor colorNamed:@"Turquoise Green"] CGColor];
        self.passwordTF.layer.borderColor = [[UIColor colorNamed:@"Turquoise Green"] CGColor];
        self.secureView.hidden = false;
    }
}

//MARK: preSettings
//Метод для предварительнйо настройки View
-(void)preSet {
    //logo
    self.logo.font = [UIFont systemFontOfSize:36 weight: UIFontWeightBold];
    self.logo.textColor = UIColor.blackColor;
    //login
    self.loginTF.layer.cornerRadius = 5;
    self.loginTF.clipsToBounds = true;
    self.loginTF.layer.borderColor = [[UIColor colorNamed:@"Black Coral"] CGColor];
    self.loginTF.layer.borderWidth = 1.5;
    self.loginTF.text = @"";
    [self.loginTF setEnabled:true];
    [self.loginTF setAlpha:1];
    //password
    self.passwordTF.layer.cornerRadius = 5;
    self.passwordTF.clipsToBounds = true;
    self.passwordTF.layer.borderColor = [[UIColor colorNamed:@"Black Coral"] CGColor];
    self.passwordTF.layer.borderWidth = 1.5;
    self.passwordTF.text = @"";
    [self.passwordTF setEnabled:true];
    [self.passwordTF setAlpha:1];
    //authButton
    self.authorizeBT.layer.cornerRadius = 10;
    self.authorizeBT.layer.masksToBounds = true;
    self.authorizeBT.layer.borderWidth = 2;
    self.authorizeBT.layer.borderColor = [[UIColor colorNamed:@"Little Boy Blue"] CGColor];
    
    self.authorizeBT.titleLabel.font = [UIFont systemFontOfSize:20 weight: UIFontWeightSemibold];
    self.authorizeBT.titleLabel.tintColor = [UIColor colorNamed:@"Little Boy Blue"];
    self.authorizeBT.tintColor = [UIColor colorNamed:@"Little Boy Blue"];
    self.authorizeBT.titleEdgeInsets = UIEdgeInsetsMake(10, -5, 10, -20);
    self.authorizeBT.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    
    [self.authorizeBT setEnabled:true];
    [self.authorizeBT setAlpha:1];
    [self.authorizeBT.imageView setTintColor:[UIColor colorNamed:@"Little Boy Blue"]];
    [self.authorizeBT setTitleColor:[UIColor colorNamed:@"Little Boy Blue"] forState:UIControlStateDisabled];
    //secureButton
    [self preSetSecureButtons:self.secureBT1];
    [self preSetSecureButtons:self.secureBT2];
    [self preSetSecureButtons:self.secureBT3];
    //secureLabel
    self.secureLabel.font = [UIFont systemFontOfSize:18 weight: UIFontWeightSemibold];
    self.secureLabel.textColor = UIColor.blackColor;
    //secureView
    self.secureView.layer.borderWidth = 0;
    self.secureView.layer.cornerRadius = 10;
    self.secureView.layer.masksToBounds = true;
    self.secureLabel.text = @"_";
    
    self.secureView.hidden = true;
}

//метод для настройки кнопок дополнительной проверки (идентичны, сделал в отдельный метод)
-(void)preSetSecureButtons:(UIButton *)button {
    button.layer.cornerRadius = self.secureBT1.frame.size.width / 2;
    button.layer.masksToBounds = true;
    button.layer.borderColor = [[UIColor colorNamed:@"Little Boy Blue"] CGColor];
    button.layer.borderWidth = 1.5;
    button.titleLabel.font = [UIFont systemFontOfSize:24 weight: UIFontWeightSemibold];
    button.titleLabel.tintColor = [UIColor colorNamed:@"Little Boy Blue"];
}

//MARK: keyboardManagment
- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hideKeyboard {
    [self.view endEditing:true];
}

// MARK: - Delegates
// TextField Retrn метод для скрытия клавиатуры по нажатию return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:true];
    return true;
}

// TextField replacement Метод для проверки вводимой информации в поле login
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.loginTF]){
        //создаем characterSet только латинские буквы (в соответствии с ТЗ)
        NSCharacterSet *alphaSet = [NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"];
        BOOL valid = [[string stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
        return valid;
    } else {
        return true;
    }

}
//изменение оконтовки TextField когда начинаем в нем редактирование (на стандартный)
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.loginTF]){
        self.loginTF.layer.borderColor = [[UIColor colorNamed:@"Black Coral"] CGColor];
        self.loginTF.text = @"";
    }
    if ([textField isEqual:self.passwordTF]){
        self.passwordTF.layer.borderColor = [[UIColor colorNamed:@"Black Coral"] CGColor];
        self.passwordTF.text = @"";
    }
}
//изменение textField если нажимаем на него, для ввода информации
- (void)textFieldDidChangeSelection:(UITextField *)textField{
    if ([textField isEqual:self.loginTF]){
        self.loginTF.layer.borderColor = [[UIColor colorNamed:@"Black Coral"] CGColor];
    }
    if ([textField isEqual:self.passwordTF]){
        self.passwordTF.layer.borderColor = [[UIColor colorNamed:@"Black Coral"] CGColor];
    }
}


@end

