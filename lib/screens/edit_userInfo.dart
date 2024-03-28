import 'package:flutter/material.dart';
import 'package:reach_collect/data/model/anc_model';
import 'package:reach_collect/network/presistance/database_provider.dart';
import 'package:reach_collect/screens/home_screen.dart';
import 'package:reach_collect/utils/app_styles.dart';
import 'package:reach_collect/widgets/button_widget.dart';
import 'package:reach_collect/widgets/date_picker.dart';
import 'package:reach_collect/widgets/radio_button.dart';

import '../data/model/reach_model.dart';

class EditUserInfo extends StatefulWidget {
  const EditUserInfo({super.key, required this.reachCollectVo});
  final ANCVo reachCollectVo;

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  //data var
  String date = '';
  String disability = '';
  String idp = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gestationalWeekController = TextEditingController();
  TextEditingController gravidaController = TextEditingController();
  TextEditingController parityController = TextEditingController();
  TextEditingController tdController = TextEditingController();
  TextEditingController findingsController = TextEditingController();
  TextEditingController treatmentController = TextEditingController();
  TextEditingController attendedController = TextEditingController();
  TextEditingController outcomeController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    date = widget.reachCollectVo.date ?? '';
    disability = widget.reachCollectVo.disability ?? '';
    idp = widget.reachCollectVo.idp ?? '';
    nameController.text = widget.reachCollectVo.name ?? '';
    ageController.text = widget.reachCollectVo.age ?? '';
    gestationalWeekController.text = widget.reachCollectVo.gestational ?? '';
    gravidaController.text = widget.reachCollectVo.gravida ?? '';
    parityController.text = widget.reachCollectVo.parity ?? '';
    tdController.text = widget.reachCollectVo.td ?? '';
    findingsController.text = widget.reachCollectVo.findings ?? '';
    treatmentController.text = widget.reachCollectVo.treatment ?? '';
    attendedController.text = widget.reachCollectVo.attended ?? '';
    outcomeController.text = widget.reachCollectVo.outcome ?? '';
    remarkController.text = widget.reachCollectVo.remark ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        backgroundColor: AppTheme.secondaryColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
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
                "ACM Register",
                style: AppTheme.navigationTitleStyle,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:Image.asset(AppTheme.kBackIcon,width: 60,height: 60,)),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.primaryColor),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 80, top: 30, bottom: 14, right: 80),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Date',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),

                //date picker session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DatePicker(
                      dateString: (dateString) {
                        date = dateString;
                      },
                      updateDateString: date,
                    ),
                    inputBox('Name', 1, nameController),
                    inputBox('Age (number only)', 1, ageController)
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                //disability session
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Disability',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: HorizontalRadioButton(
                                radioValue: (String value) {
                                  disability = value;
                                },
                                activeValue: disability,
                              )),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'IDP',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: 50,
                              width: 200,
                              child: HorizontalRadioButton(
                                radioValue: (String value) {
                                  idp = value;
                                },
                                activeValue: idp,
                              )),
                        ],
                      ),
                    ),

                    //extra space
                    const SizedBox(
                      width: 250,
                    )
                  ],
                ),

                //ges week
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    inputBox('Gestational Week', 1, gestationalWeekController),
                    inputBox('Gravida', 1, gravidaController),
                    inputBox('Parity', 1, parityController)
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                //finding
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    inputBox('Td(1st/2nd)', 1, tdController),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Findings',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Findings', 3, findingsController),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Treatment',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Treatment', 3, treatmentController),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                //attended
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    inputBox('Attended by*', 1, attendedController),
                    inputBox('Outcome', 1, outcomeController),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Remark',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        inputBox('Remark', 3, remarkController),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                //button
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ButtonWidget(
                        buttonText: 'Update',
                        onPressed: () {
                          if (nameController.text.isEmpty ||
                              ageController.text.isEmpty ||
                              gestationalWeekController.text.isEmpty ||
                              gravidaController.text.isEmpty ||
                              parityController.text.isEmpty ||
                              tdController.text.isEmpty ||
                              findingsController.text.isEmpty ||
                              treatmentController.text.isEmpty ||
                              attendedController.text.isEmpty ||
                              outcomeController.text.isEmpty ||
                              remarkController.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Center(
                              child: Text('Sorry!! Please input empty fields'),
                            )));
                          } else {
                            try {
                              ANCVo dataVo = ANCVo(
                                  id: widget.reachCollectVo.id,
                                  orgName: "",
                                  date: date,
                                  name: nameController.text,
                                  age: ageController.text,
                                  disability: disability,
                                  idp: idp,
                                  gestational: gestationalWeekController.text,
                                  gravida: gravidaController.text,
                                  parity: parityController.text,
                                  td: tdController.text,
                                  findings: findingsController.text,
                                  treatment: treatmentController.text,
                                  attended: attendedController.text,
                                  outcome: outcomeController.text,
                                  remark: remarkController.text);

                              DatabaseProvider provider = DatabaseProvider.db;
                              provider.updateUserInto(dataVo);

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          const HomeScreen()));
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Center(
                                child: Text('Something wrong!!'),
                              )));
                            }
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container inputBox(
      String title, int maxlines, TextEditingController controller) {
    return Container(
      height: maxlines == 1 ? 50 : 100,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 5.0, spreadRadius: 5.0, color: Colors.black12)
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}
