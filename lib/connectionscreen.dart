import 'dart:io';

import 'package:alivpn/model/vpnmodel.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

class ConnectionScreen extends StatefulWidget {
  VPNModel contentList;
  ConnectionScreen(this.contentList, {Key? key}) : super(key: key);

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  var contentList;
  late OpenVPN openvpn;
  OpenVPN engine = OpenVPN();
  VpnStatus? status;
  VPNStage? stage;
  bool _granted = false;

  static const String defaultVpnUsername = "vpn";
  static const String defaultVpnPassword = "vpn";
  String config = '';
  String hostname = '';
  @override
  void initState() {
    contentList = widget.contentList;
    hostname = widget.contentList.hostname.toString();
    config =
        '"""\n ${widget.contentList.OpenVPN_ConfigData_Base64.toString()}\n """';
    engine.initialize(
      // groupIdentifier: "group.com.laskarmedia.vpn",
      groupIdentifier: "com.example.alivpn",
      providerBundleIdentifier:
          "id.laskarmedia.openvpnFlutterExample.VPNExtension",
      localizedDescription: "VPN by Ali",
      lastStage: (stage) {
        setState(() {
          this.stage = stage;
        });
      },
      lastStatus: (status) {
        setState(() {
          this.status = status;
        });
      },
    );

    // TODO: implement initState

    super.initState();
  }

  Future<void> initPlatformState() async {
    engine.connect(config, hostname,
        username: defaultVpnUsername,
        password: defaultVpnPassword,
        certIsRequired: true);
    debugPrint("Mountstatus" + mounted.toString());
    // debugPrint("CONFIG : " + config);
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${contentList.CountryLong}'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Card(
              elevation: 8,
              margin: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Country : ${contentList.CountryLong}'),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            height: 33,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blue
                                      .withAlpha(75), // Set border color
                                  width: 1.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //       blurRadius: 1,
                              //       spreadRadius: 1,
                              //       color: Colors.lightBlue,
                              //       offset: Offset(-4, 4))
                              // ]
                              // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Flag.fromString(
                              contentList.CountryShort.toString(),

                              fit: BoxFit.fill,
                              flagSize: FlagSize.size_4x3,
                              // borderRadius: 25,
                              replacement:
                                  Text('${contentList.CountryShort} not found'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Text('Hostname : ${contentList.hostname}'),
                    Text('IP : ${contentList.IP}'),
                    Text('Ping : ${contentList.Ping} ms'),
                    Text('Speed : ${contentList.Speed} mb/s'),
                    Text('Uptime : ${contentList.Uptime} Days'),
                    Text('Total Users : ${contentList.TotalUsers}'),
                    // Text('Logging Policy : ${contentList.LogType}'),

                    Text(
                        'Current VPN Sessions : ${contentList.NumVpnSessions}'),

                    ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ConnectionScreen(contentList))),
                      child: const Text('Connect to this server'),
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10)),
                    ),

                    // Text('Operator : ${contentList.}'),

                    // VPN Buttons

                    Text(stage?.toString() ?? VPNStage.disconnected.toString()),
                    Text(status?.toJson().toString() ?? ""),
                    TextButton(
                      child: const Text("Start"),
                      onPressed: () {
                        initPlatformState();
                        // connect();
                      },
                    ),
                    TextButton(
                      child: const Text("STOP"),
                      onPressed: () {
                        engine.disconnect();
                      },
                    ),
                    if (Platform.isAndroid)
                      TextButton(
                        child:
                            Text(_granted ? "Granted" : "Request Permission"),
                        onPressed: () {
                          engine.requestPermissionAndroid().then((value) {
                            setState(() {
                              _granted = value;
                            });
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
