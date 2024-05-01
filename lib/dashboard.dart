import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrcode/scanqrcode_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Get.to(ScanQrCodeScreen());
          },
          child: Text("Scan QR"),
        ),
      ),
    );
  }
}
