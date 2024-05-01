import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
class ScanCodeDataController extends GetxController {
  Barcode? scanData;
  String? code;
  RxBool isCopy = false.obs;
  RxBool isFavorite = false.obs;
  RxString formattedDate = ''.obs;
  RxBool isScandata=false.obs;
 // RxList<FavoriteQrModel> favoriteQrList = <FavoriteQrModel>[].obs;
 //  var favoriteQrList = <FavoriteQrModel>[].obs;
  //String? result;
  GlobalKey qrCodeKey = GlobalKey();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
print("pppppppppppppppppppppppppppppppppppppp");
    //  result = Get.arguments;

    scanData = Get.arguments;
    // getCurrentDate();
    // getFavoriteQrListFromSharedPreferences();
    //loadFavoriteQrList();

    List<String> ids = scanData!.code!.split(':');

    String userId = ids[0];
    String clientId = ids[1];
    print("checkckckckckcSalonID${userId}");
    print("checkckckckckcBArberID${clientId}");

        print("scandata=======${scanData}");
        print("scandata=======${scanData!.code!.split(':')}");
        print("scandata=======${scanData?.code??"not get argument"}");
    //  print("resuluinistate============${result}");
    // print("resuluinistate=======${scanData!.code}");

    //  print("scancode type=====${describeEnum(scanData!.format.formatName)}");
    //   print("scancode type data=====${describeEnum(scanData!.format.formatName)}");
    //  print("scancode type data name=====${describeEnum(scanData!.format.name)}");
  }
  /*getFavoriteQrListFromSharedPreferences() async {

    print("scandata11");
    // Obtain shared preferences.
     SharedPreferences prefs = await SharedPreferences.getInstance();

    print("scandata22");
    final favoriteQrListJson = prefs.getString('favoriteQrListKey');
    print("scandata33");
    if (favoriteQrListJson != null) {
      print("scandata44");
      final List<dynamic> decodedList = json.decode(favoriteQrListJson);
      print("scandata55");
      favoriteQrList.value = decodedList.map((item) => FavoriteQrModel.fromJson(item)).toList().cast<FavoriteQrModel>();
      print("scandata66");
      print("favoriteQrLength==========${favoriteQrList.length}");
      print("favoriteQrList==========${favoriteQrList[0].qrDataLink}");
    } else {
      print("scandata77");
      favoriteQrList.value = [];
    }

  }*/


  String detectCategory(String result) {
    // Check if the data matches an email pattern
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (emailRegex.hasMatch(result)) {
      return 'gmail';
    }

    // Check if the data matches a phone number pattern
    final phoneRegex = RegExp(
        r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');
    if (phoneRegex.hasMatch(result)) {
      return 'Phone Number';
    }

    // msg

    // final  messageRegex = RegExp(r'[a-zA-Z]+');
    // if (messageRegex.hasMatch(result)) {
    //   return 'message';
    // }

    // Regular expression pattern for website URL validation
    // final websiteRegex = RegExp(
    //   r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
    // );
    //
    // if (websiteRegex.hasMatch(result)) {
    //   return 'website';
    // }

// Text
    final RegExp alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    if (alphanumericRegex.hasMatch(result)) {
      return 'Text';
    }

    //AppStore
    final RegExp appStoreRegex = RegExp(
      r'^(https?:\/\/)?(apps\.apple\.com\/[a-zA-Z]{2}-[a-zA-Z]{2}\/app\/)([a-zA-Z0-9]+)(\/.*)?$',
    );
    if (appStoreRegex.hasMatch(result)) {
      return 'AppStore';
    }
//GoogleDrive
    final RegExp googleDriveRegex = RegExp(
      r'^(https?:\/\/)?(drive\.google\.com\/file\/d\/)([a-zA-Z0-9_-]+)(\/.*)?$',
    );
    if (googleDriveRegex.hasMatch(result)) {
      return 'GoogleDrive';
    }

    // Wifi
    final RegExp wifiSSIDRegex = RegExp(r'^[A-Za-z0-9_-]{1,32}$');

    if (wifiSSIDRegex.hasMatch(result)) {
      return 'wifi';
    }

    // Location

    final RegExp locationRegex = RegExp(r'^[A-Za-z\s,-]+$');
    if (locationRegex.hasMatch(result)) {
      return 'Location';
    }

//Twitter
    final RegExp twitterUsernameRegex = RegExp(r'^@?[A-Za-z0-9_]{1,15}$');
    if (twitterUsernameRegex.hasMatch(result)) {
      return 'Twitter';
    }

//Facebook
    final RegExp facebookUsernameRegex = RegExp(r'^[a-zA-Z0-9.]{5,}$');

    if (facebookUsernameRegex.hasMatch(result)) {
      return 'Facebook';
    }

// Instagram
    final RegExp instagramUsernameRegex = RegExp(r'^[a-zA-Z0-9._]{1,30}$');

    if (instagramUsernameRegex.hasMatch(result)) {
      return 'Instagram';
    }

    //whatsapp

    final RegExp whatsappPhoneRegex = RegExp(r'^\+[1-9]\d{1,14}$');
    if (whatsappPhoneRegex.hasMatch(result)) {
      return 'Whatsapp';
    }

//youtube
    final RegExp youtubeUrlRegex = RegExp(
        '(?:youtu\\.be\\/|youtube(?:-nocookie)?\\.com\\/(?:embed\\S*\\?\\S*v=|v\\/|watch\\?\\S*v=|\\S*\\/|\\S*\\#\\S*v=))([a-zA-Z0-9_-]{11})');
    // r'^https?:\/\/(?:www\.)?youtube\.com\/watch\?v=[a-zA-Z0-9_-]{11}$');
    if (youtubeUrlRegex.hasMatch(result)) {
      return 'Youtube';
    }

//pinterest
    final RegExp pinterestUrlRegex = RegExp(
        r'^https?:\/\/(?:www\.)?pinterest\.[a-zA-Z]{2,}\/[a-zA-Z0-9_-]+$');

    if (pinterestUrlRegex.hasMatch(result)) {
      return 'pinterest';
    }

// spotify
    final RegExp spotifyUrlRegex = RegExp(
        r'^https?:\/\/(?:open\.)?spotify\.com\/(?:user\/[a-zA-Z0-9_-]+\/)?(playlist|track|album|artist)\/[a-zA-Z0-9]+');
    if (spotifyUrlRegex.hasMatch(result)) {
      return 'spotify';
    }

//soundCloud
    final RegExp soundCloudUrlRegex = RegExp(
        r'^https?:\/\/(?:www\.)?soundcloud\.com\/[a-zA-Z0-9_-]+\/[a-zA-Z0-9_-]+$');
    if (soundCloudUrlRegex.hasMatch(result)) {
      return 'soundCloud';
    }

    final websiteRegex = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
    );

    if (websiteRegex.hasMatch(result)) {
      return 'website';
    }

    // Default to unknown category if neither email nor phone number pattern matches
    return 'Unknown Category';
  }

  // void openWebsite(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  final List<String> linesOfText = [
    //$result,
  ];

  launchInBrowser(Uri parse) {}

  // shareContent(String apkLink) {
  //   final content = '''
  //   APK Link: $apkLink
  //
  //   ${linesOfText.join('\n')}
  //   ''';
  //   Share.share(content);
  // }

  // final Uri url = Uri.parse('${scanData?.code}');
  //
  // Future<void> launchInBrowser(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  // Future<void> launchInBrowser(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  // void getCurrentDate() {
  //   DateTime now = DateTime.now();
  //   String date = DateFormat.yMMMMd().format(now);
  //   formattedDate.value = date;
  // }


  // void loadFavoriteQrList() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String? favoriteQrListJson = prefs.getString('favoriteQrList');
  //     if (favoriteQrListJson != null) {
  //       final decodedData = json.decode(favoriteQrListJson);
  //       if (decodedData is List) {
  //         favoriteQrList.assignAll(decodedData
  //             .map((item) => FavoriteQrModel.fromJson(item))
  //             .toList());
  //         for(int i=0;i<favoriteQrList.length;i++)
  //         {
  //
  //           print("load data===================================================${favoriteQrList[i].qrCreateLink}");
  //
  //         }
  //
  //       }
  //     }
  //   } catch (e) {
  //     print('Error loading favorite QR list: $e');
  //   }
  // }
//   Future<void> favoriteqr(FavoriteQrModel favoriteQr) async {
//     favoriteQrList.add(favoriteQr);
// print("favoriteQrList[0].qrDataLink======${favoriteQrList[0].qrDataLink}");

    // await saveFavoriteQrList(favoriteQrList);
    // // favoriteQr=FavoriteQrModel(qrCreateLink: scanData!.code,qrDataLink:scanData!.code,
    // //     qrCategoryTypes: detectCategory(
    // //         scanData!.code!), qrCodeString: "QR",qrCodeTimes:formattedDate.value );
    // // Save the updated favoriteQrList to SharedPreferences
    // // Save the updated favoriteQrList to SharedPreferences
    // //await saveFavoriteQrList(favoriteQrList);
    // for(int i=0;i<favoriteQrList.length;i++)
    //   {
    //
    //     print("favoriteQrListqrDataLink${i}=====${favoriteQrList[i].qrDataLink}");
    //
    //   }
   // print("favoriteQrListqrDataLink${0}=====${favoriteQrList[0].qrDataLink}");
  }
  // Future<void> saveFavoriteQrListInSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final favoriteQrListJson = json.encode(favoriteQrList.value.map((item) => item.toJson()).toList());
  //   prefs.setString('favoriteQrListKey', favoriteQrListJson);
  // }
  ///
  //  saveFavoriteQrList(RxList<FavoriteQrModel> favoriteQrList) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final encodedData = json.encode(favoriteQrList.toList());
  //     print("savefavoriteqrlist=========${encodedData}");
  //    bool setpref= await prefs.setString('favoriteQrList', encodedData);
  //  String?   allstring = prefs.getString('favoriteQrList');
  //
  //  print("allString===========${allstring}");
  //
  //    print("setpref==============${setpref}");
  //   } catch (e) {
  //     print('Error saving favorite QR list: $e');
  //   }
  // }
  ///
  // Future<void> saveFavoriteQrList(List<FavoriteQrModel> favoriteQrList) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final encodedData = json.encode(favoriteQrList.toList());
  //   await prefs.setString('favoriteQrList', encodedData);
  //   // final String? favoriteQrListJson = prefs.getString('favoriteQrList');
  //   // final decodedData = json.decode(favoriteQrListJson!);
  //   // final listis=favoriteQrList
  //   // await prefs.setString('favoriteQrListKey',favoriteQrList );
  //
  //
  // }



  // favoriteqr() {
  //   print("fomatedate=============${formattedDate.value}");
  //   print("selectqr");
  //   FavoriteQrModel favoriteQrModel=FavoriteQrModel(qrCreateLink: scanData!.code,qrDataLink:scanData!.code,
  //       qrCategoryTypes: detectCategory(
  //           scanData!.code!), qrCodeString: "QR",qrCodeTimes:formattedDate.value );
  //
  //   print("favoriteQrModel==============${favoriteQrModel.qrCodeString}");
  //   print("favoriteQrModel==============${favoriteQrModel.qrCreateLink}");
  //   print("favoriteQrModel==============${favoriteQrModel.qrDataLink}");
  //   print("favoriteQrModel==============${favoriteQrModel.qrCodeTimes}");
  //   print("favoriteQrModel==============${favoriteQrModel.qrCategoryTypes}");
  // }

  unSelectqr() {
    print("unSelectqr");
  }

// void launchURL(String url) async {
//   if (url != null && await  canLaunchUrl(Uri())) {
//     await  launchUrl(Uri());
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// void launchURL(String url) async {
//   if (await canLaunchUrl(Uri(path: url))) {
//     await launchUrl(Uri(path: url));
//   } else {
//     throw 'Could not launch $url';
//   }
// }

