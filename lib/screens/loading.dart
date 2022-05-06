import 'package:flutter/material.dart';

class OurCircularLoading extends StatelessWidget {
  const OurCircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
