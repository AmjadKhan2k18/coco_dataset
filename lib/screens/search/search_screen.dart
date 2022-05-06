import 'package:coco_dataset_testapp/blocs/categories/categories_bloc.dart';
import 'package:coco_dataset_testapp/blocs/images/images_bloc.dart';
import 'package:coco_dataset_testapp/blocs/search/search_bloc.dart';
import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/screens/loading.dart';
import 'package:coco_dataset_testapp/screens/search/images_list.dart';
import 'package:coco_dataset_testapp/widgets/search_input_field.dart';
import 'package:coco_dataset_testapp/screens/search/search_result.dart';
import 'package:coco_dataset_testapp/screens/search/selected_categories.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:coco_dataset_testapp/widgets/blur_loading.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    serviceLocator.get<SearchBloc>().dispose();
    serviceLocator.get<CategoriesBloc>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catBloc = serviceLocator.get<CategoriesBloc>();

    return Stack(
      children: [
        ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
            body: StreamBuilder<List<Category>>(
              stream: catBloc.categories,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return NotificationListener<ScrollNotification>(
                    onNotification: _onScrollNotification,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40),
                              height: 55,
                              child: Row(
                                children: const [
                                  Expanded(child: SearchInputField()),
                                  SearchButton()
                                ],
                              ),
                            ),
                            const SelectedList(),
                            const SizedBox(height: 12),
                            const SearchResultList(),
                            const ImagesList(),
                            const LoadingMoreLoader()
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const OurCircularLoading();
              },
            ),
          ),
        ),
        const BlurLoading()
      ],
    );
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;

      if (before == max) {
        final imagesBloc = serviceLocator.get<ImagesBloc>();
        if (imagesBloc.state is LoadingMoreImages) return false;

        if (imagesBloc.imagesIds.isEmpty) {
          scaffoldMessengerKey.currentState!.showSnackBar(
            const SnackBar(
              content: Text(
                'There is no more images to load',
              ),
            ),
          );
          return true;
        }

        imagesBloc.add(OnLoadMoreImages());
      }
    }
    return false;
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imagesBloc = serviceLocator.get<ImagesBloc>();
    return StreamBuilder<ImagesState>(
      stream: imagesBloc.stream,
      builder: (context, imagesState) {
        final isLoading = imagesState.data is ImageIdsLoading;
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.green))
            : IconButton(
                onPressed: () => imagesBloc.add(OnGetImagesByCat()),
                icon: const Icon(Icons.search),
              );
      },
    );
  }
}

class LoadingMoreLoader extends StatelessWidget {
  const LoadingMoreLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imagesBloc = serviceLocator.get<ImagesBloc>();
    return StreamBuilder<ImagesState>(
      stream: imagesBloc.stream,
      builder: (context, imagesState) {
        final isLoading = imagesState.data is LoadingMoreImages;
        return isLoading
            ? Container(
                height: 50,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : const SizedBox();
      },
    );
  }
}
