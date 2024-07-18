import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'api_constant.dart';



enum ApiType { get, post }

class ApiCallType {
  Map? body;
  ApiType apiType;
  Map<String, String> header = {};
  ApiCallType.get() : apiType = ApiType.get;
  ApiCallType.post({required this.body}) : apiType = ApiType.post;
}

class ApiCall {

  Future<dynamic> call({
    required String url,
    required ApiCallType apiCallType,
    bool token = false,
  }) async {
    String myUrl = ApiConstant.baseUrl + url;
   // String? accessToken =LoginViewModel.of(NavigationService.context!).user?.gcmid;
    Map body = apiCallType.body ?? {};
    Map<String, String>? header =  {};
   header.addAll(apiCallType.header);

    http.Response? response;
    if (kDebugMode) {
      print("Type: ${apiCallType.apiType.name.toString()}");
      print("Header: $header");
      print("URL: $myUrl");
      print("BODY: $body");
    }

    try {
      switch (apiCallType.apiType) {
        case ApiType.get:
          response = await http.get(Uri.parse(myUrl), headers: header);
          break;
        case ApiType.post:
          response =
          await http.post(Uri.parse(myUrl), body: body, headers: header);
          break;
        default:
          break;
      }
      // print(response?.body);
      if(response!=null){
        var data=json.decode(response.body);
        print(json.encode(data));
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }
}
