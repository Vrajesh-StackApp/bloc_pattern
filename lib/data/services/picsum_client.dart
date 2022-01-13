import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc_pattern/common/app_string.dart';
import 'package:bloc_pattern/data/model/picsum.dart';
import 'package:http/http.dart' as http;

class PicsumClient{

  Future<Picsum> getPicsum(page,limit) async {
    http.Response response = await http.get(Uri.parse('${AppString.baseUrl}?page=$page&limit=$limit'));
    if (response.statusCode == HttpStatus.ok) {

      log("Response ==> ${response.body}");

      final picsumJson = jsonDecode(response.body);
      return Picsum.fromJson(picsumJson);
    } else {
      throw Exception();
    }
  }

}