import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key, required this.title});
  final String title;
  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  String deviceName = "",
      model = "",
      brand = "",
      device = "",
      hardware = "",
      display = "",
      serialNum = "",
      iD = "",
      manuacturer = "";

  String androidId = "";
  String error = "";
  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    const androidIdPlugin = AndroidId();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        String? id = await androidIdPlugin.getId() ?? 'Unknown ID';
        setState(() {
          deviceName = build.model;
          model = build.model;
          brand = build.brand;
          device = build.device;
          hardware = build.hardware;
          display = build.display;
          serialNum = build.serialNumber;
          manuacturer = build.manufacturer;
          iD = build.id;
          //A id
          androidId = id;
        });
      } else if (Platform.isIOS) {
        // deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      error = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Platform.isAndroid ? "Android Device Info" : "iOS Device Info",
          style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SingleSquare(
                        value: androidId,
                        text: "Android ID",
                        img: "assets/androidId.png"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SquareWidget(
                            value: model,
                            text: "Model",
                            img: "assets/model.png"),
                        SquareWidget(
                          value: brand,
                          text: "Brand",
                          img: "assets/version.png",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleWidget(
                            img: "assets/hardware.jpeg",
                            text: "Hardware",
                            value: hardware),
                        CircleWidget(
                            img: "assets/device.jpeg",
                            text: "Device",
                            value: device),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleSquare(value: iD, text: "ID", img: "assets/rel.png"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SquareWidget(
                            value: manuacturer,
                            text: "Manuacture",
                            img: "assets/manu.jpeg"),
                        SquareWidget(
                          value: serialNum,
                          text: "Serial No",
                          img: "assets/serial.jpeg",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleSquare(
                      value: display,
                      text: "Display",
                      img: "assets/display.jpeg",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //),
    );
  }
}

class SingleSquare extends StatelessWidget {
  const SingleSquare(
      {super.key, required this.text, required this.img, required this.value});
  final String img;
  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // color: Colors.amber,
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(100)),
                child: Image.asset(
                  img, // "",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 80,
              color: Colors.green,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text, // "Android ID",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SelectableText(
                  value, // androidId,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SquareWidget extends StatelessWidget {
  const SquareWidget({
    super.key,
    required this.img,
    required this.text,
    required this.value,
  });

  final String text;
  final String value;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        height: 80,
        width: 140,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    img, // "assets/model.png",
                    fit: BoxFit.fill,
                    //color: Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 30,
                  width: 2,
                  color: Colors.green,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  text, //"Model",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.greenAccent,
            ),
            SelectableText(
              value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  const CircleWidget({
    super.key,
    required this.img,
    required this.text,
    required this.value,
  });

  final String img;
  final String text;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                    //color: Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.greenAccent,
          ),
          SelectableText(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
