# PayPasswordDemo
iOS仿支付宝密码支付

几个月前，有一个朋友问过我一个关于支付宝密码输入效果的问题，由于那段时间比较忙，没来得及去想这个问题，最近比较闲，比较闲，因为要过年了，而我还在上班中......上班，既然是上班，那就不能浪费自己的时间和青春哇。头脑一发热，就想来尝试做做这个效果，当然肯定还是有些不足地方，往各位多多指教，话不多说，先来谈谈思路吧。

######思路：
在支付宝输入密码的时候，如果你不仔细看的话，你就会认为，握草，不是很简单的一个`UITextField` 然后将属性`secureTextEntry`设置为`YES`就可以么，然并....也许这才是支付宝做的好的地方吧，居然在输入密码的时候，什么什么也看不到，哪怕是一个数字，也不会有一闪然后变成黑点的效果。那么，问题来了，我们该怎么实现呢，在静静思考十几分钟后，终于有一个大概方法，那就是在输入密码的`UITextField`上面加`view`，并且设置为黑色，造成一种假象，而`UITextField`还是和普通的输入一样，只是输入的内容和光标不能被用户所看到。

######上图


![paypassword.gif](http://upload-images.jianshu.io/upload_images/2525768-5cd1df41ccb51981.gif?imageMogr2/auto-orient/strip)


######上代码
`
问题一 ：如何解决用户看不到输入内容和光标
`
```
- (GLTextField *)passwordField
{
    if (nil == _passwordField)
    {
        _passwordField = [[GLTextField alloc] initWithFrame:CGRectMake((kScreenWidth - 44 * 6)/2.0, 100, 44 * 6, 44)];
        _passwordField.delegate = (id)self;
        _passwordField.backgroundColor = [UIColor whiteColor];
        //将密码的文字颜色和光标颜色设置为透明色
        //之前是设置的白色 这里有个问题 如果密码太长的话 文字和光标的位置如果到了第一个黑色的密码点的时候 就看出来了
        _passwordField.textColor = [UIColor clearColor];
        _passwordField.tintColor = [UIColor clearColor];
        [_passwordField setBorderColor:UIColorFromRGB(0xdddddd) width:1];
        _passwordField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordField.secureTextEntry = YES;
        [_passwordField addTarget:self action:@selector(passwordFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordField;
}
```
`
问题二 ：怎么做到输入密码的时候黑点显示或消失一致
`
```
- (void)passwordFieldDidChange:(UITextField *)field
{
    [self setDotsViewHidden];

    for (int i = 0; i < _passwordField.text.length; i ++)
    {
        if (_passwordDotsArray.count > i )
        {
            UIView *dotView = _passwordDotsArray[i];
            [dotView setHidden:NO];
        }
    }
    
    
    if (_passwordField.text.length == 6)
    {
        NSString *password = _passwordField.text;
        if ([password isEqualToString:_password])
        {
                NSLog(@" 打印信息  密码正确");
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"密码错误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            
            // Create the actions.
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                [self cleanPassword];
                
            }];
            
            // Add the actions.
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

//将所有的假密码点设置为隐藏状态
- (void)setDotsViewHidden
{
    for (UIView *view in _passwordDotsArray)
    {
        [view setHidden:YES];
    }
}

```

`
问题三：由于UITextField 是可以复制其内容的，怎么屏蔽呢？
`
这里我采取的方法是继承 `UITextField ` 然后重写方法
`- (BOOL)canPerformAction:(SEL)action withSender:(id)sender`

```
//禁止粘贴复制全选等
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

```

作为一个程序猿，我觉得思路很重要，有了好的思路，会少走很短弯路，如果有更好的方法，还望各位不吝赐教。


下面附上Demo
[iOS 仿支付宝密码支付Demo](https://github.com/gao211326/PayPasswordDemo)
