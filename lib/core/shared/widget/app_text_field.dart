import 'package:flutter/material.dart';
import 'package:marketplace/core/l10n/l10n.dart';
import 'package:marketplace/core/utils/app_spacing.dart';
import 'package:marketplace/core/utils/colors.dart';
import 'package:marketplace/core/utils/extension.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    this.label,
    this.obscureText,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.controller,
    this.validator,
    this.onChanged,
    this.clearButtonEnabled = false,
    this.enable = true,
    super.key,
  });

  final String? label;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final bool clearButtonEnabled;
  final bool enable;

  @override
  State<AppTextField> createState() => _AppTextFieldState();

}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController? _controller;
  final FocusNode _focusNode = FocusNode();
  bool _hiddenText = false;

  @override
  void initState() {
    _hiddenText = widget.obscureText == true;
    _controller = widget.controller ?? TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    final label = Column(
      children: [
        Text(
          widget.label!,
          style: context.textTheme.titleSmall,
        ),
        AppSpacing.setVerticalHeight(4),
      ],
    );

    Widget? suffixWidget;

    if (widget.obscureText != null) {
      suffixWidget = TextButton(
        onPressed: () {
          setState(() {
            _hiddenText = !_hiddenText;
          });
        },
        style: TextButton.styleFrom(
          textStyle:  context.textTheme.titleMedium!.copyWith(
            decoration: TextDecoration.underline,
          ),
          foregroundColor: AppColors.yellow,
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        child: Text(
          _hiddenText ? localizations.show : localizations.hide,
        ),
      );
    }

    final decoration = InputDecoration(
      suffixIcon: suffixWidget,
      fillColor: AppColors.black,
      contentPadding: const EdgeInsets.all(12),
      labelStyle: context.textTheme.bodyMedium,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey1,
          width: 2,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) label,
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _hiddenText,
          enableSuggestions: false,
          autocorrect: false,
          enabled: widget.enable,
          decoration: decoration,
          validator: widget.validator,
          onFieldSubmitted: widget.onSubmitted,
          onChanged: (value) {setState(() {});
            widget.onChanged?.call(value);},
        ),
      ],
    );
  }
}
