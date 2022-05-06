import 'package:coco_dataset_testapp/blocs/search/search_bloc.dart';
import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:flutter/material.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final searchBloc = serviceLocator.get<SearchBloc>();
    return StreamBuilder<List<Category>>(
      stream: searchBloc.searchStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? const SizedBox()
              : Container(
                  height: height * 0.40,
                  margin: const EdgeInsets.all(12),
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final category = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          onTap: () => searchBloc.add(OnAddCategory(category)),
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                              'https://cocodataset.org/images/cocoicons/${category.id}.jpg',
                            ),
                          ),
                          title: Text(category.name),
                        ),
                      );
                    },
                  ),
                );
        }
        return Container();
      },
    );
  }
}
