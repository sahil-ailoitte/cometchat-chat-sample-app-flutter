import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

///[ReactionExtension] is the controller class for enabling and disabling the extension
///it allows to insert emoji reactions on messages
class ReactionExtension extends ExtensionsDataSource {
  ReactionConfiguration? configuration;
  ReactionExtension({this.configuration});

  @override
  void addExtension() {
    ChatConfigurator.enable((dataSource) =>
        ReactionExtensionDecorator(dataSource, configuration: configuration));
  }

  @override
  String getExtensionId() {
    return "reactions";
  }
}
