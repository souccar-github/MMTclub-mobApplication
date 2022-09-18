import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Localization/localization.dart';
import '../styles/app_colors.dart';
import '../widgets/custom_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("changePassword"),
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textBlack,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textBlack,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                Localization.of(context).getTranslatedValue("changePassword"),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: newPasswordController,
                        cursorColor: AppColors.basicColor,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 13.w),
                          labelText: Localization.of(context)
                              .getTranslatedValue("newPassword"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(),
                          //border: OutlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 13.w),
                          labelText: Localization.of(context)
                              .getTranslatedValue("confirmPassword"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: Localization.of(context).getTranslatedValue("send"),
                onPressed: () {},
                icon: FontAwesomeIcons.paperPlane,
                size: 20.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
