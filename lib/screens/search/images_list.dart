import 'package:coco_dataset_testapp/blocs/images/images_bloc.dart';
import 'package:coco_dataset_testapp/models/image.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
import 'package:coco_dataset_testapp/widgets/paint_object.dart';
import 'package:flutter/material.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imagesBloc = serviceLocator.get<ImagesBloc>();
    return StreamBuilder<List<ImageModel>>(
      stream: imagesBloc.imagesStream,
      builder: (context, imageStateSnap) {
        if (!imageStateSnap.hasData && imageStateSnap.data == null) {
          return const SizedBox();
        }
        final images = imageStateSnap.data!;
        return images.isEmpty
            ? Container(
                alignment: Alignment.center,
                height: 100,
                child: const Text('There is no match for selected categories'),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  return ImageAndPaintObject(image: images[index]);
                },
              );
      },
    );
  }
}
