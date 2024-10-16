import 'package:doctor_app/core/color_utils.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:flutter/material.dart';
class ReachScreen extends StatelessWidget {
  const ReachScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppScaffold(
      left: 0,
      right: 0,
      appBar: commonAppBar(),
      child: Container(
        width: size.width,
        color: colorGreen,
        height: size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              setAssetImage(image: icLoginLogo, width: size.width * 0.5),
              SizedBox(height: size.height*0.15,),
              CommonTextWidget(
                text: "Practo Reach",
                textColor: Colors.white,
                fontSize: 23,
              ),

              CommonTextWidget(
                top: 15,
                text:
                "Increase the visibility of your practice amongst\n millions of patients on Practo",
                textColor: Colors.white,
                fontSize: 16,
                textAlign: TextAlign.center,
                lineHeight: 1.5,
              ),
              CommonButtonWidget(
                colorButton: Colors.white,
                colorText: colorGreen,
                radius: 2,

                fontWeight: FontWeight.w600,
                top: 35,
                width: size.width*0.6,
                text: "Get Practo Reach".toUpperCase(),)
            ],
          ),
        ),
      ),
    );
  }
}
