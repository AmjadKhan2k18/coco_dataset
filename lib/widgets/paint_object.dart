import 'dart:async';

import 'package:coco_dataset_testapp/models/image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class ImageAndPaintObject extends StatefulWidget {
  final ImageModel image;
  const ImageAndPaintObject({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageAndPaintObject> createState() => _ImageAndPaintObjectState();
}

class _ImageAndPaintObjectState extends State<ImageAndPaintObject> {
  Future<ui.Image> getImage(String path) async {
    final completer = Completer<ImageInfo>();
    final img = NetworkImage(path);

    img
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
        future: getImage(widget.image.cocoUrl),
        builder: (context, snap) {
          switch (snap.connectionState) {
            case ConnectionState.waiting:
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              );
            default:
              if (snap.hasError) {
                return Text('Error: ${snap.error}');
              } else {
                final image = snap.data!;
                return Card(
                  child: FittedBox(
                    child: SizedBox(
                      height: image.height.toDouble(),
                      width: image.width.toDouble(),
                      child: CustomPaint(
                        foregroundPainter:
                            LinearPainter(instances: widget.image.instances),
                        child: Image.network(widget.image.cocoUrl),
                      ),
                      // child: SmilePainter(snap.data),
                    ),
                  ),
                );
              }
          }
        });
  }
}

class LinearPainter extends CustomPainter {
  final List<ImageInstances> instances;

  LinearPainter({required this.instances});
  @override
  void paint(Canvas canvas, Size size) {
    for (var instance in instances) {
      final paint = Paint()
        ..color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(0.9)
        ..style = PaintingStyle.fill;
      final path = Path();
      for (var k = 0; k < instance.segmentation.length; k++) {
        var poly = instance.segmentation[k];
        path.moveTo(poly[0], poly[1]);
        for (var m = 0; m < poly.length - 2; m += 2) {
          path.lineTo(poly[m + 2], poly[m + 3]);
        }
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
