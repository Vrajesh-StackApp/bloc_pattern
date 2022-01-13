import 'dart:async';

import 'package:bloc_pattern/common/app_constant.dart';
import 'package:bloc_pattern/common/app_string.dart';
import 'package:bloc_pattern/data/services/picsum_client.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getApiData();
    super.initState();
  }

  getApiData() async {
    await PicsumClient().getPicsum(1, 100);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _homeBody(),
      ),
    );
  }

  PreferredSizeWidget? _appBar() => AppBar(
    title: Text(AppString.homePageAppBar),
    backgroundColor: Colors.blue,
    elevation: 5.0,
  );

  Widget? _homeBody() => Container(
    margin: const EdgeInsets.symmetric(horizontal: marginMediumLarge,vertical: marginMediumLarge),
    child: Column(
      children: [
        Text("Hello"),
      ],
    ),
  );
}
