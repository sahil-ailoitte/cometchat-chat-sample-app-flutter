

import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

abstract class CometChatDetailsControllerProtocol{
  int updateOption(String templateId, String oldOptionID,
      CometChatDetailsOption updatedOption) ;

  int removeOption(String templateId, String optionId) ;

  int addOption(String templateId, CometChatDetailsOption newOption,
      {int? position});

  useOption(CometChatDetailsOption _option, String sectionId);

  onAddMemberClicked(Group group) ;

  onTransferOwnershipClicked(Group group) ;

  onBanMemberClicked(Group group) ;

  onViewMemberClicked(Group group) ;

  List<CometChatDetailsTemplate> getDetailsTemplateList();

  Map<String, List<CometChatDetailsOption>> getDetailsOptionMap();
}