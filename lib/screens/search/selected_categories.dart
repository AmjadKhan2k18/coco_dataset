import 'package:coco_dataset_testapp/blocs/search/search_bloc.dart';
import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:flutter/material.dart';

class SelectedList extends StatelessWidget {
  const SelectedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
        stream: serviceLocator.get<SearchBloc>().selectedStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: double.maxFinite,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                children: snapshot.data!.map((e) => SelectedChip(e)).toList(),
              ),
            );
          }
          return const SizedBox();
        });
  }
}

class SelectedChip extends StatelessWidget {
  final Category cat;
  const SelectedChip(
    this.cat, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        radius: 10,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          'https://cocodataset.org/images/cocoicons/${cat.id}.jpg',
        ),
      ),
      label: Text(cat.name),
    );
  }
}
