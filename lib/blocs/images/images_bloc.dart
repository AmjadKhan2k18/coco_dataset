import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coco_dataset_testapp/blocs/search/search_bloc.dart';
import 'package:coco_dataset_testapp/models/image.dart';
import 'package:coco_dataset_testapp/utils/api_provider.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:equatable/equatable.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  List<int> imagesIds = [];

  List<ImageModel> images = [];

  final imagesStreamController = StreamController<List<ImageModel>>();

  StreamSink<List<ImageModel>> get _imagesSink => imagesStreamController.sink;

  Stream<List<ImageModel>> get imagesStream => imagesStreamController.stream;

  ImagesBloc() : super(ImagesInitial()) {
    on<OnGetImagesByCat>(_onGetImagesByCat);
    on<OnLoadImages>(_onLoadImages);
    on<OnLoadMoreImages>(_onLoadMoreImages);
  }

  Future<void> _onGetImagesByCat(
    OnGetImagesByCat event,
    Emitter<ImagesState> emit,
  ) async {
    emit(ImageIdsLoading());
    final currentList = serviceLocator.get<SearchBloc>().state.props;
    final currentIds = currentList.map((e) => e.id).toList();
    imagesIds = await ApiProvider.getImageIdsByCats(currentIds);
    emit(ImageIdsLoaded());

    if (imagesIds.isNotEmpty) {
      serviceLocator.get<ImagesBloc>().add(OnLoadImages());
    }
  }

  Future<void> _onLoadImages(
    OnLoadImages event,
    Emitter<ImagesState> emit,
  ) async {
    emit(LoadingImages());
    images = await loadingImages();
    _imagesSink.add(images);
    emit(ImagesLoaded(images));
  }

  Future<void> _onLoadMoreImages(
    OnLoadMoreImages event,
    Emitter<ImagesState> emit,
  ) async {
    emit(LoadingMoreImages());
    final _images = await loadingImages();
    images.addAll(_images);
    _imagesSink.add(images);
    emit(ImagesLoaded(images));
  }

  Future<List<ImageModel>> loadingImages() async {
    final listOfImagesToGet = imagesIds.take(5).toList().cast<int>();
    final _images = await ApiProvider.getImages(listOfImagesToGet);
    imagesIds.removeRange(0, 5);
    return _images;
  }
}
