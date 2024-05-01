import 'dart:io';

import 'package:open_file/open_file.dart' as open_file;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;
import 'controller/scan_data_controller.dart';
import 'controller/scanqecode_controller.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


class QrCodeData extends StatefulWidget {
  const QrCodeData({Key? key}) : super(key: key);

  @override
  State<QrCodeData> createState() => _QrCodeDataState();
}

class _QrCodeDataState extends State<QrCodeData> {
  //
  ScanCodeDataController scanCodeDataController =
      Get.put(ScanCodeDataController());

  // ScanCodeDataController scanCodeDataController =
  QrCodeScanController qrCodeScanController = Get.find();
  String?   allstring;


  // getPref() async {
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //      allstring = prefs.getString('favoriteQrList');
  //   });
  //
  //
  //   print("inistate==========${allstring}");
  // }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // String    formattedDate = DateFormat.yMMMMd().format(now);
    // print("formattedDate===================${formattedDate}");
    return
      Scaffold(
      // backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        // toolbarHeight: SizeUtils.verticalBlockSize * 10,
        elevation: 1,
        automaticallyImplyLeading: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back),),
        title: Text("QR Code Data"),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue,
                disabledForegroundColor: Colors.grey,
              ),
              onPressed: (){
                print("Check");
                generateExcel(
                    scanCodeDataController.scanData!.code.toString()
                );
              },
              child: const Text('Generate Excel'),
            )
          ],
        ),
      ),
     /* Column(
          children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 4),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4),
                  child: textRoboto("codeInformation", Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                // Center(
                //   child: RepaintBoundary(
                //     child:
                //     QrImageView(
                //         key: scanCodeDataController.
                ,
                //         //    data:scanCodeDataController.scanData!.code.toString(),
                //         data: scanCodeDataController.scanData!.code!,
                //         version: QrVersions.auto,
                //         size: 200),
                //   ),
                // ),
                SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textRoboto("scannedResult", Colors.black),
                      textRoboto("QR", Colors.blue),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textRoboto("element", Colors.black),
                      textRoboto(
                          scanCodeDataController.detectCategory(
                              scanCodeDataController.scanData!.code!),
                          Colors.blue),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textRoboto("data", Colors.black),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await scanCodeDataController.launchInBrowser(
                                Uri.parse(
                                    "${scanCodeDataController.scanData!.code}"));
                            //      launchURL(UrlData!);
                            //  scanCodeDataController.launchURL(scanCodeDataController.scanData!.code!.toString());

                            //  scanCodeDataController.launchURL(scanCodeDataController.scanData!.code!.toString());
                            print(
                                "scanData===========${scanCodeDataController.scanData!.code!}");
                            print(
                                "===========${scanCodeDataController.scanData!.code!}");
                          },
                          child: Obx(
                                () => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: scanCodeDataController.isCopy.value
                                      ? Colors.black
                                      : Colors.white),
                              child: Align(alignment:Alignment.centerRight ,
                                child: textRoboto(
                                    scanCodeDataController.scanData!.code!,
                                    Colors.blue
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Image.asset(AppImageAssets.deleteIcon,
                  //       height: SizeUtils.verticalBlockSize * 4),
                  // ),
                  GestureDetector(
                      onTap: () {
                        if (kDebugMode) {
                          print("copy");
                        }
                        String word = scanCodeDataController.scanData!.code!
                            .toString(); // Replace with your word
                        copyToClipboard(word);

                        scanCodeDataController.isCopy.value = true;
                        Future.delayed(const Duration(seconds: 1))
                            .then((value) {
                          scanCodeDataController.isCopy.value = false;
                        });
                      },
                      // child: Image.asset(AppImageAssets.copyIcon,
                      //     height: SizeUtils.verticalBlockSize * 4)
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 1,
        ),
        Obx(() => scanCodeDataController.isCopy.value
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:  1,
                      horizontal:  1),
                  child: textRoboto(
                      scanCodeDataController.isCopy.value ? "Copy" : "",
                      Colors.blue),
                ))
            : Container()),
      ]),*/
    );
  }

  Future<void> generateExcel_Old() async {
    print("Check 1");
    //Create a Excel document.

    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = false;

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();

    //Set data in the worksheet.
    sheet.getRangeByName('A1').columnWidth = 4.82;
    sheet.getRangeByName('B1:C1').columnWidth = 13.82;
    sheet.getRangeByName('D1').columnWidth = 13.20;
    sheet.getRangeByName('E1').columnWidth = 7.50;
    sheet.getRangeByName('F1').columnWidth = 9.73;
    sheet.getRangeByName('G1').columnWidth = 8.82;
    sheet.getRangeByName('H1').columnWidth = 4.46;

    sheet.getRangeByName('A1:H1').cellStyle.backColor = '#333F4F';
    sheet.getRangeByName('A1:H1').merge();
    sheet.getRangeByName('B4:D6').merge();

    sheet.getRangeByName('B4').setText('Invoice');
    sheet.getRangeByName('B4').cellStyle.fontSize = 32;

    sheet.getRangeByName('B8').setText('BILL TO:');
    sheet.getRangeByName('B8').cellStyle.fontSize = 9;
    sheet.getRangeByName('B8').cellStyle.bold = true;

    sheet.getRangeByName('B9').setText('Abraham Swearegin');
    sheet.getRangeByName('B9').cellStyle.fontSize = 12;

    sheet
        .getRangeByName('B10')
        .setText('United States, California, San Mateo,');
    sheet.getRangeByName('B10').cellStyle.fontSize = 9;

    sheet.getRangeByName('B11').setText('9920 BridgePointe Parkway,');
    sheet.getRangeByName('B11').cellStyle.fontSize = 9;

    sheet.getRangeByName('B12').setNumber(9365550136);
    sheet.getRangeByName('B12').cellStyle.fontSize = 9;
    sheet.getRangeByName('B12').cellStyle.hAlign = HAlignType.left;

    final Range range1 = sheet.getRangeByName('F8:G8');
    final Range range2 = sheet.getRangeByName('F9:G9');
    final Range range3 = sheet.getRangeByName('F10:G10');
    final Range range4 = sheet.getRangeByName('F11:G11');
    final Range range5 = sheet.getRangeByName('F12:G12');

    range1.merge();
    range2.merge();
    range3.merge();
    range4.merge();
    range5.merge();

    sheet.getRangeByName('F8').setText('INVOICE#');
    range1.cellStyle.fontSize = 8;
    range1.cellStyle.bold = true;
    range1.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F9').setNumber(2058557939);
    range2.cellStyle.fontSize = 9;
    range2.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F10').setText('DATE');
    range3.cellStyle.fontSize = 8;
    range3.cellStyle.bold = true;
    range3.cellStyle.hAlign = HAlignType.right;

    sheet.getRangeByName('F11').dateTime = DateTime(2020, 08, 31);
    sheet.getRangeByName('F11').numberFormat =
    r'[$-x-sysdate]dddd, mmmm dd, yyyy';
    range4.cellStyle.fontSize = 9;
    range4.cellStyle.hAlign = HAlignType.right;

    range5.cellStyle.fontSize = 8;
    range5.cellStyle.bold = true;
    range5.cellStyle.hAlign = HAlignType.right;

    final Range range6 = sheet.getRangeByName('B15:G15');
    range6.cellStyle.fontSize = 10;
    range6.cellStyle.bold = true;

    sheet.getRangeByIndex(15, 2).setText('Code');
    sheet.getRangeByIndex(16, 2).setText('CA-1098');
    sheet.getRangeByIndex(17, 2).setText('LJ-0192');
    sheet.getRangeByIndex(18, 2).setText('So-B909-M');
    sheet.getRangeByIndex(19, 2).setText('FK-5136');
    sheet.getRangeByIndex(20, 2).setText('HL-U509');

    sheet.getRangeByIndex(15, 3).setText('Description');
    sheet.getRangeByIndex(16, 3).setText('AWC Logo Cap');
    sheet.getRangeByIndex(17, 3).setText('Long-Sleeve Logo Jersey, M');
    sheet.getRangeByIndex(18, 3).setText('Mountain Bike Socks, M');
    sheet.getRangeByIndex(19, 3).setText('ML Fork');
    sheet.getRangeByIndex(20, 3).setText('Sports-100 Helmet, Black');

    sheet.getRangeByIndex(15, 3, 15, 4).merge();
    sheet.getRangeByIndex(16, 3, 16, 4).merge();
    sheet.getRangeByIndex(17, 3, 17, 4).merge();
    sheet.getRangeByIndex(18, 3, 18, 4).merge();
    sheet.getRangeByIndex(19, 3, 19, 4).merge();
    sheet.getRangeByIndex(20, 3, 20, 4).merge();

    sheet.getRangeByIndex(15, 5).setText('Quantity');
    sheet.getRangeByIndex(16, 5).setNumber(2);
    sheet.getRangeByIndex(17, 5).setNumber(3);
    sheet.getRangeByIndex(18, 5).setNumber(2);
    sheet.getRangeByIndex(19, 5).setNumber(6);
    sheet.getRangeByIndex(20, 5).setNumber(1);

    sheet.getRangeByIndex(15, 6).setText('Price');
    sheet.getRangeByIndex(16, 6).setNumber(8.99);
    sheet.getRangeByIndex(17, 6).setNumber(49.99);
    sheet.getRangeByIndex(18, 6).setNumber(9.50);
    sheet.getRangeByIndex(19, 6).setNumber(175.49);
    sheet.getRangeByIndex(20, 6).setNumber(34.99);

    sheet.getRangeByIndex(15, 7).setText('Total');
    sheet.getRangeByIndex(16, 7).setFormula('=E16*F16+(E16*F16)');
    sheet.getRangeByIndex(17, 7).setFormula('=E17*F17+(E17*F17)');
    sheet.getRangeByIndex(18, 7).setFormula('=E18*F18+(E18*F18)');
    sheet.getRangeByIndex(19, 7).setFormula('=E19*F19+(E19*F19)');
    sheet.getRangeByIndex(20, 7).setFormula('=E20*F20+(E20*F20)');
    sheet.getRangeByIndex(15, 6, 20, 7).numberFormat = r'$#,##0.00';

    sheet.getRangeByName('E15:G15').cellStyle.hAlign = HAlignType.right;
    sheet.getRangeByName('B15:G15').cellStyle.fontSize = 10;
    sheet.getRangeByName('B15:G15').cellStyle.bold = true;
    sheet.getRangeByName('B16:G20').cellStyle.fontSize = 9;

    sheet.getRangeByName('E22:G22').merge();
    sheet.getRangeByName('E22:G22').cellStyle.hAlign = HAlignType.right;
    sheet.getRangeByName('E23:G24').merge();

    final Range range7 = sheet.getRangeByName('E22');
    final Range range8 = sheet.getRangeByName('E23');
    range7.setText('TOTAL');
    range7.cellStyle.fontSize = 8;
    range8.setFormula('=SUM(G16:G20)');
    range8.numberFormat = r'$#,##0.00';
    range8.cellStyle.fontSize = 24;
    range8.cellStyle.hAlign = HAlignType.right;
    range8.cellStyle.bold = true;

    sheet.getRangeByIndex(26, 1).text =
    '800 Interchange Blvd, Suite 2501, Austin, TX 78721 | support@adventure-works.com';
    sheet.getRangeByIndex(26, 1).cellStyle.fontSize = 8;

    final Range range9 = sheet.getRangeByName('A26:H27');
    range9.cellStyle.backColor = '#ACB9CA';
    range9.merge();
    range9.cellStyle.hAlign = HAlignType.center;
    range9.cellStyle.vAlign = VAlignType.center;

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
    print("Check 2");
    File('Invoice.xlsx').writeAsBytes(bytes);

    //Save and launch the file.
    await saveAndLaunchFile(bytes, 'Invoice.xlsx');
  }


  // var multiLineString = "${scanCodeDataController.scanData!.code.toString()}";
 /* '''
D40290223 24594 1 0.060 SFDMAK MIX 4120 200.00
D40290323 24594 1 0.040 SFDMAK MIX 4120 200.00
D40290423 24594 1 0.040 SFDMAK MIX 4120 200.00
D40290523 24594 1 0.070 SFDMAK MIX 4120 300.00
D40290623 24594 1 0.050 SFDMAK MIX 4120 200.00
D40290723 24594 1 0.050 SFDMAK MIX 4120 200.00
D40290823 24594 1 0.080 SFDMAK MIX 4120 300.00
D40290923 24594 1 0.050 SFDMAK MIX 4120 200.00
D40291023 24594 1 0.070 SFDMAK MIX 4120 300.00
''';*/
  Future<void> generateExcel(String string) async {
    print("Check 1");
    //Create a Excel document.

    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = true;

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();

    //Set data in the worksheet.
    var dataArray = string.trim().split('\n');
    print(dataArray);



     sheet.getRangeByName('A1').columnWidth = 20.30;

    // sheet.getRangeByName('B1').columnWidth = 4.82;
    // sheet.getRangeByName('C1').columnWidth = 4.82;
    // sheet.getRangeByName('D1').columnWidth = 4.82;
    // sheet.getRangeByName('E1').columnWidth = 4.82;
    // sheet.getRangeByName('F1').columnWidth = 4.82;
    // sheet.getRangeByName('G1').columnWidth = 4.82;
    // sheet.getRangeByName('H1').columnWidth = 4.82;

    for(int i = 0; i < dataArray.length; i++){
      print("pos = "+i.toString());
      print(dataArray[i]);
      sheet.getRangeByIndex(i+1, 1).setText(dataArray[i].split("\t")[0]);
      sheet.getRangeByIndex(i+1, 2).setValue(dataArray[i].split("\t")[1]);
      sheet.getRangeByIndex(i+1, 3).setValue(dataArray[i].split("\t")[2]);
      sheet.getRangeByIndex(i+1, 4).setValue(dataArray[i].split("\t")[3]);
      sheet.getRangeByIndex(i+1, 5).setValue(dataArray[i].split("\t")[4]);
      sheet.getRangeByIndex(i+1, 6).setValue(dataArray[i].split("\t")[5]);
      sheet.getRangeByIndex(i+1, 7).setValue(dataArray[i].split("\t")[6]);
      sheet.getRangeByIndex(i+1, 8).setValue(dataArray[i].split("\t")[7]);
    }
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
    print("Check 2");
  //  File('Invoicesss.xlsx').writeAsBytes(bytes);

    //Save and launch the file.
     await saveAndLaunchFile(bytes, 'Invoice.xlsx');
  }
  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    //Get the storage folder location using path_provider package.
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory =
      await path_provider.getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file =
    File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
    print("Path = "+file.path.toString());
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      //Launch the file (used open_file package)
      await open_file.OpenFile.open('$path/$fileName');
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'], runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }

  Widget textRoboto(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: color),
    );
  }

  void copyToClipboard(String word) {
    Clipboard.setData(ClipboardData(text: word));
  }

  favoriteqr() {
    //  print("fomatedate=============${scanCodeDataController.formattedDate.value}");
    // print("selectqr");
    // FavoriteQrModel favoriteQrModel=FavoriteQrModel(qrCreateLink: scanCodeDataController.scanData!.code,qrDataLink:scanCodeDataController.scanData!.code,
    //     qrCategoryTypes:  scanCodeDataController.detectCategory(
    //         scanCodeDataController.scanData!.code!), qrCodeString: "QR",qrCodeTimes:scanCodeDataController.formattedDate.value );
  }

  unSelectqr() {
    // print("unSelectqr");
  }
}
