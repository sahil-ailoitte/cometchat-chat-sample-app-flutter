

import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

abstract class CometChatGroupMembersControllerProtocol extends  CometChatSearchListControllerProtocol<GroupMember>{
  //default functions
  List<CometChatOption> defaultFunction(Group group, GroupMember member) ;

}