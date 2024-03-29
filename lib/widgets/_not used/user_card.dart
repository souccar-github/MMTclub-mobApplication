import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCard extends StatelessWidget {
  final String? username;
  final String? mobile;
  const UserCard({
    Key? key,
    this.username,
    this.mobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      width: 300.w,
      child: NeumorphicButton(
        margin: EdgeInsets.only(top: 12.h),
        onPressed: () {},
        style: NeumorphicStyle(
          color: const Color(0xff00a5a0),
          shadowDarkColor: Colors.black,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16.0)),
          // border: const NeumorphicBorder(
          //     //color: Colors.white54,
          //     ),
        ),
        padding:
            EdgeInsets.only(top: 30.h, right: 12.w, left: 12.w, bottom: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // CircleAvatar(
            //   backgroundColor: AppColors.textWhite,
            //   child: InkWell(
            //       // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            //       child: FaIcon(
            //         FontAwesomeIcons.user,
            //         color: AppColors.basicColor,
            //       ),
            //       onTap: () {}),
            // ),
            // SizedBox(
            //   width: 20.0.w,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                username == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Username: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              username ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                mobile == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Phone Number: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              mobile ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
