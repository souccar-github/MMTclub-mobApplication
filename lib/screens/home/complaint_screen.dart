import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/Models/Project/complaint_model.dart';
import 'package:mmt_club/bloc/complaintBloc/complaint_bloc.dart';
import 'package:mmt_club/styles/app_text.dart';
import 'package:mmt_club/widgets/my_toast.dart';

import '../../Localization/localization.dart';
import '../../styles/app_colors.dart';
import '../../widgets/custom_button.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final ComplaintBloc complaintBloc = ComplaintBloc();
  late TextEditingController titleController;
  late TextEditingController bodyController;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    bodyController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
    complaintBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("FeedBack"),
          style: AppTextStyle.appBarTextTheme(context),
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
        padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 4.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text(
              //   Localization.of(context).getTranslatedValue("FeedBack") + " :",
              //   style: const TextStyle(
              //     //fontSize: 13.0.h,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              BlocListener(
                bloc: complaintBloc,
                listener: (context, state) {
                  if (state is SendComplaintSuccessfully) {
                    titleController.clear();
                    bodyController.clear();

                    MyToast.show(
                        context: context,
                        text: Localization.of(context)
                            .getTranslatedValue("thanks_for_compliment_reply"),
                        toastState: ToastState.SUCCESS);
                  } else if (state is SendComplaintError) {
                    MyToast.show(
                        context: context,
                        text: Localization.of(context)
                            .getTranslatedValue("try_again"),
                        toastState: ToastState.ERROR);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          cursorHeight: 25,
                          cursorColor: AppColors.basicColor,
                          decoration: InputDecoration(
                            hintText: Localization.of(context)
                                .getTranslatedValue("title"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                          maxLines: 1,
                        ),
                        SizedBox(height: 5.h),
                        TextField(
                          controller: bodyController,
                          cursorHeight: 25,
                          cursorColor: AppColors.basicColor,
                          decoration: InputDecoration(
                            hintText: Localization.of(context)
                                    .getTranslatedValue("body") +
                                "....",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                          maxLines: 10,
                        ),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder(
                bloc: complaintBloc,
                builder: (context, state) {
                  if (state is SendComplaintWaiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return CustomButton(
                    text: Localization.of(context).getTranslatedValue("send"),
                    onPressed: () {
                      complaintBloc.add(SendComplaintEvent(ComplaintModel(
                          titleController.text, bodyController.text)));
                    },
                    icon: FontAwesomeIcons.paperPlane,
                    size: 20.h,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
