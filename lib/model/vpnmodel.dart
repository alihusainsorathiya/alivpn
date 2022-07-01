// ignore_for_file: non_constant_identifier_names

class VPNModel {
  String? hostname,
      IP,
      Score,
      Ping,
      Speed,
      CountryLong,
      CountryShort,
      NumVpnSessions,
      Uptime,
      TotalUsers,
      TotalTraffic,
      LogType,
      Operator,
      Message,
      OpenVPN_ConfigData_Base64;

  VPNModel(
      {this.hostname,
      this.IP,
      this.Score,
      this.Ping,
      this.Speed,
      this.CountryLong,
      this.CountryShort,
      this.NumVpnSessions,
      this.Uptime,
      this.TotalUsers,
      this.TotalTraffic,
      this.LogType,
      this.Operator,
      this.Message,
      this.OpenVPN_ConfigData_Base64});
}
