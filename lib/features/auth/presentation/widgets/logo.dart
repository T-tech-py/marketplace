import 'package:flutter/material.dart';
import 'package:marketplace/core/l10n/l10n.dart';
import 'package:marketplace/core/utils/extension.dart';

class Logo extends StatelessWidget {
  const Logo({this.goBack = false, super.key});
final bool goBack;
  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    return Stack(
      children: [
        Center(
        child: Text.rich(
          TextSpan(
              text: localization.market,
              children: [
                TextSpan(
                    text: localization.place,
                    style: context.textTheme.headlineLarge!.copyWith(
                      fontSize: 16.fontSize,
                    )
                ),
              ],

              style: context.textTheme.bodySmall!.copyWith(
                fontSize: 16.fontSize,
              ),
          ),
        ),
          ),
        if(goBack)
          const Align(
              alignment: Alignment.centerLeft,
              child: BackButton()),
      ],
    );}
}