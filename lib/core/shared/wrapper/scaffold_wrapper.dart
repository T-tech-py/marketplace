import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:marketplace/core/utils/app_assets.dart';
import 'package:marketplace/core/utils/extension.dart';


class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(AppAssets.backdrop),
                      fit: BoxFit.cover)),
            ),
          ),
          SafeArea(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.width),
            child: body,
          )),
        ],
      ),
    );
  }
}
