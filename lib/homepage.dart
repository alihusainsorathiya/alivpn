// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:alivpn/model/vpnmodel.dart';
import 'package:alivpn/network/api.dart';
import 'package:alivpn/network/apiclient.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fast_csv/fast_csv.dart' as _fast_csv;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<List<dynamic>> vpnListItems = [];

  dynamic abc;
  // final List<VPNModel> vpnModelList = [];
  var serverList = {};
  final vpnList = <VPNModel>[];
  final sortedList = [];
  @override
  void initState() {
    abc = getVPNServers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VPN"),
      ),
      body: ListView.builder(
        itemCount: serverList.length,
        itemBuilder: (_, index) {
          // var counter = vpnListItems[index + 1];

          // VPNModel vpnModel = VPNModel();
          // final List<VPNModel> vpnModelList = [];
          // for (int i = 0; i < index; i++) {
          //   String hostname = counter[0].toString();
          //   String IP = counter[1].toString();
          //   String Score = counter[2].toString();
          //   String Ping = counter[3].toString();
          //   String Speed = counter[4].toString();
          //   String CountryLong = counter[5].toString();
          //   String CountryShort = counter[6].toString();
          //   String NumVpnSessions = counter[7].toString();
          //   String Uptime = counter[8].toString();
          //   String TotalUsers = counter[9].toString();
          //   String TotalTraffic = counter[10].toString();
          //   String LogType = counter[11].toString();
          //   String Operator = counter[12].toString();
          //   String Message = counter[13].toString();
          //   String OpenVPN_ConfigData_Base64 = counter[14].toString();
          //   vpnModel = VPNModel(
          //       hostname: hostname,
          //       IP: IP,
          //       Score: Score,
          //       Ping: Ping,
          //       Speed: Speed,
          //       CountryLong: CountryLong,
          //       CountryShort: CountryShort,
          //       NumVpnSessions: NumVpnSessions,
          //       Uptime: Uptime,
          //       TotalUsers: TotalUsers,
          //       TotalTraffic: TotalTraffic,
          //       LogType: LogType,
          //       Operator: Operator,
          //       Message: Message,
          //       OpenVPN_ConfigData_Base64: OpenVPN_ConfigData_Base64);

          //   vpnModelList.add(vpnModel);
          // }
          // debugPrint("VPNMODEL LIST : " + vpnModelList.length.toString());

          return Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Card(
                  color: index % 2 == 0 ? Colors.white : Colors.limeAccent,
                  child: Row(
                    children: [
// Flag.fromCode(serverList.keys.)

                      // Text(
                      // '${serverList.keys.elementAt(index)} : ${serverList.values.elementAt(index)}'),

                      // Text('${abcdefg.CountryShort}')
                      // Text('HostName: ${vpnModel.hostname}'),
                      // Text('IP: ${vpnModel.IP}'),
                      // Text('Score: ${vpnModel.Score}'),
                      // Text('Ping: ${vpnModel.Ping}'),
                      // Text('Speed: ${vpnModel.Speed}'),
                      // Text('CountryLong: ${vpnModel.CountryLong}'),
                      // Text('CountryShort: ${vpnModel.CountryShort}'),
                      // Text('NumVpnSessions: ${vpnModel.NumVpnSessions}'),
                      // Text('Uptime: ${vpnModel.Uptime}'),
                      // Text('TotalUsers: ${vpnModel.TotalUsers}'),
                      // Text('TotalTraffic: ${vpnModel.TotalTraffic}'),
                      // Text('LogType: ${vpnModel.LogType}'),
                      // Text('Operator: ${vpnModel.Operator}'),
                      // Text('Message: ${vpnModel.Message}'),

                      //  Text('OpenVPN_ConfigData_Base64;: ${vpnModel.OpenVPN_ConfigData_Base64}'),
                    ],
                  ),
                ),
              ),
              // Text(abc.toString()),
            ],

            // trailing: Text(vpnListItems[index][2].toString()),
          );
        },
      ),
    );
  }

  getVPNServers() async {
    Response response =
        await ApiClient().get(API().BASE_URL, API().SECONDARY_URL);
    debugPrint(response.statusCode.toString());
    String abcd = response.body.toString().replaceAll("*vpn_servers", "");
    // abcd = abcd.replaceAll(
    //     "#HostName,IP,Score,Ping,Speed,CountryLong,CountryShort,NumVpnSessions,Uptime,TotalUsers,TotalTraffic,LogType,Operator,Message,OpenVPN_ConfigData_Base64\n",
    //     "");
    // abcd.removeAt(0); //remove column heading

    // debugPrint(abcd);

    //  vpnListItems = await abc.transform(utf8.decoder)
    //     .transform(new CsvToListConverter())
    //     .toList();

    // List<List<dynamic>> _listData = const CsvToListConverter().convert(abcd);
    final _listData = _fast_csv.parse(abcd);

    _listData.removeAt(0);
    // debugPrint(_listData.toString());

    setState(() {
      debugPrint("length : " + _listData.length.toString());
      vpnListItems = _listData;
    });

    for (int i = 0; i < vpnListItems.length - 2; i++) {
      var counter = vpnListItems[i + 1];
      List<VPNModel> vpnModelList = [];
      VPNModel vpnModel = VPNModel();

      // debugPrint("index : " + i.toString() + " : " + counter[0].toString());
      String hostname = counter[0].toString();
      String IP = counter[1].toString();
      String Score = counter[2].toString();
      String Ping = counter[3].toString();
      String Speed = counter[4].toString();
      String CountryLong = counter[5].toString();
      String CountryShort = counter[6].toString();
      String NumVpnSessions = counter[7].toString();
      String Uptime = counter[8].toString();
      String TotalUsers = counter[9].toString();
      String TotalTraffic = counter[10].toString();
      String LogType = counter[11].toString();
      String Operator = counter[12].toString();
      String Message = counter[13].toString();
      String OpenVPN_ConfigData_Base64 = counter[14].toString();

      vpnModel = VPNModel(
          hostname: hostname,
          IP: IP,
          Score: Score,
          Ping: Ping,
          Speed: Speed,
          CountryLong: CountryLong,
          CountryShort: CountryShort,
          NumVpnSessions: NumVpnSessions,
          Uptime: Uptime,
          TotalUsers: TotalUsers,
          TotalTraffic: TotalTraffic,
          LogType: LogType,
          Operator: Operator,
          Message: Message,
          OpenVPN_ConfigData_Base64: OpenVPN_ConfigData_Base64);
      vpnList.add(vpnModel);
    }

    debugPrint("VPNMODEL LIST : " + vpnList.length.toString());
    // debugPrint("Sorted LIST : " + sortedListItem.length.toString());

    // debugPrint(sortedListItem[0].CountryLong.toString());
    // debugPrint(sortedListItem[1].CountryLong.toString());

    // final Map counts = {};

    // vpnList.map((e) => counts.containsKey(e.CountryLong)
    //      counts[e.CountryLong]++
    //     : counts[e.CountryLong] = 1);
    // debugPrint(counts.toString());

    // vpnList.forEach((x) => map[x.CountryLong] =
    //     map.containsKey(x.CountryLong) ? (1) : (map[x] + 1));

    vpnList.forEach((e) {
      serverList.update(
          e.CountryLong,
          (x) => {
                x + 1,
                serverList.addAll({
                  serverList['countryShort']: e.CountryShort,
                }),
              },
          ifAbsent: () => 1);

      //  serverList.updateAll((key, value) => null)
      // serverList[]
      // serverList['flag'] = ;
    });

    // debugPrint(CountryLongmap.toString());
    // debugPrint("entries: " + serverList.entries.toString());
    // debugPrint("keys:" + serverList.keys.toString());
    debugPrint(serverList.toString());
  }
}
