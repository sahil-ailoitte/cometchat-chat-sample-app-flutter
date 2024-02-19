import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';

///Function to show comeChat action sheet
Future<CometChatMessageComposerAction?>? showCometChatAiOptionSheet(
    {required BuildContext context,
    required List<CometChatMessageComposerAction> actionItems,
    final Color? backgroundColor,
    final Color? iconBackground,
    final User? user,
    final Group? group,
    required final CometChatTheme theme,
      final double? borderRadius
    }) {
      if (Platform.isIOS) {
        List<Widget> featureList = [];
        for (int i = 0; i < actionItems.length ; i++) {
          featureList.add(
            CupertinoActionSheetAction(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  actionItems[i].title ?? "",
                  style:actionItems[i].titleStyle??
                  TextStyle(
                      fontSize: theme.typography.title2.fontSize,
                      fontWeight: theme.typography.title2.fontWeight,
                      color: theme.palette.getPrimary(),
                      fontFamily: theme.typography.title2.fontFamily),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if(actionItems[i].onItemClick!=null){
                  actionItems[i].onItemClick!(context , user, group);
                }

              },
            ),
          );
        }
        showCupertinoModalPopup(
          context: context,
          builder: (_) {
            return CupertinoActionSheet(
              actions: featureList,
            );
          },
        );
      } else {
        if (Platform.isAndroid) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            backgroundColor: theme.palette.getBackground(),
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(borderRadius??16),
              ),
            ),
            builder: (builder) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: actionItems.length,
                itemBuilder: (_, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        if(actionItems[index].onItemClick!=null){
                          actionItems[index].onItemClick!(context , user, group);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            actionItems[index].title ??
                                "",
                            style:actionItems[index].titleStyle??
                            TextStyle(
                                fontSize: theme.typography.title2.fontSize,
                                fontWeight: theme.typography.title2.fontWeight,
                                color: theme.palette.getPrimary(),
                                fontFamily: theme.typography.title2.fontFamily),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      }
      return null;
}
