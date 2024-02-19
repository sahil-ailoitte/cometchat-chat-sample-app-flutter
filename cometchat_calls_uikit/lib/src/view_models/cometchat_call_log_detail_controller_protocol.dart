import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';

abstract class CometChatCallLogDetailProtocolController{
  int updateOption(String templateId, String oldOptionID,
      CometChatCallLogDetailsOption updatedOption);

  int removeOption(String templateId, String optionId);

  int addOption(String templateId, CometChatCallLogDetailsOption newOption,
      {int? position});

  useOption(CometChatCallLogDetailsOption _option, String sectionId);

  List<CometChatCallLogDetailsTemplate> getDetailsTemplateList();

  Map<String, List<CometChatCallLogDetailsOption>> getDetailsOptionMap();
}