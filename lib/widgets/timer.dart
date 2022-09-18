import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Localization/localization.dart';
import '../styles/app_colors.dart';
import '../styles/app_text.dart';

class Timer extends StatefulWidget {
  final VoidCallback? onTap;
  final int? minutes;
  const Timer({Key? key, this.onTap, this.minutes}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  String timeLeft = "";
  String time = "";
  bool running = true;
  int m = 1;
  late DateTime target = DateTime.now().add(Duration(minutes: m));

  @override
  void initState() {
    super.initState();
    if (widget.minutes != null) {
      m = widget.minutes!;
    }
    setTaget();
    executeTimer();
  }

  @override
  void dispose() {
    running = false;
    super.dispose();
  }

  setTaget() async {
    target = DateTime.fromMillisecondsSinceEpoch(m);

    if (target.isBefore(DateTime.now())) {
      target = DateTime.now().add(Duration(minutes: m));
    }
  }

  void executeTimer() async {
    while (running) {
      setState(() {
        if (DateTime.now().isAfter(target)) {
          running = false;
        } else {
          timeLeft = target.difference(DateTime.now()).toString();
        }
      });
      if (running) {
        await Future.delayed(const Duration(seconds: 1), () {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (running)
          Row(
            //mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 50.w,
                child: Text(
                  (timeLeft.split(":")[1] + ":" + timeLeft.split(":")[2])
                      .split(".")[0],
                  style: AppTextStyle.labelText2Theme(context),
                ),
              ),
              Icon(
                Icons.timer_outlined,
                color: AppColors.textBlack,
              ),
            ],
          ),
        if (!running)
          InkWell(
            onTap: () {
              setState(() {
                running = true;
                setTaget();
                executeTimer();
              });
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            child: Text(
              Localization.of(context).getTranslatedValue("Retry"),
              style: AppTextStyle.labelText2Theme(context).copyWith(
                textBaseline: TextBaseline.ideographic,
              ),
            ),
          ),
      ],
    );
  }
}
