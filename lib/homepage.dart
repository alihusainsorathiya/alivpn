import 'dart:convert';
import 'dart:io';

import 'package:alivpn/model/vpnmodel.dart';
import 'package:alivpn/network/api.dart';
import 'package:alivpn/network/apiclient.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<List<dynamic>> vpnListItems = [];

  dynamic abc;
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
        itemCount: vpnListItems.length,
        itemBuilder: (_, index) {
          var counter = vpnListItems[index + 1];

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
          VPNModel vpnModel = VPNModel(
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

          return Column(
            children: [
              Card(
                color: vpnModel.CountryShort == 'JP'
                    ? Colors.blue
                    : vpnModel.CountryShort == 'KR'
                        ? Colors.orange
                        : Colors.white,
                child: Column(
                  children: [
                    Text('HostName: ${vpnModel.hostname}'),
                    Text('IP: ${vpnModel.IP}'),
                    Text('Score: ${vpnModel.Score}'),
                    Text('Ping: ${vpnModel.Ping}'),
                    Text('Speed: ${vpnModel.Speed}'),
                    Text('CountryLong: ${vpnModel.CountryLong}'),
                    Text('CountryShort: ${vpnModel.CountryShort}'),
                    Text('NumVpnSessions: ${vpnModel.NumVpnSessions}'),
                    Text('Uptime: ${vpnModel.Uptime}'),
                    Text('TotalUsers: ${vpnModel.TotalUsers}'),
                    Text('TotalTraffic: ${vpnModel.TotalTraffic}'),
                    Text('LogType: ${vpnModel.LogType}'),
                    Text('Operator: ${vpnModel.Operator}'),
                    Text('Message: ${vpnModel.Message}'),

                    //  Text('OpenVPN_ConfigData_Base64;: ${vpnModel.OpenVPN_ConfigData_Base64}'),
                  ],
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

    debugPrint(abcd);

    //  vpnListItems = await abc.transform(utf8.decoder)
    //     .transform(new CsvToListConverter())
    //     .toList();

    List<List<dynamic>> _listData = const CsvToListConverter().convert(abcd);
    _listData.removeAt(0);

    setState(() {
      debugPrint("length : " + _listData.length.toString());
      vpnListItems = _listData;
    });
  }
}
