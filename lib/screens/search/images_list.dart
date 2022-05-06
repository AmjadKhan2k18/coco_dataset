import 'package:coco_dataset_testapp/blocs/images/images_bloc.dart';
import 'package:coco_dataset_testapp/models/image.dart';
import 'package:coco_dataset_testapp/utils/locator.dart';
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
                  return SingleImageCard(images[index]);
                },
              );
      },
    );
  }
}

class SingleImageCard extends StatelessWidget {
  final ImageModel image;
  const SingleImageCard(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Card(
      child: Container(
        height: height * 0.25,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image.cocoUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// function renderSegms(ctx, img, data) {
//   var cats = Object.keys(data);
//   for (var i=0; i<cats.length; i++){
//     // set color for each object
//     var segms = data[cats[i]];
//     for (var j=0; j<segms.length; j++){
//       var r = Math.floor(Math.random() * 255);
//       var g = Math.floor(Math.random() * 255);
//       var b = Math.floor(Math.random() * 255);
//       ctx.fillStyle = 'rgba('+r+','+g+','+b+',0.7)';
//       var polys = JSON.parse(segms[j]['segmentation']);
//       // loop over all polygons
//       for (var k=0; k<polys.length; k++){
//         var poly = polys[k];
//         ctx.beginPath();
//         ctx.moveTo(poly[0], poly[1]);
//         for (m=0; m<poly.length-2; m+=2){
//           // let's draw!!!!
//           ctx.lineTo(poly[m+2],poly[m+3]);
//         }
//         ctx.lineTo(poly[0],poly[1]);
//         ctx.lineWidth = 3;
//         ctx.closePath();
//         ctx.fill();
//         ctx.strokeStyle = 'black';
//         ctx.stroke();
//       }
//     }
//   }
// }