import 'package:coco_dataset_testapp/blocs/images/images_bloc.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:flutter/material.dart';

class BlurLoading extends StatelessWidget {
  const BlurLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imagesBloc = serviceLocator.get<ImagesBloc>();
    return StreamBuilder<ImagesState>(
        stream: imagesBloc.stream,
        builder: (context, imagesState) {
          final isLoading = imagesState.data is ImageIdsLoading;
          return isLoading
              ? Container(
                  color: Colors.black26,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
              : const SizedBox();
        });
  }
}
