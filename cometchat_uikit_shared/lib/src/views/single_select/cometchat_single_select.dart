import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/material.dart';


/// A Flutter widget for creating a single select element with multiple options.
class CometChatSingleSelect extends StatefulWidget {
  CometChatSingleSelect({
    required this.options,
    this.selectedValue,
    this.onChanged,
    this.optionBackground,
    this.selectedOptionBackground,
    this.optionTextStyle,
    this.selectedOptionsTextStyle,
    this.decoration,
    this.theme
  });

  /// A list of options to display for selection.
  final List<OptionElement> options;

  /// The currently selected value from the list of options.
  final String? selectedValue;

  /// A callback function called when the selection changes.
  final ValueChanged<String>? onChanged;

  /// Text style for the selected option.
  final TextStyle? selectedOptionsTextStyle;

  /// Text style for the options.
  final TextStyle? optionTextStyle;

  /// Background color for the selected option.
  final Color? selectedOptionBackground;

  /// Background color for the options.
  final Color? optionBackground;

  /// Custom decoration for the widget.
  final Decoration? decoration;

  /// Set the theme for this widget.
  final CometChatTheme? theme;


  @override
  _CometChatSingleSelectState createState() => _CometChatSingleSelectState();
}

class _CometChatSingleSelectState extends State<CometChatSingleSelect> {
  late String? selectedValue;

  late CometChatTheme theme;

  @override
  void initState() {
    super.initState();
    theme = widget.theme??cometChatTheme;
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    final lessThanThreeOptions = widget.options.length < 3;
    Widget wrapping;
    if (lessThanThreeOptions) {
      wrapping = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          widget.options.length,
              (index) {
            final option = widget.options[index];
            return Expanded(
                child: DecoratedBox(
                decoration: BoxDecoration(
                border: index>0 ?Border(
                left: BorderSide(width: 1, color: theme.palette.getAccent200())
                ):null
                ),
                child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CometChatSingleSelectButton(
                    selectedOptionsTextStyle: widget.selectedOptionsTextStyle,
                    optionBackground: widget.optionBackground,
                    optionTextStyle: widget.optionTextStyle,
                    selectedOptionBackground: widget.selectedOptionBackground,
                    selected: selectedValue == option.value,
                    label: option.label,
                    onSelected: () {
                      setState(() {
                        selectedValue = option.value;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(option.value);
                      }
                    },
                  ),
                ],
              ),
            ));
          },
        ),
      );
    } else {
      wrapping = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          widget.options.length,
              (index) {
            final option = widget.options[index];
            return DecoratedBox(
              decoration: BoxDecoration(
                  border: index>0 ?Border(
                      left: BorderSide(width: 1, color: theme.palette.getAccent200())
                  ):null
              ),
              child: CometChatSingleSelectButton(
                selected: selectedValue == option.value,
                label: option.label,
                onSelected: () {
                  setState(() {
                    selectedValue = option.value;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(option.value);
                  }
                },
              ),
            );
          },
        ),
      );
    }

    return Container(
        decoration: widget.decoration,
        child: wrapping);
  }
}

class CometChatSingleSelectButton extends StatelessWidget {
  final bool selected;
  final String label;
  final VoidCallback onSelected;
  final TextStyle? selectedOptionsTextStyle;
  final TextStyle? optionTextStyle;
  final Color? selectedOptionBackground;
  final Color? optionBackground;


  CometChatSingleSelectButton({
    required this.selected,
    required this.label,
    required this.onSelected,
    this.optionBackground,
    this.selectedOptionBackground,
    this.optionTextStyle,
    this.selectedOptionsTextStyle
  });

  @override
  Widget build(BuildContext context) {
    const selectedTextStyle = TextStyle(fontWeight: FontWeight.bold, color:  Colors.white);
    const optionTextStyle = TextStyle(fontWeight: FontWeight.normal, color:  Colors.black);

    final TextStyle containerTextStyle = selected ? (selectedOptionsTextStyle??selectedTextStyle) :(optionTextStyle?? optionTextStyle);

    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
              children: [
                Center(
                  child: Text(
                      label,
                      style: containerTextStyle
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}