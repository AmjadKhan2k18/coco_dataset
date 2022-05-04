import 'package:coco_dataset_testapp/blocs/search/search_bloc.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:flutter/material.dart';

class SearchInputField extends StatefulWidget {
  const SearchInputField({Key? key}) : super(key: key);

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  @override
  Widget build(BuildContext context) {
    final searchBloc = serviceLocator.get<SearchBloc>();
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextFormField(
          controller: searchBloc.searchController,
          onChanged: searchBloc.onSearchChange,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(12),
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
