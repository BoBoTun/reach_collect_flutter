import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/date_picker.dart';

class TDDropDownView extends StatefulWidget {
  TDDropDownView({
    super.key,
    required this.dateString,
  });
  Function(String) dateString;

  @override
  _TDDropDownState createState() => _TDDropDownState();
}

class _TDDropDownState extends State<TDDropDownView> {
  String _selectedOption = '1st'; // Initial selected option

  // Options for the dropdown
  final List<String> _options = [
    '1st',
    '2nd',
  ];

  DateTime selectedDate = DateTime.now();
  String showDateString = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
        );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
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
          onChanged: (newValue) async {
            setState(() {
              _selectedOption = newValue ?? '';
            });

            Future.delayed(Duration(milliseconds: 200), () {
              _selectDate(context);
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
