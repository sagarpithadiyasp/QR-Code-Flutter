import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../qrcode_data.dart';

class QrCodeScanController extends GetxController {
  RxString img = "".obs;
  QRViewController? controller;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  RxBool resume = false.obs;
  String result = "";
  String imageString = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _requestCameraPermission();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Resume the camera when the app is resumed

      controller!.resumeCamera();

      onQRViewCreated(controller!);
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (status.isDenied) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Camera Permission'),
          content: const Text(
              'Please grant camera permission to use the QR scanner.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void disposeScanner() {
    controller?.dispose();
  }

  // void pickImageFromGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   img.value = image!.path;
  //
  //   print("++++++++++++++++++++${imageString}");
  //   print("========================${img.value}");
  //   scanQRCodeFromImage();
  // }

  Future<void> scanQRCodeFromImage() async {
    // Implement QR code decoding from image
    try {
      print("scanImage");

      print("++++++++++++++${result}");

      controller?.pauseCamera();
      Get.to(QrCodeData());
    } catch (e, st) {
      print('Failed to scan QR code from image: $e');

      print("statement===============${st}");
    }
  }

  onQRViewCreated(QRViewController controller) {
    print("okokokokokok");
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Handle scanned QR code data
      print("okcode");

      // scanData.format.formatName;

       print("barcode types======${describeEnum(scanData!.format)} ");
      //

      print("scandata====${scanData.code}");
      print("datatypesstring==================${scanData.format.toString()}");
       print("formate data formate name======${scanData.format.formatName}");
       // scanData.code;
      // result = scanData.code!;
      // print("result========${result}");
      print('datatypes======${scanData.code}');

      if (scanData.code!.isNotEmpty) {
        controller.pauseCamera();

        print("====================${controller.dispose}");
        Get.to(QrCodeData(),arguments: scanData)!.then((value){
          didChangeAppLifecycleState(AppLifecycleState.resumed);
        });
        // Get.toNamed(Routes.qrCodeData, arguments:
        // scanData)!.then((value) {
        //   didChangeAppLifecycleState(AppLifecycleState.resumed);
        // });
      } else {
        onQRViewCreated;
      }
    });
  }
}
