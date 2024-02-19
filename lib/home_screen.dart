import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as user;
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_flutter_sample_app/utils/custom_colors.dart';
import 'package:cometchat_flutter_sample_app/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool hasLogin;

  const HomeScreen({this.hasLogin = false, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMessageEnabled = false;
  final TextEditingController _messageController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (widget.hasLogin) {
      loginUser(auth.FirebaseAuth.instance.currentUser!.uid ?? '', context);
    }

    super.didChangeDependencies();
  }

  loginUser(String userId, BuildContext context) async {
    // Alert.showLoadingIndicatorDialog(context);
    user.User? _user = await user.CometChat.getLoggedInUser();

    try {
      if (_user != null) {
        if (_user.uid == userId) {
          return;
        } else {
          await user.CometChat.logout(
              onSuccess: (_) {},
              onError:
                  (_) {}); //if logging in user is different from logged in user
        }
      }
    } catch (_) {}

    await CometChatUIKit.login(userId, onSuccess: (user.User loggedInUser) {
      debugPrint("Login Successful from UI : $loggedInUser");
      // Navigator.of(context).pop();
      _user = loggedInUser;
    }, onError: (CometChatException e) {
      // Navigator.of(context).pop();
      debugPrint("Login failed with exception:  ${e.message}");
    });

    // await CometChat.login(userId, CometChatConstants.authKey,
    //     onSuccess: (User loggedInUser) {
    //   debugPrint("Login Successful : $loggedInUser");
    //   Navigator.of(context).pop();
    //   _user = loggedInUser;
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const Dashboard()));
    // }, onError: (CometChatException e) {
    //   Navigator.of(context).pop();
    //   debugPrint("Login failed with exception:  ${e.message}");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // leading: const SizedBox.shrink(),
            titleSpacing: 10,
            centerTitle: false,
            backgroundColor: CustomColors.whatsappColor,
            title: const Text(
              Strings.appName,
              style: TextStyle(color: Colors.white),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Chats',
                ),
                Tab(
                  text: 'Calls',
                ),
                Tab(
                  text: 'Groups',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const CometChatUsersWithMessages(
                usersConfiguration: UsersConfiguration(
                  hideAppbar: true,
                  hideSearch: true,
                  hideSeparator: true,
                  showBackButton: false,
                  title: 'Test',
                  hideSectionSeparator: true,
                ),
                messageConfiguration: MessageConfiguration(
                    // messageComposerConfiguration:
                    //     MessageComposerConfiguration(
                    //         placeholderText: 'Message')
                    // messageComposerView:
                    //     (User? user, Group? group, BuildContext context) {
                    //   return SizedBox(
                    //     height: 60,
                    //     child: Row(
                    //       children: [
                    //         const SizedBox(
                    //           width: 12,
                    //         ),
                    //         Expanded(
                    //           child: Container(
                    //             padding:
                    //                 const EdgeInsets.symmetric(horizontal: 23),
                    //             decoration: BoxDecoration(
                    //                 color: Colors.white,
                    //                 borderRadius: BorderRadius.circular(25)),
                    //             child: Row(
                    //               children: [
                    //                 Expanded(
                    //                     child: TextField(
                    //                   controller: _messageController,
                    //                   decoration: const InputDecoration(
                    //                       border: InputBorder.none,
                    //                       hintText: 'Message',
                    //                       hintStyle: TextStyle(
                    //                           color:
                    //                               CustomColors.textMessageColor)),
                    //                 )),
                    //                 const Icon(Icons.image),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           width: 14,
                    //         ),
                    //         InkWell(
                    //           onTap: _onMessageSend,
                    //           child: const CircleAvatar(
                    //             radius: 25,
                    //             backgroundColor: CustomColors.mikeColor,
                    //             child: Icon(
                    //               Icons.send,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   );
                    // },
                    ),
              ),
              CometChatCallLogs(
                title: '',
                callLogsStyle:
                    CallLogsStyle(titleStyle: const TextStyle(height: 0)),
                showBackButton: false,
              ),
              const CometChatGroupsWithMessages(),
            ],
          ),
        ),
      ),
    );
  }

  void _onMessageSend() {
    if (_messageController.text.isEmpty) {
      //show toast here
    } else {}
  }
}
