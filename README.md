# Beacon-Passbook-iOS
显示如何添加一个使用iBeacon的Passbook，并在界面上显示此Passbook。

## Passbook生成

与普通的Passbook生成相似，Passbook生成相关内容参照[Passbook Programming Guide](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/PassKit_PG/Chapters/Introduction.html)

在生成Passbook用的pass.json文件中，加入下面的Beacon相关项。

```
"beacons" : [
  {
    "major" : 8,
    "minor" : 8,
    "proximityUUID" : "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0",
    "relevantText" : "this is beacon tests,it must be successfull!!"
  }
  ],

```

一个Passbook可以与多个beacon相关联。Major和Minor项可以忽略，在忽略时，只要没有忽略的项匹配即可显示相应的Passbook。

##Passbook添加

使用PassKit进行添加。下面为OC代码

```
    NSURL * passPath = [[NSBundle mainBundle] URLForResource:@"Generic" withExtension:@"pkpass"];
    
    NSError * error = nil;
    NSData * passData = [NSData dataWithContentsOfURL:passPath options:0 error:&error];
    
    PKPass* pkPass = [[PKPass alloc] initWithData:passData error:&error];
    PKPassLibrary * passLibrary = [[PKPassLibrary alloc] init];
    
    BOOL contained = [passLibrary containsPass:pkPass];
    
    if (contained == NO) {
        PKAddPassesViewController *vc = [[PKAddPassesViewController alloc] initWithPass:pkPass];
        if (vc) {
            [vc setDelegate:self];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }else{
        [[UIApplication sharedApplication] openURL:[pkPass passURL]];
    }

```

##实验

1. 在App中点击添加，把相应的Passbook添加到系统中，是否添加成功可以通过自带的Passbook App来查看。
2. 配置云子，在其他手机打开配置工具，或者把App中的二维码保存到相册中。找到需要配置的云子，在云子配置页面，使用“扫一扫配置”读取二维码，然后点击保存，云子配置成功。
3. 在配置好的云子附近，关闭屏幕，然后使用开关键电量屏幕，此时屏幕中会显示刚刚添加的Passbook的尖端提示。
4. 在提示上划过后，在不解锁屏幕的情况下，可以显示Passbook，方便用户使用。
