import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart' as user;
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_flutter_sample_app/login.dart';
import 'package:cometchat_flutter_sample_app/utils/custom_colors.dart';
import 'package:cometchat_flutter_sample_app/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final bool hasLogin;

  const HomeScreen({this.hasLogin = false, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMessageEnabled = false;
  final TextEditingController _messageController = TextEditingController();

  final ValueNotifier<bool> _notifier = ValueNotifier<bool>(false);

  /*@override
  void didChangeDependencies() {
    if (widget.hasLogin) {
      loginUser(auth.FirebaseAuth.instance.currentUser!.uid ?? '', context);
    }

    super.didChangeDependencies();
  }*/

  loginUser(String userId, BuildContext context) async {
    await CometChatUIKit.login(userId, onSuccess: (user.User loggedInUser) {
      debugPrint("Login Successful from UI : $loggedInUser");
      // Navigator.of(context).pop();
      // _user = loggedInUser;
      _notifier.value = true;
    }, onError: (CometChatException e) {
      // Navigator.of(context).pop();
      debugPrint("Login failed with exception:  ${e.message}");
    });
  }

  @override
  void initState() {
    loginUser(auth.FirebaseAuth.instance.currentUser!.uid ?? '', context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 15,
            centerTitle: false,
            backgroundColor: CustomColors.primaryColor,
            title: Text(
              Strings.appName,
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.white,
              tabs: const [
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
            actions: [
              PopupMenuButton(
                iconColor: Colors.white,
                offset: const Offset(-10, 40),
                itemBuilder: (_) {
                  return [
                    PopupMenuItem(
                      height: 30,
                      onTap: _onLogout,
                      child: const SizedBox(
                        width: 100,
                        child: Text('Logout'),
                      ),
                    )
                  ];
                },
                constraints: const BoxConstraints(maxHeight: 50),
              ),
              const SizedBox(width: 10)
            ],
          ),
          body: ValueListenableBuilder(
            valueListenable: _notifier,
            builder: (context, bool hasLoggedIn, child) {
              if (!hasLoggedIn) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return TabBarView(
                children: [
                  const CometChatUsersWithMessages(
                    usersConfiguration: UsersConfiguration(
                      hideAppbar: true,
                      hideSearch: true,
                      hideSeparator: false,
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
                  const CometChatGroupsWithMessages(
                    groupsConfiguration: GroupsConfiguration(hideSearch: true),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onLogout() {
    auth.FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return const Login();
    }));
  }

  void _onMessageSend() {
    if (_messageController.text.isEmpty) {
      //show toast here
    } else {}
  }
}
