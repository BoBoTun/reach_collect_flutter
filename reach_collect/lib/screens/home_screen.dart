import 'package:flutter/material.dart';
import 'package:reach_collect/data/model/anc_model';
import 'package:reach_collect/network/presistance/database_provider.dart';
import 'package:reach_collect/screens/acm_register.dart';
import 'package:reach_collect/screens/delivery_register.dart';
import 'package:reach_collect/screens/srh_register.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/custom_button.dart';
import 'package:reach_collect/widgets/sidebar_listview.dart';
import '../widgets/contact_Listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.indexOfTab});
  final int indexOfTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ANCVo> ancVo = [];

  @override
  void initState() {
    super.initState();

    DatabaseProvider.db.getAllDataFromDB().then((value) {
      setState(() {
        ancVo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        backgroundColor: AppTheme.secondaryColor,
        title: Row(
          children: [
            Image.asset(
              AppTheme.kInsuranceLogo,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 30,
            ),
            const Text(
              "IHRP System",
              style: AppTheme.navigationTitleStyle,
            ),
          ],
        ),
      ),
      backgroundColor: AppTheme.whiteColor,
      body: ProcessView(
        ancVO: ancVo, indexOfTab: widget.indexOfTab,
      ),
    );
  }
}

// ignore: must_be_immutable
class ProcessView extends StatefulWidget {
  ProcessView({
    super.key,
    required this.ancVO,
    required this.indexOfTab
  });

  List<ANCVo> ancVO;
  int indexOfTab = 0;

  @override
  State<ProcessView> createState() => _ProcessViewState();
}

class _ProcessViewState extends State<ProcessView> {
  final List<String> array = ['ANC', 'Delivery', 'SRH'];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.15,
            color: AppTheme.primaryColor,
            child: const SidebarListItemView(),
          ),
        ),
        Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      //header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: DefaultTabController(
                                initialIndex: widget.indexOfTab,
                                length: array.length,
                                child: TabBar(
                                    onTap: (value) {
                                      setState(() {
                                        widget.indexOfTab = value;
                                      });
                                    },
                                    tabAlignment: TabAlignment.start,
                                    isScrollable: true,
                                    dividerColor: Colors.white,
                                    tabs: array
                                        .map((e) => Tab(
                                              child: Text(e),
                                            ))
                                        .toList()),
                              ),
                            ),
                          ),
                          CustomButton(
                            buttonHeight: 35,
                            label: 'New',
                            iconName: AppTheme.kPlusIcon,
                            width: 120,
                            onPressed: () {
                              if (widget.indexOfTab == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            const AcmRegisterScreen()));
                              }else if(widget.indexOfTab ==1 ){
                                 Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      const DeliveryRegisterScreen()));
                              }else {
                                 Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      const SRHRegisterScreen()));
                              }
                            },
                          )
                        ],
                      ),

                      //divider
                      const Divider(),
                      //
                      widget.ancVO.isEmpty
                          ? const Center(
                              child: Text('No data to show'),
                            )
                          : ContactListView(
                              reachData: widget.ancVO,
                              reloadView: () {
                                DatabaseProvider.db
                                    .getAllDataFromDB()
                                    .then((value) {
                                  setState(() {
                                    widget.ancVO = value;
                                  });
                                });
                              },
                            )
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
