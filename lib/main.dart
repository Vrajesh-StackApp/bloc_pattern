import 'package:bloc_pattern/common/app_string.dart';
import 'package:bloc_pattern/data/services/picsum_client.dart';
import 'package:bloc_pattern/data/services/picsum_repository.dart';
import 'package:bloc_pattern/pages/home/home_page.dart';
import 'package:bloc_pattern/pages/home/picsum_bloc.dart';
import 'package:bloc_pattern/pages/home/picsum_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


void main() {
  final PicsumRepository picsumRepository = PicsumRepository(picsumClient: PicsumClient());
  BlocOverrides.runZoned(
        () => runApp(MyApp(picsumRepository: picsumRepository)),
    blocObserver: PicsumBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final PicsumRepository picsumRepository;

   MyApp({Key? key,required this.picsumRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(create: (context) => PicsumBloc(picsumRepository),child: const HomePage(),),
      // initialRoute: AppString.homePage,
      // routes: {
      //   AppString.homePage : (context) => const HomePage(),
      // },
    );
  }
}

