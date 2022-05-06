part of 'images_bloc.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<ImageModel> get props => [];
}

class ImagesInitial extends ImagesState {}

class ImageIdsLoading extends ImagesState {}

class ImageIdsLoaded extends ImagesState {}

class ImagesLoaded extends ImagesState {
  final List<ImageModel> images;

  const ImagesLoaded(this.images);

  @override
  List<ImageModel> get props => images;
}

class LoadingImages extends ImagesState {}

class LoadingMoreImages extends ImagesState {}
