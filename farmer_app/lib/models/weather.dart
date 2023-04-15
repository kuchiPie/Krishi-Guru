import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String domain =
    "https://8000-kuchipie-krishiguru-cerp9irccr5.ws-us94.gitpod.io";
String appId = "74e0a709018250c0f7cbe8cfcc5e18fa";

Future<String> getWeatherData(String lat, String lon) async {
  var url =
      'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$appId';
  print(url);
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // print(jsonResponse);
      var current = jsonResponse['current'];
      var temp = current['temp'].toString();
      return temp;
    }
    print("error");
    return "err";
  } catch (err) {
    print(err);
    return "err";
  }
}
