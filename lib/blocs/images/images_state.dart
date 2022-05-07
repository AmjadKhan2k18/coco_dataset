part of 'images_bloc.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object> get props => [];
}

class ImagesInitial extends ImagesState {}

class ImageIdsLoading extends ImagesState {}

class ImageIdsLoaded extends ImagesState {}

class ImagesLoaded extends ImagesState {}

class LoadingImages extends ImagesState {}

class LoadingMoreImages extends ImagesState {}
