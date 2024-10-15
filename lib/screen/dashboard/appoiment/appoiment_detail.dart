import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:flutter/material.dart';

class AppoimentDetail extends StatelessWidget {
  const AppoimentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      left: 0,
      right: 0,
      color: const Color.fromRGBO(240, 239, 246, 1),
      appBar: commonAppBar(title: 'APPOINTMENT DETAILS'),
      child: ListView(
        children: [_topView(), _middleView(), _bottomView()],
      ),
    );
  }

  _topView() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: CommonTextWidget(
              text: 'Patient Details',
              textColor: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              marginBottom: 8,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  text: 'John Deer',
                  textColor: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  marginBottom: 8,
                ),
                CommonTextWidget(
                  text: '+1-555-852-5574',
                  textColor: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
              color: Colors.grey,
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.topLeft,
            child: CommonTextWidget(
              text: 'Appointment is confirmed',
              textColor: Colors.green,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    text: 'Appointment Type & Status',
                    textColor: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 10),
                  CommonTextWidget(
                    text: 'Book',
                    textColor: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Colors.green.withOpacity(0.20),
                child: CommonTextWidget(
                  text: 'CONFIRMED',
                  textColor: Colors.green.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _middleView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: CommonTextWidget(
              text: 'Appointment Date & Time',
              textColor: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  text: '11 Oct 2024',
                  textColor: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  top: 10,
                ),
                CommonTextWidget(
                  text: '12:30 PM',
                  textColor: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  top: 10,
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: const VisualDensity(vertical: -4),
            title: CommonTextWidget(
              text: 'Doctor',
              textColor: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              marginBottom: 8,
            ),
            subtitle: CommonTextWidget(
              text: 'Dr. Anthony Lorepose',
              textColor: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: const VisualDensity(vertical: -4),
            title: CommonTextWidget(
              text: 'Clinic',
              textColor: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 14,
              marginBottom: 8,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget(
                  text: 'Thomson Eye & Gynaec Centre ',
                  textColor: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  marginBottom: 8,
                ),
                CommonTextWidget(
                  text: 'Washington West',
                  textColor: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  marginBottom: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _bottomView() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: CommonTextWidget(
              text: 'PFC (Platform development Fee Per Connection)',
              textColor: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget(
                  text: '$rupee 375.00',
                  textColor: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  top: 10,
                ),
                CommonTextWidget(
                  text: 'RAISE DISPUTE',
                  textColor: Colors.amber,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  top: 10,
                ),
              ],
            ),
          ),
          commonTextFiledView(
            topText: 10,
            title: 'Add Comment',
            maxLines: 4,
            topTextField: 10,
          ),
          Container(
            padding: const EdgeInsets.only(right: 5),
            alignment: Alignment.centerRight,
            child: CommonTextWidget(
              text: '0 out of 250',
              textColor: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              top: 10,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
