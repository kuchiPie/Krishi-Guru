import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

String domain =
    "https://8000-kuchipie-krishiguru-mknkkhm5lap.ws-us94.gitpod.io";

// Future<String> resolveQuery(
//     String query, List<Map<String, dynamic>> lst) async {
//   String url = domain + '/query?message=' + query;
//   print(url);
//   print(lst);
//   print(query);
//   var jsonVal = convert.jsonEncode(lst);
//   print(jsonVal.toString());
//   var response = await http.post(Uri.parse(url),
//       headers: <String, String>{
//         "Content-Type": "application/json",
//         "accept": "application/json"
//       },
//       body: jsonVal.toString());
//   print("${response.body}");
//   print("${response.statusCode}");

//   print(response.toString());
//   if (response.body.isNotEmpty) {
//     var jsonResponse = convert.jsonDecode(response.body);
//     if (response.statusCode as int == 200) {
//       return jsonResponse;
//     }
//     print(jsonResponse);
//   }
//   return "Error Please Try Again";
// }

Future<String> resolveQuery(
    String query, List<Map<String, dynamic>> lst) async {
  HttpClient httpClient = new HttpClient();
  String url = domain + '/query?message=' + query;
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.headers.set('accept', 'application/json');
  request.add(utf8.encode(json.encode(lst)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}

Future<List<dynamic>> newQuery(String crop) async {
  String url = domain + '/new_query/' + crop;
  var res = await http.get(Uri.parse(url));
  if (res.statusCode == 200) {
    var jsonResponse = jsonDecode(res.body);
    print(jsonResponse);
    return jsonResponse;
  }
  return [
    {"Error": "Please Try Again"}
  ];
}
