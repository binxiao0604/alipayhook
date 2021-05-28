#import <UIKit/UIKit.h>

%hook AAAPBootStartPoint

+ (void)load {
//    %log; 干掉sysctl调用逻辑
}

%end


%hook ALUAccuratePWDView

- (void)onNext {
    NSLog(@"\n\n\n🍉🍉🍉🍉🍉🍉🍉\n\n\n");
    UIView *loginBox = MSHookIvar<UIView*>(self,"_loginBox");
    //账户
    //self-> _labelLoginID
    UILabel *labelLoginID = MSHookIvar<UILabel *>(self,"_labelLoginID");
    NSString *accountStr = labelLoginID.text;
    NSLog(@"账户：%@",accountStr);
    //密码
    //self -> _loginBox -> _passwordInputBox->_textField
    UIView *passwordInputBox = MSHookIvar<UIView *>(loginBox,"_passwordInputBox");
    UITextField *pwdTextField = MSHookIvar<UITextField *>(passwordInputBox,"_textField");
    NSString *pwdStr = pwdTextField.text;
    NSLog(@"密码：%@",pwdStr);
    NSLog(@"\n\n\n🍉🍉🍉🍉🍉🍉🍉\n\n\n");
    //调用原始登录
    %orig;
}

%end

%hook FHAssetsHeaderV5DataModel

- (NSString *)totalYesterdayProfitView {
    NSLog(@"%@",%orig);
    return @"333,333.33";
}

- (NSString *)latestTotalView {
    NSLog(@"%@",%orig);
    return @"9,999,999,999.99";
}

%end


