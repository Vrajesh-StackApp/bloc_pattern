import 'dart:async';

import 'package:bloc_pattern/common/app_string.dart';
import 'package:bloc_pattern/data/model/picsum.dart';
import 'package:bloc_pattern/data/services/picsum_client.dart';
import 'package:bloc_pattern/pages/home/picsum_bloc.dart';
import 'package:bloc_pattern/pages/home/picsum_events.dart';
import 'package:bloc_pattern/pages/home/picsum_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Completer<void>? _refreshCompleter;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // getApiData();
    _refreshCompleter = Completer<void>();
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

  Widget? _homeBody() => BlocConsumer<PicsumBloc, PicsumStates>(
        listener: (context, state) {
          if (state is PicsumLoaded) {
            debugPrint("==> listener : PicsumLoaded");
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          debugPrint("Context ==> $context");
          debugPrint("state ==> $state");

          if (state is PicsumEmpty) {
            return emptyPicsum(context);
          } else if (state is PicsumLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PicsumLoaded) {
            final picsum = state.picsum;

            return RefreshIndicator(
              child: ListView(
                children: <Widget>[
                  displayPicsum(picsum),
                ],
              ),
              onRefresh: () {
                BlocProvider.of<PicsumBloc>(context).add(const RefreshPicsum(pages: 1, limit: 100));
                return _refreshCompleter!.future;
              },
            );
          }
          else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(left: 35.0, right: 30),
                  child: Text(
                    'Could not fetch data',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<PicsumBloc>(context).add(ResetPicsum());
                  },
                  child: const InkWell(
                    child: Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            );
          }
        },
      );

  displayPicsum(Picsum? picsum) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.network(picsum!.downloadUrl!),
        ),
        title: Text(
          picsum.author!,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  emptyPicsum(BuildContext context) {
    BlocProvider.of<PicsumBloc>(context)
        .add(const FetchPicsum(pages: 1, limit: 100));
  }

}
