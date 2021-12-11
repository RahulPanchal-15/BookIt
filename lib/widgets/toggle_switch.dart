import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomToggle extends StatefulWidget {
  final int? selectedIndex;
  void Function(int)? onToggle;
  final List<String>? labels;

  CustomToggle({
    Key? key,
    this.selectedIndex,
    this.labels,
    this.onToggle,
  }) : super(key: key);

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minHeight: 30.0,
      minWidth: 100.0,
      initialLabelIndex: widget.selectedIndex!,
      cornerRadius: 20.0,
      totalSwitches: widget.labels!.length,
      labels: widget.labels!,
      borderWidth: 2.0,
      borderColor: [Colors.purple],
      activeBgColor: [Colors.purple],
      inactiveBgColor: Colors.white,
      inactiveFgColor: Colors.purple,
      onToggle: (index) {
        widget.onToggle!(index);
      },
    );
  }
}
