import 'package:doctor_app/core/colors.dart';
import 'package:doctor_app/core/common/CustomAlertDialog.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/common_textfield.dart';
import 'package:doctor_app/core/common/date_time_utils.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/context_extension.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/screen/admin/model/patient_details_model.dart';
import 'package:doctor_app/screen/admin/new_dashboard/calender/add_appointments_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/common/file_picker_helper.dart';

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({super.key, this.title});

  final String? title;
  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  List<Patients> patients = [];
  //List<Patients> filteredPatients = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CalenderProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getPatientDetails().then((value) {
        print('===sss==${widget.title}');
        setState(() {});

        setState(() {
          // filteredPatients = List.from(patients);
        });
      });
    });
    setState(() {
      //searchController.addListener(_filterPatients);
    });
  }

  @override
  void dispose() {
    //searchController.removeListener(_filterPatients);
    searchController.dispose();
    super.dispose();
  }

  /* void _filterPatients() {
    String query = searchController.text.toLowerCase();

    setState(() {
      filteredPatients = patients.where((patient) {
        return patient.firstName.toString().toLowerCase().contains(query) ||
            patient.email.toString().toLowerCase().contains(query) ||
            patient.phoneNumber.toString().toLowerCase().contains(query);
      }).toList();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isMobile = Responsive.isMobile(context);
    return Consumer<CalenderProvider>(builder: (context, provider, child) {
      if (widget.title == "all") {
        patients = provider.patientDetailsModel?.patients ?? [];
        //filteredPatients = List.from(patients);
      } else if (widget.title == "all_female") {
        patients = provider.filterBYGender(gender: 'female') ?? [];
        //  filteredPatients = List.from(patients);
      } else if (widget.title == "all_male") {
        patients = provider.filterBYGender(gender: 'male') ?? [];
        // filteredPatients = List.from(patients);
      } else if (widget.title == "female_under30") {
        patients = provider.filterByAge(age: 30, isUnder: true) ?? [];
      } else if (widget.title == "female_over30") {
        patients = provider.filterByAge(age: 30, isUnder: false) ?? [];
      }
      return Stack(
        children: [
          ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  isMobile
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: 40,
                                  child: CommonTextField(
                                    colorFill: Colors.white,
                                    hint: "Search Patient Name / ID /Phone number",
                                  ),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 350,
                                  child: CommonTextField(
                                    fontSize: 12,
                                    controller: searchController,
                                    colorFill: Colors.white,
                                    hint: "Search Patient Name/ID/Phone number",
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                  const Divider(
                    thickness: 0.3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.white,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              cardColor: Colors.white,
                              cardTheme: const CardTheme(
                                color: Colors.white,
                                elevation: 0,
                              ),
                              dataTableTheme: DataTableThemeData(
                                headingRowColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                  // Set color for heading row
                                  return const Color.fromRGBO(48, 180, 128, 1)!; // example color
                                }),
                                dataRowColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                  // Set color for data rows
                                  return const Color.fromARGB(255, 240, 242, 241)!; // example color
                                }),
                                // Add other customizations here
                              ),
                            ),
                            child: Container(
                              color: Colors.white,
                              width: size.width,
                              child: PaginatedDataTable(
                                  showEmptyRows: false,
                                  columns: [
                                    DataColumn(
                                        label: CommonTextWidget(
                                      text: 'Name',
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.white,
                                    )),
                                    DataColumn(
                                        label: CommonTextWidget(
                                      text: 'Email',
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.white,
                                    )),
                                    DataColumn(
                                        label: CommonTextWidget(
                                      text: 'Phone Number',
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.white,
                                    )),
                                    DataColumn(
                                        label: CommonTextWidget(
                                      text: 'Gender',
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.white,
                                    )),
                                    DataColumn(
                                        label: CommonTextWidget(
                                      text: 'Age',
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.white,
                                    )),
                                    DataColumn(
                                      numeric: true,
                                      label: CommonTextWidget(
                                        text: 'Action',
                                        fontWeight: FontWeight.w600,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                  source: MyData(patients, context),
                                  rowsPerPage: patients.isNotEmpty
                                      ? patients.length
                                      : 1 //patients?.length??1,
                                  ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          provider.isFetching ? showLoaderList() : const SizedBox.shrink()
        ],
      );
    });
  }
}

class MyData extends DataTableSource {
  MyData(this.patients, this.context);
  List<Patients>? patients;
  BuildContext context;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    final user = patients?[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(CommonTextWidget(
            fontSize: 12,
            text:
                '${user?.firstName.toString().toCapitalize()} ${user?.lastName.toString().toCapitalize()}')),
        DataCell(CommonTextWidget(fontSize: 12, text: user?.email.toString())),
        DataCell(
            CommonTextWidget(fontSize: 12, text: user?.phoneNumber.toString())),
        DataCell(CommonTextWidget(fontSize: 12, text: user?.gender.toString())),
        //DataCell(CommonTextWidget(fontSize: 12, text: user?.dateOfBirth.toString())),
        DataCell(CommonTextWidget(
            fontSize: 12,
            text:
                '${DateTimeUtils.calculateAge(date: user!.dateOfBirth.toString())}' /*DateFormat('yyyy-MM-dd')
                .format(DateTime.parse('${user?.dateOfBirth.toString()}'))*/
            )),
        DataCell(buildPopupMenu(id: user.sId.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => patients != null ? patients!.length : 1;

  @override
  int get selectedRowCount => 0;

  Widget buildPopupMenu({String? id}) {
    return PopupMenuButton<String>(
      color: Colors.white,
      onSelected: (String value) async {
        // Handle the create option
        if (value == 'create') {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(
                  content: AddAppointmentsWidget(
                    dateTime: DateTime.now(),
                    patientID: id,
                  ),
                );
              });
        } else if (value == 'upload') {
          String? filePath = await FilePickerHelper.pickFile();
          if (filePath != null) {
            // Handle the selected file path
            print('Selected file: $filePath');
            // You can also display it in a dialog or another widget
          } else {
            // Handle the case when no file is selected
            print('No file selected or permission denied');
          }

          // Handle Inactive logic
          if (kDebugMode) {
            print('Inactive selected');
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'create',
          child: Text('Create An Appointments'),
        ),
        const PopupMenuItem<String>(
          value: 'upload',
          child: Text('Upload File'),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
      child: const Icon(
        Icons.more_vert,
        color: Colors.grey,
      ), // Icon to trigger the pop-up menu
    );
  }
}
