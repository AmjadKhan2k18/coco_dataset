part of 'images_bloc.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();

  @override
  List<Object> get props => [];
}

class OnGetImagesByCat extends ImagesEvent {}

class OnLoadImages extends ImagesEvent {}

class OnLoadMoreImages extends ImagesEvent {}
