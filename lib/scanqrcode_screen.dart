import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'controller/scanqecode_controller.dart';

class ScanQrCodeScreen extends StatelessWidget {
  ScanQrCodeScreen({Key? key}) : super(key: key);

 final QrCodeScanController qrCodeScanController = Get.put(QrCodeScanController());

  QRViewController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 20,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text("Scan QR Code"),
          actions: [
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         qrCodeScanController.controller!.toggleFlash();
            //       },
            //       child: Image.asset(AppImageAssets.flash,
            //           height: SizeUtils.verticalBlockSize * 7),
            //     ),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 3),
                //   child: GestureDetector(onTap: ()  async {
                //     print("imageopick");
                //     qrCodeScanController.pickImageFromGallery();
                //
                //   },
                //     child: Image.asset(
                //       AppImageAssets.gallery,
                //       height: SizeUtils.verticalBlockSize * 7,
                //     ),
                //   ),
                // ),
            //   ],
            // )
          ]),
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrCodeScanController.qrKey,
              onQRViewCreated: qrCodeScanController.onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: Colors.blue,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.75,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
