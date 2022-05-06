import 'package:coco_dataset_testapp/blocs/categories/categories_bloc.dart';
import 'package:coco_dataset_testapp/blocs/images/images_bloc.dart';
import 'package:coco_dataset_testapp/blocs/search/search_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setUpLocator() {
  serviceLocator.registerSingleton<CategoriesBloc>(
    CategoriesBloc()..add(LoadCategories()),
  );
  serviceLocator.registerSingleton<SearchBloc>(SearchBloc());
  serviceLocator.registerSingleton<ImagesBloc>(ImagesBloc());
}
