<div style="width:100%">
<div style="width:100%">
	<div style="width:50%; display:inline-block">
		<p align="center">
		<img style="text-align:center" width="180" height="180" alt="" src="https://avatars2.githubusercontent.com/u/45484907?s=200&v=4">	
		</p>	
	</div>	
</div>
</br>
</br>
</div>

# CometChat Flutter Chat SDK

CometChat enables you to add voice, video & text chat for your website & app.
This guide demonstrates how to add chat to an Flutter application using CometChat.


<!-- [![Platform](https://img.shields.io/badge/Platform-Android-brightgreen)](#) -->
<!-- <a href=" "> <img src="https://img.shields.io/badge/Version-2.4.2-important" /></a> -->
<!-- ![GitHub repo size](https://img.shields.io/github/repo-size/cometchat-pro/android-chat-sdk) -->
<!-- ![GitHub contributors](https://img.shields.io/github/contributors/cometchat-pro/android-chat-sdk) -->
<!-- ![GitHub stars](https://img.shields.io/github/stars/cometchat-pro/android-chat-sdk?style=social) -->
<!-- ![Twitter Follow](https://img.shields.io/twitter/follow/cometchat?style=social) -->
<!-- <hr/> -->


## Prerequisites :star:
Before you begin, ensure you have met the following requirements:<br/>
 ✅ &nbsp; You have `Android Studio` or  `Xcode` installed in your machine.<br/>
 ✅ &nbsp; You have a `Android Device or Emulator` with Android Version 5.0 or above.<br/>
 ✅ &nbsp; You have a `IOS Device or Emulator` with IOS 11.0 or above.<br/>
 ✅ &nbsp; You have read [CometChat Key Concepts](https://www.cometchat.com/docs/flutter-chat-sdk/key-concepts).<br/>

<hr/>

## Installing CometChat Flutter SDK
## Setup :wrench:

To setup Fluter SDK, you  need to first register on CometChat Dashboard. [Click here to sign up](https://app.cometchat.com/login).

### i. Get your Application Keys :key:

<a href="https://app.cometchat.io" target="_blank">Signup for CometChat</a> and then:

1. Create a new app: Click **Add App** option available  →  Enter App Name & other information  → Create App
2. At the Top in **QuickStart** section you will find **Auth Key** & **App ID** or else you can head over to the **API & Auth Keys** section and note the **Auth Key** and **App ID**
<img align="center" src="https://files.readme.io/4b771c5-qs_copy.jpg"/>

<hr/>

### ii. Add the CometChat Dependency
<ul>
<li>
1. To use this plugin, add cometchat as a dependency in your pubspec.yaml file.<br/>
2. add the following code  to podfile inside IOS section of your app <br/>

post_install do |installer|<br/>
  installer.pods_project.targets.each do |target|<br/>
    flutter_additional_ios_build_settings(target)<br/>
    <COPY FROM HERE------------><br/>
    target.build_configurations.each do |build_configuration|<br/>
    build_configuration.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64 i386'<br/>
    build_configuration.build_settings['ENABLE_BITCODE'] = 'NO'
    end<br/>
    <COPY TILL HERE------------><br/>
  end<br/>
end<br/>


3. For IOS change ios deployment target to 11 or higher
4. For Ios navigate to your IOS folder in terminal or CMD and do `pod install` . For apple chip system use rositta terminal.<br/>
5. To import use
```dart
import 'package:cometchat_sdk/cometchat_sdk.dart';

```


</li>
</ul>
<hr/>

## Configure CometChat SDK

### i. Initialize CometChat 🌟
The init() method initializes the settings required for CometChat. We suggest calling the init() method on app startup, preferably in the init() method of the Home class.

```dart
import 'package:cometchat_sdk/cometchat_sdk.dart';


String appID = "APP_ID"; // Replace with your App ID
String region = "REGION"; // Replace with your App Region ("eu" or "us")

 AppSettings appSettings = (AppSettingsBuilder()
        ..subscriptionType = CometChatSubscriptionType.allUsers
        ..region= region
        ..autoEstablishSocketConnection =  true
    ).build();

    CometChat.init(appID, appSettings, onSuccess: (String successMessage) {
      debugPrint("Initialization completed successfully  $successMessage");
    }, onError: (CometChatException e) {
      debugPrint("Initialization failed with exception: ${e.message}");
    });
```

| :information_source: &nbsp; <b> Note - Make sure to replace `region` and `appID` with your credentials.</b> |
|------------------------------------------------------------------------------------------------------------|

### ii. Create User 👤
Once initialisation is successful, you will need to create a user. You need to user createUser() method to create user on the fly.
```dart
import 'package:cometchat_sdk/cometchat_sdk.dart';


String authKey = "AUTH_KEY"; // Replace with your App Auth Key
User user = User(uid: "usr1" , name: "Kevin"  );

CometChat.createUser(user,  authKey, onSuccess: (User user){
   debugPrint("Create User succesfull ${user}");

}, onError: (CometChatException e){
    debugPrint("Create User Failed with exception ${e.message}");
});

```

| :information_source: &nbsp; <b>Note -  Make sure that UID and name are specified as these are mandatory fields to create a user.</b> |
|------------------------------------------------------------------------------------------------------------|

<hr/>

### iii. Login User 👤
Once you have created the user successfully, you will need to log the user into CometChat using the login() method.
```dart
String UID = "user_id"; // Replace with the UID of the user to login
String authKey = "AUTH_KEY"; // Replace with your App Auth Key

final user = await CometChat.getLoggedInUser();
if (user == null) {
  await CometChat.login(UID, authKey,
                        onSuccess: (User user) {
                          debugPrint("Login Successful : $user" );
                        }, onError: (CometChatException e) {
                          debugPrint("Login failed with exception:  ${e.message}");
                        });
}else{
//Already logged in
}
```

| :information_source: &nbsp; <b>Note - The login() method needs to be called only once. Also replace AUTH_KEY with your App Auth Key.</b> |
|------------------------------------------------------------------------------------------------------------|

<hr/>

📝 Please refer to our [Developer Documentation](https://www.cometchat.com/docs/flutter-chat-sdk/overview) for more information on how to configure the CometChat Pro SDK and implement various features using the same.

<hr/>

## License

This project uses the following license: [LICENSE](https://www.cometchat.com/legal-terms-of-service).