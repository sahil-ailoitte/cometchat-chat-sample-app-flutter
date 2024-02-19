import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:get/get.dart';

class CometChatCallLogsWithDetailsController extends GetxController {
  CometChatCallLogsWithDetailsController();
  User? loggedInUser;

  @override
  void onInit() {
    initializeLoggedInUser();
    super.onInit();
  }

  initializeLoggedInUser() async {
    loggedInUser = await CometChat.getLoggedInUser();
    update();
  }
}
