import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as user;
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_flutter_sample_app/utils/custom_colors.dart';
import 'package:cometchat_flutter_sample_app/utils/strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMessageEnabled = false;
  final TextEditingController _messageController = TextEditingController();

  @override
  void didChangeDependencies() {
    // loginUser('SUPERHERO1', context);
    super.didChangeDependencies();
  }

  loginUser(String userId, BuildContext context) async {
    // Alert.showLoadingIndicatorDialog(context);
    user.User? _user = await user.CometChat.getLoggedInUser();

    try {
      if (_user != null) {
        if (_user.uid == userId) {
          // Navigator.of(context).pop();

          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const Dashboard()));
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
      Navigator.of(context).pop();
      _user = loggedInUser;
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }, onError: (CometChatException e) {
      Navigator.of(context).pop();
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
      length: 2,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // leading: const SizedBox.shrink(),
              titleSpacing: 0.0,
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
                    text: 'CALLS',
                  ),
                  Tab(
                    text: 'CALLS',
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: [
                CometChatUsersWithMessages(
                  usersConfiguration: UsersConfiguration(
                      hideAppbar: true,
                      hideSearch: true,
                      hideSeparator: true,
                      showBackButton: false,
                      title: '',
                      hideSectionSeparator: true),
                  messageConfiguration: MessageConfiguration(
                      // messageComposerConfiguration:
                      //     MessageComposerConfiguration(
                      //         placeholderText: 'Message')
                      messageComposerView:
                          (User? user, Group? group, BuildContext context) {
                    return SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 23),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    controller: _messageController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Message',
                                        hintStyle: TextStyle(
                                            color:
                                                CustomColors.textMessageColor)),
                                  )),
                                  const Icon(Icons.image),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          InkWell(
                            onTap: _onMessageSend,
                            child: const CircleAvatar(
                              radius: 25,
                              backgroundColor: CustomColors.mikeColor,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
                CometChatCallLogs(
                  title: '',
                  callLogsStyle:
                      CallLogsStyle(titleStyle: TextStyle(height: 0)),
                  showBackButton: false,
                )
              ],
            )),
      ),
    );
  }

  void _onMessageSend() {
    if (_messageController.text.isEmpty) {
      //show toast here
    } else {}
  }
}
