import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_drop_down_view.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/common/date_time_utils.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/responsive.dart';
import 'package:doctor_app/provider/calender_provider.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class GetEditAppointmentsDetailsWidget extends StatefulWidget {
  const GetEditAppointmentsDetailsWidget({super.key, this.appointmentsID});

  final String? appointmentsID;

  @override
  State<GetEditAppointmentsDetailsWidget> createState() =>
      _GetEditAppointmentsDetailsWidgetState();
}

class _GetEditAppointmentsDetailsWidgetState
    extends State<GetEditAppointmentsDetailsWidget> {
  var tetDate = TextEditingController();
  var tetTime = TextEditingController();
  var tetReason = TextEditingController();

  bool isDatePicked = false;
  bool isTimePicked = false;
  String? valueS;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<CalenderProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getPatientDetails().then((value) {});
      provider
          .getAppointmentsDetailsBYID(widget.appointmentsID ?? "0")
          .then((value) {
        setState(() {
          setData();
        });
      });

      //   tetDate.text=formattedDate;
    });
  }

  void setData() async {
    final provider = Provider.of<CalenderProvider>(context, listen: false);

    setState(() {
      String formattedDate = provider.appointmentsDetailsModel?.dateTime != null
          ? DateTimeUtils.formatDate(
              '${provider.appointmentsDetailsModel?.dateTime.toString()}',
              format: DateTimeUtils.yyyyMMdd)
          : '';
      String formattedTime = provider.appointmentsDetailsModel?.dateTime != null
          ? DateTimeUtils.formatDate(
              '${provider.appointmentsDetailsModel?.dateTime.toString()}',
              format: DateTimeUtils.hhmmss)
          : '';
      if (!isDatePicked) {
        tetDate.text = formattedDate; // Only set if date not picked manually
      }
      if (!isTimePicked) {
        tetTime.text = formattedTime; // Only set if date not picked manually
      }

      tetReason.text = provider.appointmentsDetailsModel?.reason != null
          ? '${provider.appointmentsDetailsModel?.reason.toString()}'
          : '';

      if (provider.appointmentsDetailsModel?.patient?.sId != null) {
        provider.updateValue(
            '${provider.appointmentsDetailsModel?.patient?.firstName} ${provider.appointmentsDetailsModel?.patient?.lastName}');
        provider.updateID('${provider.appointmentsDetailsModel?.patient?.sId}');
      }
    });
  }

  @override
  void dispose() {
    tetDate.dispose();
    tetReason.dispose();
    tetTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isMobile = Responsive.isMobile(context);
    var isDesktop = Responsive.isDesktop(context);
    var size = MediaQuery.sizeOf(context);

    var width = MediaQuery.of(context).size.width;

    return Consumer<CalenderProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: isMobile
            ? width * zero9
            : isDesktop
                ? width * 0.3
                : width * 0.19,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonTextWidget(
                            text: "Edit Appointment",
                            fontSize: 16,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w700,
                            // top: 20,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      /*Center(
                        child: CommonTextWidget(
                          text: "Appointment Details",
                          fontSize: 16,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          top: 20,
                        ),
                      ),*/
                      commonTextFiledView(
                          height: 45,
                          fontSize: 12,
                          radius: 8,
                          topText: 5,
                          controller: tetDate,
                          isReadOnly: true,
                          onTap: () {
                            DateTimeUtils.displayDatePicker(
                                context: context,
                                getDate: (value) {
                                  print('========da${value}');
                                  setState(() {
                                    isDatePicked = true;
                                    tetDate.text =
                                        value; // Update the text field inside setState
                                  });
                                  //  tetDate.text=value;
                                });
                          },
                          topTextField: 10,
                          title: "Date"),
                      commonTextFiledView(
                          height: 45,
                          fontSize: 12,
                          topText: 10,
                          isReadOnly: true,
                          onTap: () {
                            DateTimeUtils.displayTimePicker(
                                context: context,
                                getTime: (value) {
                                  print('========da${value}');
                                  tetTime.text = value;
                                  isTimePicked = true;
                                });
                          },
                          controller: tetTime,
                          topTextField: 10,
                          radius: 8,
                          title: "Time"),
                      CommonTextWidget(
                        text: "Patient Name",
                        top: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonDropDownView(
                          horizontal: 5,
                          height: 45,
                          selectedValue: provider.selectedValue,
                          onChanged: (value) {
                            provider.updateValue(value);
                            if (provider.selectedValue != null) {
                              provider.updateID(provider
                                  .patientDetailsModel?.patients
                                  .firstWhere((item) =>
                                      '${item.firstName} ${item.lastName}' ==
                                      value)
                                  .sId);

                              if (kDebugMode) {
                                print(
                                    'Selected Patient: ${provider.selectedID}');
                              }
                            }
                          },
                          size: size,
                          items: provider.patientDetailsModel?.patients != null
                              ? provider.patientDetailsModel!.patients
                                  .map((patient) {
                                  return '${patient.firstName} ${patient.lastName}';
                                }).toList()
                              : []),
                      commonTextFiledView(
                        title: "Description",
                        topText: 10,
                        maxLines: 3,
                        fontSize: 12,
                        controller: tetReason,
                        topTextField: 10,
                        height: 45,
                        radius: 8,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: CommonButtonWidget(
                              height: 40,
                              radius: 8,
                              onPressed: () async {
                                String userId = await getUserID();
                                String dateString =
                                    "${tetDate.text}T${tetTime.text}:00.000Z";

                                DateTime dateTime = DateTime.parse(dateString);

                                print(dateTime.toIso8601String()); // Outputs: 2
                                Map<String, dynamic> body = {
                                  "patientId": provider.selectedID,
                                  "doctorId": userId,
                                  "dateTime": dateTime.toIso8601String(),
                                  "reason": tetReason.text,
                                  "isVirtual": true,
                                };

                                provider
                                    .updateAppointmentData(
                                  body: body,
                                  appointmentsID:
                                      widget.appointmentsID.toString(),
                                  context: context,
                                )
                                    .then((value) {
                                  if (globalStatusCode == 200 ||
                                      globalStatusCode == 201) {
                                    //resetField();
                                    // provider.selectedID==null;
                                    Navigator.of(context).pop();
                                  }
                                });
                              },
                              colorButton: colorGreen,
                              fontSize: 12,
                              text: "Save",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CommonButtonWidget(
                              text: "Cancel",
                              height: 40,
                              radius: 8,
                              colorBorder: Colors.black,
                              colorButton: Colors.white,
                              colorText: Colors.black,
                              onPressed: () {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    provider.selectedID == null;
                                    Navigator.of(context).pop();
                                  });
                                });
                              },
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  provider.isAdding || provider.isFetching
                      ? Center(child: showLoaderList())
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
