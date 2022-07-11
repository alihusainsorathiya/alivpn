// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app_exceptions.dart';

class ApiClient {
  static const int TIME_OUT_DURATION = 120;
  //GET
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);

    try {
      var response = await http.get(uri, headers: {
        // "Access-Control-Allow-Origin": "*",
        "Accept": "*/*"
      }).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  Future<dynamic> getData(String baseUrl) async {
    debugPrint("GET_DATA_URL :::" + baseUrl.toString());
    var uri = Uri.parse(baseUrl);
    // print(uri);
    try {
      var response = await http.get(uri, headers: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "*/*"
      }).timeout(const Duration(seconds: TIME_OUT_DURATION));

      debugPrint(response.statusCode.toString());
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);
    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //DELETE
  //OTHER

  dynamic _processResponse(http.Response response) {
    // debugPrint('RESPONSE_CODE : ' + response.statusCode.toString());
    switch (response.statusCode) {
      // debugPrint(response.statusCode.toString());
      case 200:
        // debugPrint("RESPONSE_BODY : " + response.body);
        return response;
      //  return jsonResponse;

      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
