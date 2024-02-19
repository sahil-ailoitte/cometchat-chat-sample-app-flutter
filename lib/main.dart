import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_flutter_sample_app/firebase_options.dart';
import 'package:cometchat_flutter_sample_app/home_screen.dart';
import 'package:cometchat_flutter_sample_app/login.dart';
import 'package:cometchat_flutter_sample_app/utils/constants.dart';
import 'package:cometchat_flutter_sample_app/utils/demo_meta_info_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  makeUISettings();
  runApp(const MyApp());
}

void makeUISettings() {
  UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
        ..subscriptionType = CometChatSubscriptionType.allUsers
        ..region = CometChatConstants.region
        ..autoEstablishSocketConnection = true
        ..appId = CometChatConstants.appId
        ..authKey = CometChatConstants.authKey
        ..callingExtension = CometChatCallingExtension()
        ..extensions = CometChatUIKitChatExtensions.getDefaultExtensions()
        ..aiFeature = [
          AISmartRepliesExtension(),
          AIConversationStarterExtension(),
          AIAssistBotExtension(),
          AIConversationSummaryExtension()
        ])
      .build();

  CometChatUIKit.init(
    uiKitSettings: uiKitSettings,
    onSuccess: (successMessage) {
      try {
        CometChat.setDemoMetaInfo(jsonObject: {
          "name": DemoMetaInfoConstants.name,
          "type": DemoMetaInfoConstants.type,
          "version": DemoMetaInfoConstants.version,
          "bundle": DemoMetaInfoConstants.bundle,
          "platform": DemoMetaInfoConstants.platform,
        });
      } catch (e) {
        if (kDebugMode) {
          debugPrint("setDemoMetaInfo ended with error");
        }
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CometChat sample app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffeeeeee),
        primarySwatch: Colors.blue,
      ),
      home: Login(
        key: CallNavigationContext.navigatorKey,
      ),
    );
  }
}
