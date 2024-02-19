
import 'package:flutter/material.dart';

import '../../../cometchat_uikit_shared.dart';

///[CometChatGroupMemberOption] is a model class which contains information about options available to execute for every [GroupMember]
///
/// ```dart
///
/// CometChatGroupMemberOption groupMemberOption = CometChatGroupMemberOption(
///   id: '1',
///   title: 'View Profile',
///   icon: 'https://example.com/icon.png',
///   packageName: 'com.example.package',
///   backgroundColor: Colors.white,
///   titleStyle: TextStyle(color: Colors.black),
///   onClick: (group, member, state) {
///     print('Clicked on group member: ${member.name}');
///   }
/// );
///
/// ```
class CometChatGroupMemberOption extends CometChatBaseOptions {
  ///[onClick] call function which takes 2 parameters
  Function(Group group, GroupMember member,
      CometChatGroupMembersControllerProtocol state)? onClick;

  CometChatGroupMemberOption(
      {this.onClick,
      required String id,
      String? title,
      String? icon,
      String? packageName,
      Color? backgroundColor,
      TextStyle? titleStyle})
      : super(
            id: id,
            icon: icon,
            packageName: packageName,
            title: title,
            titleStyle: titleStyle,
            backgroundColor: backgroundColor);
}
