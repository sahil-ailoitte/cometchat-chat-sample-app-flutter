import '../Exception/CometChatException.dart';
import '../models/user.dart';

import 'message_listener.dart';

abstract class LoginListener implements EventHandler{
   void loginSuccess(User user) {}
   void loginFailure(CometChatException e) {}
   void logoutSuccess() {}
   void logoutFailure(CometChatException e) {}
}