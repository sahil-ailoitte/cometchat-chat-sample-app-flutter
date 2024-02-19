
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';

import 'decorated_container_style.dart';

class CometChatDecoratedContainer extends StatelessWidget {
  const CometChatDecoratedContainer({  Key? key,
  this.content,
    this.style,
    this.title,
    this.closeIconUrl,
    this.maxHeight,
    this.onCloseIconTap,
    this.closeIconUrlPackageName,
    this.closeIconTint,
  }):super(key: key);

  final double? maxHeight;

  final String? title;

  final String? content;

  final String? closeIconUrl;

  final String? closeIconUrlPackageName;

  final DecoratedContainerStyle?  style;

  final VoidCallback? onCloseIconTap;

  final Color? closeIconTint;




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: style?.height,
        width:  style?.width,
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(style?.borderRadius??6),
          border: style?.border??Border.all(
            width: 1,
            color: const Color(0xff3399FF)
          ),
        ),
        constraints:  BoxConstraints(maxHeight:maxHeight?? 400.0),
        padding: style?.padding?? const EdgeInsets.all(8.0),
        margin: style?.margin?? const EdgeInsets.only(bottom: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween
              ,children: [
                if(title!=null)Text(title!, style: style?.titleStyle??const TextStyle(
                  color: Color(0xFF141414),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500
                ),),
                IconButton(onPressed: onCloseIconTap, icon: closeIconUrl==null? Icon(Icons.close ,color:  closeIconTint,):
                Image.asset(closeIconUrl! ,package: closeIconUrlPackageName)
                )
              ],
            ),
            if(content!=null) Text(content!, style: style?.contentStyle??const TextStyle(
                color: Color(0x99141414),
                fontSize: 17.0,
                fontWeight: FontWeight.w400
            ),
            ),
          ],
        ),
      ),
    );
  }
}
