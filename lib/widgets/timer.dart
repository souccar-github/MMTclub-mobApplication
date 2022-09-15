import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Localization/localization.dart';
import '../styles/app_colors.dart';

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
    setState(() {
      running = false;
    });
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (running)
            Center(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: AppColors.basicColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.clock,
                        color: AppColors.textWhite,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (timeLeft.split(":")[1] +
                                  ":" +
                                  timeLeft.split(":")[2])
                              .split(".")[0],
                          style: TextStyle(color: AppColors.textWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (!running)
            Center(
              child: TextButton(
                onPressed: () {
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
                  style: TextStyle(
                    color: AppColors.textBlack,
                    textBaseline: TextBaseline.ideographic,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
