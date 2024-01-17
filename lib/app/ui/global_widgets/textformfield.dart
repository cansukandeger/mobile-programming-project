// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilproje/core/color_manager.dart';


class TextFormFieldApp {
  static final TextFormFieldApp _instance = TextFormFieldApp._init();
  static TextFormFieldApp get instance => _instance;
  TextFormFieldApp._init();

  Widget widget({
    required BuildContext context,
    bool? autoFocus,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? mask,
    String? Function(String?)? validation,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    TextEditingController? controller,
    TextInputType? keyboardType,
    int? minLines,
    InputBorder? errorBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? border,
    InputBorder? disabledBorder,
    InputDecoration? decoration,
    TextStyle? style,
    TextStyle? labelStyle,
    BoxConstraints? boxConstraints,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    TextStyle? helperStyle,
    String? hintText,
    String? labelText,
    String? helperText,
    Widget? leadingIcon,
    Widget? suffixIcon,
    bool? obscureText,
    int? maxLength,
    int? maxLines,
    bool? enabled,
    bool? readOnly,
    bool allBorder = false,
    Color? cursorColor,
    AutovalidateMode? validateMode,
    double? fontSize,
    Color? borderColor,
    Color? fillColor,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) {
    return Padding(
      padding:  const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: TextFormField(
        autofocus: autoFocus == null ? false : true,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        cursorColor: cursorColor ?? ColorManager().primary,
        textInputAction: textInputAction,
        style: style != null
            ? style
            : TextStyle(
                color: ColorManager().primary.withOpacity(0.6),
                fontSize: fontSize ?? 16,
              ),
        scrollPadding: const EdgeInsets.only(bottom: 100),
        inputFormatters: mask != null ? mask : [],
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText ?? false,
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        autovalidateMode: validateMode != null ? validateMode : AutovalidateMode.disabled,
        keyboardType: keyboardType ?? TextInputType.text,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        minLines: minLines ?? 1,
        decoration: decoration ??
            InputDecoration(
              filled: true,
              prefixIcon: leadingIcon,
              contentPadding:const EdgeInsets.fromLTRB(
                12,
                4,
                4,
                6),
              suffixIcon: suffixIcon,
              focusColor: ColorManager().secondary,
              fillColor: fillColor ?? ColorManager().white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager().darkGray,
                ),
              ),
              hintText: labelText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager().darkGray,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager().darkGray,
                ),
              ),
              errorStyle: errorStyle,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1.5,
                  color: ColorManager().white,
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintStyle: labelStyle ??
                  TextStyle(
                    fontSize: 15,
                    color: ColorManager().primary.withOpacity(0.6),
                  ),
            ),
        validator: validation,
      ),
    );
  }
}