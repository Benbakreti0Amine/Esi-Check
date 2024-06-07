import 'package:flutter/material.dart';


import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class RoundedHome extends StatelessWidget {
  final Widget child;
  const RoundedHome({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s20),
      width: double.infinity,
      // height: height,
      decoration: const BoxDecoration(
        color: ColorManger.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s40),
          topRight: Radius.circular(AppSize.s40),
        ),
      ),
      child: child,
    );
  }
}
