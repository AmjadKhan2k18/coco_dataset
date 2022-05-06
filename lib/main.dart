import 'package:coco_dataset_testapp/blocs/categories/categories_bloc.dart';
import 'package:coco_dataset_testapp/screens/loading.dart';
import 'package:coco_dataset_testapp/screens/search/search_screen.dart';
import 'package:coco_dataset_testapp/utils/http_requests.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:flutter/material.dart';

void main() async {
  await HttpRequest.init();
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CategoriesState>(
      stream: serviceLocator.get<CategoriesBloc>().stream,
      builder: ((context, snapshot) {
        if (!snapshot.hasData || snapshot.data is CategoriesLoading) {
          return const OurCircularLoading();
        }

        return const SearchScreen();
      }),
    );
  }
}
