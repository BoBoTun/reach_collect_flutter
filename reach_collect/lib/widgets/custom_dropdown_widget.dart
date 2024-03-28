import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';

class DropdownListView extends StatefulWidget {
  const DropdownListView({super.key, required this.containerWidth, required this.value});
  final double containerWidth;
  final Function(String) value;
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownListView> {
  String _selectedOption = 'Option 1'; // Initial selected option

  // Options for the dropdown
  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: Container(),
          focusColor: AppTheme.primaryColor,
          iconEnabledColor: AppTheme.secondaryColor,
          iconSize: 30,
          value: _selectedOption,
          onChanged: (newValue) {
            setState(() {
              _selectedOption = newValue ?? '';
              widget.value(newValue ?? '');
            });
          },
          items: _options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

