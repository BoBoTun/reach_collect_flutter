import 'package:flutter/material.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/custom_button.dart';

class SidebarListItemView extends StatefulWidget {
  const SidebarListItemView({super.key});

  @override
  State<SidebarListItemView> createState() => _SidebarListItemViewState();
}

class _SidebarListItemViewState extends State<SidebarListItemView> {
  int _selectedIndex = 0;
  List<String> items = ['RMNCH', 'Consulation', 'Distribution', 'Malaria'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
        Expanded(
          child: ListView.builder(
          itemCount: items.length,
          itemBuilder: ((context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _selectedIndex == index ? AppTheme.thirdColor : AppTheme.whiteColor,
                boxShadow: [
                  BoxShadow(blurRadius: 3.0, spreadRadius: 3.0, color: AppTheme.thirdColor.withOpacity(0.2))
                ]
              ),
              child: Center(child: Text(items[index],style:  TextStyle(color: _selectedIndex == index ? Colors.white : Colors.black,fontWeight: FontWeight.bold),)),
            ),
          );
                })),
        ),

        CustomButton(buttonHeight: 40, label: 'Export', iconName: AppTheme.kExportLogo, width: 140,),

        const SizedBox(height: 20,)
    ]);
  }
}

