import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: Lottie.asset(
            'assets/animations/square_loading.json',
            width: constraints.maxWidth * .3,
          ),
        );
      },
    );
  }
}
