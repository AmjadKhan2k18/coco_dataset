import 'package:coco_dataset_testapp/blocs/categories/categories_bloc.dart';
import 'package:coco_dataset_testapp/blocs/search/search_bloc.dart';
import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/screens/loading.dart';
import 'package:coco_dataset_testapp/screens/search/search_input_field.dart';
import 'package:coco_dataset_testapp/screens/search/search_result.dart';
import 'package:coco_dataset_testapp/screens/search/selected_categories.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final catBloc = serviceLocator.get<CategoriesBloc>();

    return StreamBuilder<List<Category>>(
      stream: catBloc.categories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(height: 40),
                      SearchInputField(),
                      SelectedList(),
                      SizedBox(height: 12),
                      SearchButton(),
                    ],
                  ),
                ),
              ),
              const SearchResultList(),
            ],
          );
        }
        return const OurCircularLoading();
      },
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = serviceLocator.get<SearchBloc>();
    return ElevatedButton(
      onPressed: () => searchBloc.add(OnSearchBtnPressed()),
      child: const Text('Search Now'),
    );
  }
}
