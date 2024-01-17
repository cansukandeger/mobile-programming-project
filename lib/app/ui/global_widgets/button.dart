import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilproje/core/color_manager.dart';

class Button extends StatefulWidget {
  final String? title;
  final TextStyle? style;
  final Color? borderColor;
  final Color color;
  final Function onTap;
  final Color? textColor;
  final Widget? icon;
  final double? height;
  final double? width;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Widget? rightIcon;

  const Button({
    Key? key,
    this.title,
    this.style,
    this.borderColor,
    required this.color,
    required this.onTap,
    this.textColor,
    this.icon,
    this.height,
    this.width,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.rightIcon,
  }) : super(key: key);

  @override
  State<Button> createState() => _SButtonState();
}

class _SButtonState extends State<Button> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: InkWell(
        onTap: () async {
          if (isLoading == false) {
            if (mounted) {
              setState(
                () {
                  isLoading = true;
                },
              );
            }
            await widget.onTap();
            if (mounted) {
              setState(
                () {
                  isLoading = false;
                },
              );
            }
          }
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
            border: Border.all(
              width: 1.2,
              color: widget.borderColor ?? widget.color,
            ),
          ),
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: isLoading == true
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                          fontFamily: "Regular",
                          color: widget.textColor ?? ColorManager().darkGray,
                          fontSize: widget.fontSize ?? 16,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      const CupertinoActivityIndicator(),
                      Text(
                        "",
                        style: TextStyle(
                          fontFamily: "Regular",
                          color: widget.textColor ?? ColorManager().darkGray,
                          fontSize: widget.fontSize ?? 16,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                )
              : (widget.icon != null || widget.rightIcon != null)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.icon ?? const SizedBox(),
                        Text(
                          widget.title ?? "",
                          style: widget.style ??
                              TextStyle(
                                fontFamily: "Regular",
                                color: widget.textColor ?? ColorManager().darkGray,
                                fontSize: widget.fontSize ?? 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                        ),
                        widget.rightIcon ?? const SizedBox()
                      ],
                    )
                  : Text(
                      widget.title ?? "",
                      style: widget.style ??
                          TextStyle(
                            fontFamily: "Regular",
                            color: widget.textColor ?? ColorManager().darkGray,
                            fontSize: widget.fontSize ?? 16,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                      textAlign: TextAlign.center,
                    ),
        ),
      ),
    );
  }
}