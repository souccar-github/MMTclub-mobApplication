import 'dart:developer';
import 'dart:io';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mmt_club/Localization/localization.dart';
import 'package:mmt_club/bloc/qrCodeBloc/qrcode_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../pages/home_page.dart';
import '../styles/app_colors.dart';

class QRWidget extends StatefulWidget {
  const QRWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRWidgetState();
}

class _QRWidgetState extends State<QRWidget> {
  Barcode? result;
  QRViewController? controller;
  bool flashOn = false;
  bool pop = true;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  final QrcodeBloc qrcodeBloc = QrcodeBloc();
  @override
  Widget build(BuildContext context) {
    if (result != null) {
      controller!.pauseCamera();
      //log(result!.code.toString());
      String? code = result!.code;
      if (code != null && code.isNotEmpty) {
        //Navigator.pop(context);
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => DefaultBottomBarController(child: HomePage())),
        // );

        qrcodeBloc.add(SendQrcodeEvent(code));
        //DefaultBottomBarController.of(context).close();
      }
    }

    final waitingAlert = Alert(
      context: context,
      type: AlertType.info,
      buttons: [],
      desc: Localization.of(context).getTranslatedValue("please_wait"),
      content: const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final successAlert = Alert(
      context: context,
      type: AlertType.success,
      desc: Localization.of(context)
          .getTranslatedValue("your_qrcode_has_been_scanned"),
      buttons: [
        DialogButton(
          child: Text(
            Localization.of(context).getTranslatedValue("go_to_home"),
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            result = null;
            _finish();
          },
          width: 120,
        )
      ],
    );
    errorAlert(message) {
      return Alert(
        context: context,
        type: AlertType.error,
        desc: Localization.of(context)
            .getTranslatedValue("check_your_connection"),
        buttons: [
          DialogButton(
            child: Text(
              Localization.of(context).getTranslatedValue("go_to_home"),
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              result = null;
              _finish();
            },
            width: 120,
          )
        ],
      );
    }

    return BlocListener(
      bloc: qrcodeBloc,
      listener: (context, state) {
        if (state is ReadQrcodeWaiting) {
          waitingAlert.show();
        } else if (state is ReadQrcodeSuccessfully) {
          waitingAlert.dismiss();
          successAlert.show();
        } else if (state is ReadQrcodeError) {
          waitingAlert.dismiss();
          if (state.error.code == 3) {
            errorAlert(Localization.of(context)
                    .getTranslatedValue("already_taken"))
                .show();
          } else {
            errorAlert(Localization.of(context)
                    .getTranslatedValue("check_your_connection"))
                .show();
          }
        }
      },
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      )),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: AppColors.expandedBackColor,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width / 2.5,
            child: IconButton(
              onPressed: () {
                controller!.toggleFlash();
                setState(() {
                  flashOn = !flashOn;
                });
              },
              icon: Icon(
                flashOn ? Icons.flash_on : Icons.flash_off_outlined,
                color: AppColors.expandedBackColor,
              ),
            )),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    qrcodeBloc.close();
    super.dispose();
  }

  void _finish() {
    //controller?.dispose();
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => DefaultBottomBarController(child: HomePage())),
    );
  }
}
