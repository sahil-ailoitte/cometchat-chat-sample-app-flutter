import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///[ChatAlignment] is an enum that defines the alignment of the messages in the message list
enum ChatAlignment { leftAligned, standard }

///[BubbleAlignment] is an enum that defines the alignment of the messag bubble
enum BubbleAlignment { left, center, right }

///[TimeAlignment] is an enum that defines the position of the timestamp shown in the message bubble
///[top] places the timestamp in the header of [CometChatMessageBubble]
///[bottom] places the timestamp in the footer of [CometChatMessageBubble]
enum TimeAlignment { top, bottom }

///[MessageStatus] is an enum that contains the various stages of message delivery
///[inProgress] means the request to send a [BaseMessage] is currently ongoing or has been made but awaiting success response
///[sent] means message was sent successfully and a success response has been received in the [onSuccess] callback for the request to send a [BaseMessage]
///[error] the request for sending a message has failed and an error response has been in received in the [onError] callback
enum MessageStatus { inProgress, sent, error }

///[MessageEditStatus] is an enum that contains the various stages of updating a messag
///[inProgress] means the request to update a [BaseMessage] is currently ongoing or has been made but awaiting success response
///[success] means message was updated successfully and a success response has been received in the [onSuccess] callback for the request to update a [BaseMessage]
enum MessageEditStatus { inProgress, success }

///[EventStatus] is an enum that contains the various stages of deleting a message
///[inProgress] means the request to delete a [BaseMessage] is currently ongoing or has been made but awaiting success response
///[success] means message was deleted successfully and a success response has been received in the [onSuccess] callback for the request to delete a [BaseMessage]
enum EventStatus { inProgress, success }

///[ConversationTypes] is an enum that is used fetch filtered [Conversation] list
enum ConversationTypes { user, group, both }

///[SelectionMode] is an enum that defines how many items can be selected in a list
enum SelectionMode { single, multiple, none }

///[ActivateSelection] is an enum that controls on what gesture selection will work
enum ActivateSelection { onClick, onLongClick }

///[AuxiliaryButtonsAlignment] is an enum that defines the position of the auxiliary buttons in the [CometChatMessageComposer]
enum AuxiliaryButtonsAlignment { left, right }

///[PreviewMessageMode] is an enum that defines the nature of the message preview that needs to be shown in the [CometChatMessageComposer]
enum PreviewMessageMode { edit, reply, none }

enum TabVisibility{users, groups, usersAndGroups}

enum APIActionMethod{post, put, delete, patch}

enum DateTimeVisibilityMode{date, time, dateTime}

enum SchedulerBubbleStage {
  loading,
  initial,
  datePicker,
  timePicker,
  schedule,
  goalCompleted,
  error
}

enum ScheduleStatus {
  unscheduled,
  loading,
  error,
  slotUnvailable
}
