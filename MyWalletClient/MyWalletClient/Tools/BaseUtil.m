//
//  BaseUtil.m
//  WashingStore
//
//  Created by yager on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseUtil.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation BaseUtil

+ (id)controllerInStoryboard:(NSString *)storyboard withIdentifier:(NSString *)identifier {
    return [[UIStoryboard storyboardWithName:storyboard bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:identifier];
}

+ (BOOL)isDeviceiPhone
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        return TRUE;
    }
    return FALSE;
}

+ (BOOL)isDeviceiPhone4
{
    if ([[UIScreen mainScreen] bounds].size.height==480)
        return TRUE;
    
    return FALSE;
}

+ (BOOL)isDeviceRetina
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0))        // Retina display
    {
        return TRUE;
    }
    else                                          // non-Retina display
    {
        return FALSE;
    }
}

+ (BOOL)isDeviceiPhone5
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height>480)
    {
        return TRUE;
    }
    return FALSE;
}

+ (void)testFileContent:(const char *) filename
{
    FILE *file = fopen(filename, "r");
    char word[100];
    while (fgets(word, 100, file)) {
        word[strlen(word)-1] = '\0';
        NSLog(@"%s is %zu char_long", word, strlen(word));
    }
    fclose(file);
}

+ (void)alertWithTitle:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:msg 
                                                   delegate:nil 
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:nil];
    [alert show];
}

+ (BOOL)emptyLocation:(CLLocation *)location
{
    if (!location) {
        return YES;
    }
    
    CLLocationCoordinate2D coord = location.coordinate;
    if (coord.latitude == -180.0 || coord.longitude == -180.0 || coord.latitude == 0.0 || coord.longitude == 0.0){
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isEmpty:(NSString*)str
{
    if (str == nil || [str length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isEmptyOrNull:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    string = [NSString stringWithFormat:@"%@",string];
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if([string isEqualToString:@"(null)"]){
        return YES;
    }
        
    return NO;
}

+ (BOOL)isNull:(NSObject *)obj {
    if (obj == nil) {
        return YES;
    }
    
    if (obj == NULL) {
        return YES;
    }
    
    if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isEmptyLoction:(NSString *)locInfo
{
    if ([BaseUtil isEmpty:locInfo]) {
        return YES;
    }
    
    if ([locInfo intValue] == 0) {
        return YES;
    }
    
    return NO;
}

+ (void)drawShadow:(UIView *)view shadowHeight:(CGFloat)height;
{
    //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
    UIColor *highColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    UIColor *lowColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.867 alpha:1.000];
    
    //The gradient, simply enough.  It is a rectangle
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setFrame:[view bounds]];
    [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[lowColor CGColor], nil]];
    
    //the rounded rect, with a corner radius of 6 points.
    //this *does* maskToBounds so that any sublayers are masked
    //this allows the gradient to appear to have rounded corners
    CALayer *roundRect = [CALayer layer];
    [roundRect setFrame:[view bounds]];
    [roundRect setCornerRadius:3.0f];
    [roundRect setMasksToBounds:YES];
    [roundRect addSublayer:gradient];
    
    //add the rounded rect layer underneath all other layers of the view
    [[view layer] insertSublayer:roundRect atIndex:0];
    
    //set the shadow on the view's layer
    [[view layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[view layer] setShadowOffset:CGSizeMake(0, height)];
    [[view layer] setShadowOpacity:1.0];
    [[view layer] setShadowRadius:3.0];
}

+ (void)drawShadow:(UIView *)view shadowHeight:(CGFloat)height cornerRadius:(CGFloat)radius
{
    //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
    UIColor *highColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    UIColor *lowColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.867 alpha:1.000];
    
    //The gradient, simply enough.  It is a rectangle
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setFrame:[view bounds]];
    [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[lowColor CGColor], nil]];
    
    //the rounded rect, with a corner radius of 6 points.
    //this *does* maskToBounds so that any sublayers are masked
    //this allows the gradient to appear to have rounded corners
    CALayer *roundRect = [CALayer layer];
    [roundRect setFrame:[view bounds]];
    [roundRect setCornerRadius:radius];
    [roundRect setMasksToBounds:YES];
    [roundRect addSublayer:gradient];
    
    //add the rounded rect layer underneath all other layers of the view
    [[view layer] insertSublayer:roundRect atIndex:0];
    
    //set the shadow on the view's layer
    [[view layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[view layer] setShadowOffset:CGSizeMake(0, height)];
    [[view layer] setShadowOpacity:1.0];
    [[view layer] setShadowRadius:radius];
}

//根据尺寸缩放
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//等比率缩放
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/////////////////////////////////////协议数据操作
+ (BOOL)removeCacheData
{
    NSString *userId = nil;
    if ([BaseUtil isEmpty:userId]) {
        userId = @"temp";
    }
    NSLog(@"userId : %@ -removeCacheData", userId);
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];  
    NSString *cachePath = [NSString stringWithFormat:@"%@/%@/%@", rootPath, @"protocl", userId];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL flag = [fileManager removeItemAtPath:cachePath error:&error];
    if (error) {
        NSLog(@"remove dir error:%@", [error domain]);
    }
    return flag;
}
+ (BOOL)removeCacheItem:(NSString *)protocolName
{
    NSString *userId = nil;
    if ([BaseUtil isEmpty:userId]) {
        userId = @"temp";
    }
    NSLog(@"userId : %@ - removeData, protoName = %@", userId, protocolName);
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];  
    NSString *cachePath = [NSString stringWithFormat:@"%@/%@/%@", rootPath, @"protocl", userId];
    NSString *protocolDataPath = [NSString stringWithFormat:@"%@/%@", cachePath, [NSString stringWithFormat:@"%@.dat", protocolName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL flag = [fileManager removeItemAtPath:protocolDataPath error:&error];
    if (error) {
        NSLog(@"remove dir error:%@", [error domain]);
    }
    return flag;
}
+ (BOOL)isExistProtocolData:(NSString *)protocolName
{
    NSString *userId = nil;
    if ([BaseUtil isEmpty:userId]) {
        userId = @"temp";
    }
    NSLog(@"userId : %@ - hasData, protoName = %@", userId, protocolName);
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];  
    NSString *cachePath = [NSString stringWithFormat:@"%@/%@/%@", rootPath, @"protocl", userId];
    NSString *protocolDataPath = [NSString stringWithFormat:@"%@/%@", cachePath, [NSString stringWithFormat:@"%@.dat", protocolName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:protocolDataPath];
}
+ (BOOL)saveProtocolData:(NSData *)data withName:(NSString *)protocolName
{
    NSString *userId = nil;
    if ([BaseUtil isEmpty:userId]) {
        userId = @"temp";
    }
    NSLog(@"userId : %@ - saveData, protoName = %@", userId, protocolName);
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];  
    NSString *cachePath = [NSString stringWithFormat:@"%@/%@/%@", rootPath, @"protocl", userId];
    NSString *protocolDataPath = [NSString stringWithFormat:@"%@/%@", cachePath, [NSString stringWithFormat:@"%@.dat", protocolName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"create dir error:%@", [error domain]);
    }
    //缓存服务器端协议
    return [data writeToFile:protocolDataPath atomically:YES];
}
+ (NSData *)readProtocolData:(NSString *)protocolName
{
    NSString *userId = nil;
    if ([BaseUtil isEmpty:userId]) {
        userId = @"temp";
    }
    NSLog(@"userId : %@ - getData, protoName = %@", userId, protocolName);
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];  
    NSString *cachePath = [NSString stringWithFormat:@"%@/%@/%@", rootPath, @"protocl", userId];
    NSString *protocolDataPath = [NSString stringWithFormat:@"%@/%@", cachePath, [NSString stringWithFormat:@"%@.dat", protocolName]];
    NSData *data = [NSData dataWithContentsOfFile:protocolDataPath];
    return data;
}
/////////////////////////////////////协议数据操作

// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)sanitizedPhoneNumberFromString:(NSString *)string {
    if (nil == string) {
        return nil;
    }
    
    NSCharacterSet* validCharacters =
    [NSCharacterSet characterSetWithCharactersInString:@"1234567890-+"];
    return [[string componentsSeparatedByCharactersInSet:[validCharacters invertedSet]]
            componentsJoinedByString:@""];
    
}
+ (BOOL)phoneWithNumber:(NSString *)phoneNumber {
    phoneNumber = [self sanitizedPhoneNumberFromString:phoneNumber];
    
    if (nil == phoneNumber) {
        phoneNumber = @"";
    }
    
    NSString* urlPath = [@"tel:" stringByAppendingString:phoneNumber];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

+ (void)callAndBack:(NSString *)phoneNum { 
//    NSString *phoneNum = @"10086";// 电话号码
    
    //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
    //NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",phoneNum]; 
    
    //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",phoneNum]; 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}

+ (void)callAndBackWeb:(NSString *)phoneNum
{
//    NSString *phoneNum = @"10086";// 电话号码    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];  
    
    UIWebView *phoneCallWebView = nil;
    if (!phoneCallWebView) {
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        // 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    } 
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];    
}


+ (NSString *)timesFrom:(NSString *)createTime;
{
    if ([BaseUtil isEmpty:createTime] || [createTime length] < 15) {
        return @"未知";
    }
    
    return [NSString stringWithFormat:@"%@", [BaseUtil intervalSinceNow:createTime]];
}

//计算时间间隔
+ (NSString *)intervalSinceNow:(NSString *)theDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *theDate = [dateFormatter dateFromString:theDateStr];
    
    NSTimeInterval theInterval = [theDate timeIntervalSince1970];
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    
    NSString *timeString = @"";
    NSTimeInterval interval = nowInterval - theInterval;
    if (interval/3600 < 1) {
        timeString = [NSString stringWithFormat:@"%.0f分钟前", interval/60];
    }
    if (interval/3600 > 1 && interval/86400 < 1) {
        timeString = [NSString stringWithFormat:@"%.0f小时前", interval/3600];
    }
    if (interval/86400 > 1) {
        timeString = [NSString stringWithFormat:@"%.0f天前", interval/86400];
    }
    
    return timeString;
}


//获得通讯录中联系人的所有属性
- (void)getContactsNew {
    NSMutableString *text = [[NSMutableString alloc] initWithCapacity:10];
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for(int i = 0; i < CFArrayGetCount(results); i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        //读取firstname
        NSString *personName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if(personName != nil)
            [text stringByAppendingFormat:@"n姓名：%@n", personName];
        //读取lastname
        NSString *lastname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if(lastname != nil)
            [text stringByAppendingFormat:@"%@n",lastname];
        //读取middlename
        NSString *middlename = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
        if(middlename != nil)
            [text stringByAppendingFormat:@"%@n",middlename];
        //读取prefix前缀
        NSString *prefix = (__bridge NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
        if(prefix != nil)
            [text stringByAppendingFormat:@"%@n",prefix];
        //读取suffix后缀
        NSString *suffix = (__bridge NSString*)ABRecordCopyValue(person, kABPersonSuffixProperty);
        if(suffix != nil)
            [text stringByAppendingFormat:@"%@n",suffix];
        //读取nickname呢称
        NSString *nickname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
        if(nickname != nil)
            [text stringByAppendingFormat:@"%@n",nickname];
        //读取firstname拼音音标
        NSString *firstnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
        if(firstnamePhonetic != nil)
            [text stringByAppendingFormat:@"%@n",firstnamePhonetic];
        //读取lastname拼音音标
        NSString *lastnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
        if(lastnamePhonetic != nil)
            [text stringByAppendingFormat:@"%@n",lastnamePhonetic];
        //读取middlename拼音音标
        NSString *middlenamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
        if(middlenamePhonetic != nil)
            [text stringByAppendingFormat:@"%@n",middlenamePhonetic];
        //读取organization公司
        NSString *organization = (__bridge NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
        if(organization != nil)
            [text stringByAppendingFormat:@"%@n",organization];
        //读取jobtitle工作
        NSString *jobtitle = (__bridge NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
        if(jobtitle != nil)
            [text stringByAppendingFormat:@"%@n",jobtitle];
        //读取department部门
        NSString *department = (__bridge NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
        if(department != nil)
            [text stringByAppendingFormat:@"%@n",department];
        //读取birthday生日
        NSDate *birthday = (__bridge NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
        if(birthday != nil)
            [text stringByAppendingFormat:@"%@n",birthday];
        //读取note备忘录
        NSString *note = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
        if(note != nil)
            [text stringByAppendingFormat:@"%@n",note];
        //第一次添加该条记录的时间
        NSString *firstknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
        NSLog(@"第一次添加该条记录的时间%@n",firstknow);
        //最后一次修改該条记录的时间
        NSString *lastknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
        NSLog(@"最后一次修改該条记录的时间%@n",lastknow);
        
        //获取email多值
        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
        int emailcount = ABMultiValueGetCount(email);
        for (int x = 0; x < emailcount; x++) {
            //获取email Label
            NSString* emailLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
            //获取email值
            NSString* emailContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(email, x);
            [text stringByAppendingFormat:@"%@:%@n",emailLabel,emailContent];
        }
        //读取地址多值
        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
        int count = ABMultiValueGetCount(address);
        
        for(int j = 0; j < count; j++) {
            //获取地址Label
            NSString* addressLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(address, j);
            [text stringByAppendingFormat:@"%@n",addressLabel];
            //获取該label下的地址6属性
            NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
            NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
            if(country != nil)
                [text stringByAppendingFormat:@"国家：%@n",country];
            NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
            if(city != nil)
                [text stringByAppendingFormat:@"城市：%@n",city];
            NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
            if(state != nil)
                [text stringByAppendingFormat:@"省：%@n",state];
            NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
            if(street != nil)
                [text stringByAppendingFormat:@"街道：%@n",street];
            NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
            if(zip != nil)
                [text stringByAppendingFormat:@"邮编：%@n",zip];
            NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
            if(coutntrycode != nil)
                [text stringByAppendingFormat:@"国家编号：%@n",coutntrycode];
        }
        
        //获取dates多值
        ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
        int datescount = ABMultiValueGetCount(dates);
        for (int y = 0; y < datescount; y++) {
            //获取dates Label
            NSString* datesLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
            //获取dates值
            NSString* datesContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(dates, y);
            [text stringByAppendingFormat:@"%@:%@n",datesLabel,datesContent];
        }
        //获取kind值
        CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
        if (recordType == kABPersonKindOrganization) {
            // it's a company
            NSLog(@"it's a companyn");
        } else {
            // it's a person, resource, or room
            NSLog(@"it's a person, resource, or roomn");
        }
        
        
        //获取IM多值
        ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
        for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++) {
            //获取IM Label
            NSString* instantMessageLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
            [text stringByAppendingFormat:@"%@n",instantMessageLabel];
            //获取該label下的2属性
            NSDictionary* instantMessageContent =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
            NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
            if(username != nil)
                [text stringByAppendingFormat:@"username：%@n",username];
            
            NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
            if(service != nil)
                [text stringByAppendingFormat:@"service：%@n",service];
        }
        
        //读取电话多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++) {
            //获取电话Label
            NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
            //获取該Label下的电话值
            NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            
            [text stringByAppendingFormat:@"%@:%@n",personPhoneLabel,personPhone];
        }
        
        //获取URL多值
        ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
        for (int m = 0; m < ABMultiValueGetCount(url); m++) {
            //获取电话Label
            NSString * urlLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));
            //获取該Label下的电话值
            NSString * urlContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(url,m);
            
            [text stringByAppendingFormat:@"%@:%@n",urlLabel,urlContent];
        }
        
        //读取照片
        //        NSData *image = (__bridge NSData*)ABPersonCopyImageData(person);
        //        UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
        //        [myImage setImage:[UIImage imageWithData:image]];
        //        myImage.opaque = YES;
        //        [textView addSubview:myImage];
    }
    
    CFRelease(results);
    CFRelease(addressBook);
}

- (void)getContacts {
    ABAddressBookRef addressBook = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        
        //等待同意后向下执行
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    } else {
        addressBook = ABAddressBookCreate();
    }
    
    NSArray *personArray = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    for (int n = 0; n < [personArray count]; n++) {
        ABRecordRef people = (__bridge ABRecordRef)[personArray objectAtIndex:n];
        ABMultiValueRef phones = (ABMultiValueRef)ABRecordCopyValue(people, kABPersonPhoneProperty);
        
        int nCount = ABMultiValueGetCount(phones);
        for (int i = 0; i < nCount; i++) {
            NSString *phoneLabel = (__bridge NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
            NSString *phoneNumber = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones, i);
            NSLog(@"name = %@, num = %@", phoneLabel, phoneNumber);
        }
    }
}

+ (void)getAllPictures
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror) {
            NSLog(@"相册访问失败 = %@", [myerror localizedDescription]);
            
            if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location != NSNotFound) {
                NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
            } else {
                NSLog(@"相册访问失败.");
            }
        };
        
        ALAssetsGroupEnumerationResultsBlock groupEnumeration = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result != NULL) {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    
                    NSString *urlstr = [result.defaultRepresentation.url description];
                    NSLog(@"urlstr == %@, index = %d", urlstr, index); //图片的url
                    
                    //NSRange range1 = [urlstr rangeOfString:@"id="];
                    //NSString *resultName = [urlstr substringFromIndex:range1.location+3];
                    //resultName = [resultName stringByReplacingOccurrencesOfString:@"&ext=" withString:@"."]; //格式demo:123456.png
                    //NSLog(@"imgName == %@", resultName); //图片名称
                    
                    //CGImageRef fullImageRef = result.defaultRepresentation.fullScreenImage;//图片的大图
                    //CGImageRef thumbImageRef = result.thumbnail;  //图片的缩略图小图
                    //UIImage *img = [UIImage imageWithCGImage:fullImageRef];
                    //UIImage *thumbImg = [UIImage imageWithCGImage:thumbImageRef];
                    
                    //可以通过valueForProperty获取到图片的信息，包括:类型, Location, 时长, 方向, 日期, 格式, URL地址。
                    //                    NSString *nsType = [result valueForProperty:ALAssetPropertyType];
                    //                    NSString *nsDate = [result valueForProperty:ALAssetPropertyDate];
                    //                    NSString *nsURLs = [result valueForProperty:ALAssetPropertyURLs];
                    //                    NSString *nsLocation = [result valueForProperty:ALAssetPropertyLocation];
                    //                    NSString *nsOrientation = [result valueForProperty:ALAssetPropertyOrientation];
                    //                    NSString *nsRepresentations = [result valueForProperty:ALAssetPropertyRepresentations];
                    //                    NSString *nsAssetURL = [result valueForProperty:ALAssetPropertyAssetURL];
                    //
                    //                    NSLog(@"nsType = %@", nsType);
                    //                    NSLog(@"nsDate = %@", nsDate);
                    //                    NSLog(@"nsURLs = %@", nsURLs);
                    //                    NSLog(@"nsLocation = %@", nsLocation);
                    //                    NSLog(@"nsOrientation = %@", nsOrientation);
                    //                    NSLog(@"nsRepresentations = %@", nsRepresentations);
                    //                    NSLog(@"nsAssetURL = %@", nsAssetURL);
                }
            }
        };
        
        ALAssetsLibraryGroupsEnumerationResultsBlock libraryGroupsEnumeration = ^(ALAssetsGroup* group, BOOL* stop) {
            if (group != nil ) {
                NSString *groupInfo = [NSString stringWithFormat:@"%@", group];//获取相簿的组
                NSLog(@"groupInfo:%@", groupInfo); //groupInfo:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
                [group enumerateAssetsUsingBlock:groupEnumeration];
            }
        };
        
        //------------------------开始遍历手机中的相册获取图片－－－－－
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library enumerateGroupsWithTypes:ALAssetsGroupAll  //ALAssetsGroupSavedPhotos
                               usingBlock:libraryGroupsEnumeration
                             failureBlock:failureblock];
        
        //------------------------根据图片的url反取图片－－－－－
        [library assetForURL:[NSURL URLWithString:@"assets-library://asset/asset.JPG?id=2D149428-F2E4-4202-B244-F6F9AACE5B43&ext=JPG"]
                 resultBlock:^(ALAsset *asset) {
                     UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
                     NSLog(@"image.size = %@", NSStringFromCGSize(image.size));
                 }
                failureBlock:^(NSError *error) {
                    NSLog(@"error = %@",error);
                }
         ];
        
    });
    
}

//获取UUID
+ (NSString *)appleIFV {
    if(NSClassFromString(@"UIDevice") && [UIDevice instancesRespondToSelector:@selector(identifierForVendor)]) {
        // only available in iOS >= 6.0
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return nil;
}
//获取星期
+(NSString*)dateStringFromDate:(NSString*)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *inputDate = [formatter dateFromString:dateString];
    if (inputDate==nil) {
        return @"";
    }
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], NSLocalizedString(@"星期日", nil), NSLocalizedString(@"星期一",nil), NSLocalizedString(@"星期二",nil),NSLocalizedString(@"星期三", nil) ,NSLocalizedString(@"星期四",nil), NSLocalizedString(@"星期五",nil), NSLocalizedString(@"星期六",nil), nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
    [calendar getHour:&hour minute:&minute second:&second nanosecond:nil fromDate:inputDate];

    //昨天
    if ([calendar isDateInYesterday:inputDate]) {
                    NSString *result = [NSString stringWithFormat:NSLocalizedString(@"昨天 %02tu:%02tu", nil),hour,minute];
        //        NSLog(@"%@",result);
        return result;
    }
    //今天
    if ([calendar isDateInToday:inputDate]) {
        
        NSString *result = [NSString stringWithFormat:@"%02tu:%02tu",hour,minute];
        NSLog(@"%@",result);
        return result;
    }
    //一周内显示星期 以前用日期
    NSTimeInterval interval = [inputDate timeIntervalSinceNow]*(-1);
    
    if (interval>7*24*60*60) {
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
        [formatter2 setDateFormat:@"yyyy/MM/dd HH:mm"];
        NSString *result = [formatter2 stringFromDate:inputDate];
        return result;
    }else{
        //前天
        //当前时间转秒
        NSInteger currentHour;
        NSInteger currentMinute;
        NSInteger currentSecond;
        [calendar getHour:&currentHour minute:&currentMinute second:&currentSecond nanosecond:nil fromDate:[NSDate date]];
        NSTimeInterval lefSecond = currentHour*60*60+currentMinute*60+currentSecond;
        if (interval<(2*24*60*60+lefSecond) && interval>24*60*60) {
            NSString *result = [NSString stringWithFormat:@"前天 %02tu:%02tu",hour,minute];
            NSLog(@"%@",result);
            return result;
        }else{
            return [NSString stringWithFormat:@"%@ %02tu:%02tu",[weekdays objectAtIndex:theComponents.weekday],hour,minute];
  
        }
    }
}
+(UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 *设备别名
 */
+(NSString *)deviceName{
    NSString* userPhoneName = [[UIDevice currentDevice] name];
//    NSLog(@"手机别名: %@", userPhoneName);
    return userPhoneName;
}
/**
 *app 版本号
 */
+(NSString *)appVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSLog(@"当前应用软件版本:%@",appCurVersion);
    return appCurVersion;

}
/**
 *系统版本
 */
+(NSString *)deviceVersion{
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    NSLog(@"手机系统版本: %@", phoneVersion);
    return phoneVersion;
}
/**
 *
 */
+(NSInteger)getCountOfCharater:(NSString *)charater InString:(NSString *)searchString{

    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:charater options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:searchString options:0 range:NSMakeRange(0, [searchString length])];
    return numberOfMatches;
}
+(NSString *)ret32bitString{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

@end
