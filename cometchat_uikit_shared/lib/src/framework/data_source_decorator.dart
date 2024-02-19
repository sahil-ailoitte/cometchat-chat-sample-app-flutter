import 'package:flutter/material.dart';
import '../../../cometchat_uikit_shared.dart';

///[DataSourceDecorator] should be extended when creating any extension
abstract class DataSourceDecorator implements DataSource {
  DataSource dataSource;

  DataSourceDecorator(this.dataSource);

  @override
  List<CometChatMessageOption> getAudioMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group) {
    return dataSource.getAudioMessageOptions(
        loggedInUser, messageObject, context, group);
  }

  @override
  Widget getAuxiliaryOptions(User? user, Group? group, BuildContext context,
      Map<String, dynamic>? id, CometChatTheme? theme) {
    return dataSource.getAuxiliaryOptions(user, group, context, id, theme);
  }

  @override
  Widget getBottomView(
      BaseMessage message, BuildContext context, BubbleAlignment _alignment) {
    return dataSource.getBottomView(message, context, _alignment);
  }

  @override
  List<CometChatMessageOption> getCommonOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group) {
    return dataSource.getCommonOptions(
        loggedInUser, messageObject, context, group);
  }

  @override
  List<CometChatMessageComposerAction> getAttachmentOptions(
      CometChatTheme theme, BuildContext context, Map<String, dynamic>? id) {
    return dataSource.getAttachmentOptions(theme, context, id);
  }

  @override
  CometChatMessageTemplate getAudioMessageTemplate(CometChatTheme theme) {
    return dataSource.getAudioMessageTemplate(theme);
  }

  @override
  CometChatMessageTemplate getFileMessageTemplate(CometChatTheme theme) {
    return dataSource.getFileMessageTemplate(theme);
  }

  @override
  CometChatMessageTemplate getGroupActionTemplate(CometChatTheme theme) {
    return dataSource.getGroupActionTemplate(theme);
  }

  @override
  CometChatMessageTemplate getImageMessageTemplate(CometChatTheme theme) {
    return dataSource.getImageMessageTemplate(theme);
  }

  @override
  List<String> getAllMessageCategories() {
    return dataSource.getAllMessageCategories();
  }

  @override
  List<CometChatMessageTemplate> getAllMessageTemplates(
      {CometChatTheme? theme}) {
    return dataSource.getAllMessageTemplates(theme: theme);
  }

  @override
  List<String> getAllMessageTypes() {
    return dataSource.getAllMessageTypes();
  }

  @override
  CometChatMessageTemplate getVideoMessageTemplate(CometChatTheme theme) {
    return dataSource.getVideoMessageTemplate(theme);
  }

  @override
  List<CometChatMessageOption> getFileMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group) {
    return dataSource.getFileMessageOptions(
        loggedInUser, messageObject, context, group);
  }

  @override
  List<CometChatMessageOption> getImageMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group) {
    return dataSource.getImageMessageOptions(
        loggedInUser, messageObject, context, group);
  }

  @override
  List<CometChatMessageOption> getMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group) {
    return dataSource.getMessageOptions(
        loggedInUser, messageObject, context, group);
  }

  @override
  CometChatMessageTemplate? getMessageTemplate(
      {required String messageType,
      required String messageCategory,
      CometChatTheme? theme}) {
    return dataSource.getMessageTemplate(
        messageType: messageType, messageCategory: messageCategory);
  }

  @override
  String getMessageTypeToSubtitle(String messageType, BuildContext context) {
    return dataSource.getMessageTypeToSubtitle(messageType, context);
  }

  @override
  CometChatMessageTemplate getTextMessageTemplate(CometChatTheme theme) {
    return dataSource.getTextMessageTemplate(theme);
  }

  @override
  Widget getTextMessageContentView(TextMessage message, BuildContext context,
      BubbleAlignment _alignment, CometChatTheme theme) {
    return dataSource.getTextMessageContentView(
        message, context, _alignment, theme);
  }

  @override
  List<CometChatMessageOption> getTextMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group) {
    return dataSource.getTextMessageOptions(
        loggedInUser, messageObject, context, group);
  }

  @override
  List<CometChatMessageOption> getVideoMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group) {
    return dataSource.getVideoMessageOptions(
        loggedInUser, messageObject, context, group);
  }

  @override
  Widget getAudioMessageContentView(MediaMessage message, BuildContext context,
      BubbleAlignment _alignment, CometChatTheme theme) {
    return dataSource.getAudioMessageContentView(
        message, context, _alignment, theme);
  }

  @override
  Widget getFileMessageContentView(MediaMessage message, BuildContext context,
      BubbleAlignment _alignment, CometChatTheme theme) {
    return dataSource.getFileMessageContentView(
        message, context, _alignment, theme);
  }

  @override
  Widget getImageMessageContentView(MediaMessage message, BuildContext context,
      BubbleAlignment _alignment, CometChatTheme theme) {
    return dataSource.getImageMessageContentView(
        message, context, _alignment, theme);
  }

  @override
  Widget getVideoMessageContentView(MediaMessage message, BuildContext context,
      BubbleAlignment _alignment, CometChatTheme theme) {
    return dataSource.getVideoMessageContentView(
        message, context, _alignment, theme);
  }

  @override
  Widget getDeleteMessageBubble(
      BaseMessage _messageObject, CometChatTheme _theme) {
    return dataSource.getDeleteMessageBubble(_messageObject, _theme);
  }

  @override
  Widget getVideoMessageBubble(
      String? videoUrl,
      String? thumbnailUrl,
      MediaMessage message,
      Function()? onClick,
      BuildContext context,
      CometChatTheme theme,
      VideoBubbleStyle? style) {
    return dataSource.getVideoMessageBubble(
        videoUrl, thumbnailUrl, message, onClick, context, theme, style);
  }

  @override
  Widget getTextMessageBubble(
      String messageText,
      TextMessage message,
      BuildContext context,
      BubbleAlignment alignment,
      CometChatTheme theme,
      TextBubbleStyle? style) {
    return dataSource.getTextMessageBubble(
        messageText, message, context, alignment, theme, style);
  }

  @override
  Widget getImageMessageBubble(
      String? imageUrl,
      String? placeholderImage,
      String? caption,
      ImageBubbleStyle? style,
      MediaMessage message,
      Function()? onClick,
      BuildContext context,
      CometChatTheme theme) {
    return dataSource.getImageMessageBubble(imageUrl, placeholderImage, caption,
        style, message, onClick, context, theme);
  }

  @override
  Widget getAudioMessageBubble(
      String? audioUrl,
      String? title,
      AudioBubbleStyle? style,
      MediaMessage message,
      BuildContext context,
      CometChatTheme theme) {
    return dataSource.getAudioMessageBubble(
        audioUrl, title, style, message, context, theme);
  }

  @override
  Widget getFileMessageBubble(
      String? fileUrl,
      String? fileMimeType,
      String? title,
      int? id,
      FileBubbleStyle? style,
      MediaMessage message,
      CometChatTheme theme) {
    return dataSource.getFileMessageBubble(
        fileUrl, fileMimeType, title, id, style, message, theme);
  }

  @override
  String getLastConversationMessage(
      Conversation conversation, BuildContext context) {
    return dataSource.getLastConversationMessage(conversation, context);
  }

  @override
  Widget? getAuxiliaryHeaderMenu(
      BuildContext context, User? user, Group? group, CometChatTheme? theme) {
    return dataSource.getAuxiliaryHeaderMenu(context, user, group, theme);
  }

  @override
  Widget getFormMessageBubble({  String? title,
    FormBubbleStyle? formBubbleStyle,
    required FormMessage message,
    required CometChatTheme theme,}) {

    return dataSource.getFormMessageBubble(
        title: title,
        formBubbleStyle: formBubbleStyle,
        message:message,
        theme: theme );
  }

  @override
  Widget getFormMessageContentView(FormMessage message, BuildContext context, BubbleAlignment _alignment, CometChatTheme theme) {
    return dataSource.getFormMessageContentView( message,  context,  _alignment,  theme);
  }

  @override
  CometChatMessageTemplate getFormMessageTemplate(CometChatTheme theme) {
    return dataSource.getFormMessageTemplate( theme);
  }

  @override
  CometChatMessageTemplate getSchedulerMessageTemplate(CometChatTheme theme) {
    return dataSource.getSchedulerMessageTemplate( theme);
  }


  @override
  CometChatMessageTemplate getCardMessageTemplate(CometChatTheme theme) {
    return dataSource.getCardMessageTemplate(theme);

  }

  @override
  Widget getCardMessageContentView(CardMessage message, BuildContext context, BubbleAlignment _alignment, CometChatTheme theme) {
    return dataSource.getCardMessageContentView(
      message, context,_alignment,theme);
        }

  @override
  Widget getSchedulerMessageContentView(SchedulerMessage message, BuildContext context, BubbleAlignment _alignment, CometChatTheme theme) {
    return dataSource.getSchedulerMessageContentView(
        message, context,_alignment,theme);
  }

  @override
  Widget getCardMessageBubble({
    CardBubbleStyle? cardBubbleStyle,
    required CardMessage message,
    required CometChatTheme theme,
  }){
    return dataSource.getCardMessageBubble( message : message, theme:theme, cardBubbleStyle: cardBubbleStyle);
  }

  @override
  Widget getSchedulerMessageBubble({
    SchedulerBubbleStyle? schedulerBubbleStyle,
    required SchedulerMessage message,
    required CometChatTheme theme,
  }){
    return dataSource.getSchedulerMessageBubble( message : message, theme:theme, schedulerBubbleStyle: schedulerBubbleStyle);
  }


  @override
  List<CometChatMessageOption> getFormMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group){
    return dataSource.getFormMessageOptions( loggedInUser, messageObject,context,group);
  }


  @override
  List<CometChatMessageOption> getCardMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group){

    return dataSource.getCardMessageOptions( loggedInUser, messageObject,context,group);
  }

  @override
  List<CometChatMessageOption> getSchedulerMessageOptions(User loggedInUser,
      BaseMessage messageObject, BuildContext context, Group? group){
    return dataSource.getSchedulerMessageOptions( loggedInUser, messageObject,context,group);
  }



  @override
  List<CometChatMessageComposerAction> getAIOptions(User? user, Group? group,CometChatTheme theme, BuildContext context, Map<String, dynamic>? id , AIOptionsStyle? aiOptionStyle) {
    return dataSource.getAIOptions(user, group, theme, context, id, aiOptionStyle) ;
  }
}
