import 'dart:async';
import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/utils/api_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  List<String> superCategories = [];

  final catStreamController = StreamController<List<Category>>();

  StreamSink<List<Category>> get _catSink => catStreamController.sink;

  Stream<List<Category>> get categories => catStreamController.stream;

  CategoriesBloc() : super(CategoriesInitial()) {
    on<LoadCategories>(_onLoadCategories);
  }

  FutureOr<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    _catSink.add([]);
    emit(CategoriesLoading());
    final categories = await ApiProvider.fetchCategories();
    _catSink.add(categories);
    emit(CategoriesLoaded(categories));
  }
}
