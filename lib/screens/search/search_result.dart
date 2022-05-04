import 'package:coco_dataset_testapp/blocs/search/search_bloc.dart';
import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:flutter/material.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({Key? key}) : super(key: key);

  double getHeight(int length) {
    switch (length) {
      case 2:
      case 1:
        return 100.0;
      case 3:
      case 4:
        return 130.0;

      default:
        return 250.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = serviceLocator.get<SearchBloc>();
    return StreamBuilder<List<Category>>(
      stream: searchBloc.searchStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final length = snapshot.data!.length;
          return length == 0
              ? const SizedBox()
              : Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.14),
                    child: Container(
                      height: getHeight(length),
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      width: double.maxFinite,
                      child: snapshot.data!.isEmpty
                          ? const SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final category = snapshot.data![index];
                                return ListTile(
                                  onTap: () {
                                    searchBloc.add(OnAddCategory(category));
                                  },
                                  leading: CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(
                                      'https://cocodataset.org/images/cocoicons/${category.id}.jpg',
                                    ),
                                  ),
                                  title: Text(category.name),
                                );
                              }),
                    ),
                  ),
                );
        }
        return Container();
      },
    );
  }
}
