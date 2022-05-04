import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coco_dataset_testapp/blocs/categories/categories_bloc.dart';
import 'package:coco_dataset_testapp/models/category.dart';
import 'package:coco_dataset_testapp/utils/api_provider.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  Timer? debouncer;

  TextEditingController searchController = TextEditingController();

  final selectedStreamController = StreamController<List<Category>>();
  final searchStreamController = StreamController<List<Category>>();

  StreamSink<List<Category>> get _selectedSink => selectedStreamController.sink;

  Stream<List<Category>> get selectedStream => selectedStreamController.stream;

  StreamSink<List<Category>> get _searchSink => searchStreamController.sink;

  Stream<List<Category>> get searchStream => searchStreamController.stream;

  SearchBloc() : super(SearchInitial()) {
    on<OnAddCategory>(_onAddCategory);
    on<OnRemoveCategory>(_onRemoveCategory);
    on<OnSearchBtnPressed>(_onSearchBtnPressed);
  }

  FutureOr<void> _onAddCategory(
      OnAddCategory event, Emitter<SearchState> emit) {
    final cats = serviceLocator.get<SearchBloc>().state.props;
    cats.add(event.category);
    _selectedSink.add(cats);
    searchController.clear();
    onSearchChange('');
    emit(UpdatedCategory(cats));
  }

  FutureOr<void> _onRemoveCategory(
      OnRemoveCategory event, Emitter<SearchState> emit) {}

  FutureOr<void> _onSearchBtnPressed(
      OnSearchBtnPressed event, Emitter<SearchState> emit) {
    final currentList = serviceLocator.get<SearchBloc>().state.props;
    final currentIds = currentList.map((e) => e.id).toList();
    ApiProvider.getImagesByCats(currentIds);
  }

  void onSearchChange(String value) {
    if (value.isEmpty) {
      _searchSink.add([]);
      return;
    }

    if (debouncer != null && debouncer!.isActive) debouncer!.cancel();

    debouncer = Timer(const Duration(milliseconds: 500), () {
      final categories = serviceLocator.get<CategoriesBloc>().state.props;
      final currentList = serviceLocator.get<SearchBloc>().state.props;
      final currentIds = currentList.map((e) => e.id).toList();
      final searchCats = categories
          .where((element) =>
              element.name.contains(value) && !currentIds.contains(element.id))
          .toList();
      _searchSink.add(searchCats);
    });
  }
}
