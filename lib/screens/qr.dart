import 'dart:developer';
import 'dart:io';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mmt_club/Localization/Localization.dart';
import 'package:mmt_club/bloc/qrCodeBloc/qrcode_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../styles/app_colors.dart';
import 'home_page.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  bool flashOn = false;

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
      String code = result!.code ?? "";
      if (code.isNotEmpty) {
        qrcodeBloc.add(SendQrcodeEvent(code));
      }
    }

    return BlocListener(
      bloc: qrcodeBloc,
      listener: (context, state) {
        if (state is ReadQrcodeSuccessfully) {
          Alert(
            context: context,
            type: AlertType.success,

            //title: Localization.of(context).getTranslatedValue("Notice"),
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
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DefaultBottomBarController(child: HomePage())),
                  );
                },
                width: 120,
              )
            ],
          ).show();
        } else if (state is ReadQrcodeError) {
          if (state.error.code == 3) {
            Alert(
              context: context,
              type: AlertType.info,
              //title: Localization.of(context).getTranslatedValue("Notice"),
              desc: state.error.message,
              buttons: [
                DialogButton(
                  child: Text(
                    Localization.of(context).getTranslatedValue("go_to_home"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    result = null;
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DefaultBottomBarController(child: HomePage())),
                    );
                  },
                  width: 120,
                )
              ],
            ).show();
          } else {
            Alert(
              context: context,
              type: AlertType.error,
              //title: Localization.of(context).getTranslatedValue("Notice"),
              desc: state.error.message,
              buttons: [
                DialogButton(
                  child: Text(
                    Localization.of(context).getTranslatedValue("go_to_home"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    result = null;
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DefaultBottomBarController(child: HomePage())),
                    );
                  },
                  width: 120,
                )
              ],
            ).show();
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
    super.dispose();
  }
}
