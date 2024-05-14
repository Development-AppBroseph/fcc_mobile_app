import 'package:fcc_app_front/export.dart';

class RounField extends StatefulWidget {
  final EdgeInsets margin;
  final String? initialText;
  final bool? enabled;
  final double width;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final double height;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsets? padding;
  final String? iconPath;
  final double? iconSize;
  final String? hintText;
  final EdgeInsets? iconPadding;
  final Color? iconColor;
  final EdgeInsets? textfieldPadding;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatter;
  final BorderRadius? borderRadius;
  final Color? color;
  final Function? iconFunction;

  const RounField({
    this.margin = const EdgeInsets.symmetric(horizontal: 0),
    this.initialText,
    this.enabled,
    this.width = double.infinity,
    this.textInputType,
    this.textInputAction,
    this.controller,
    this.height = 60,
    this.textStyle,
    this.hintStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.iconPath,
    this.iconSize,
    this.hintText,
    this.iconPadding,
    this.iconColor,
    this.textfieldPadding,
    this.borderColor,
    this.inputFormatter,
    this.borderRadius,
    this.color,
    this.iconFunction,
    super.key,
  });

  @override
  State<RounField> createState() => _RounFieldState();
}

class _RounFieldState extends State<RounField> {
  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.text = widget.initialText ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Container(
        padding: widget.padding,
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(15),
          color: widget.color ?? Colors.transparent,
          border: Border.all(
            color: widget.borderColor ?? Theme.of(context).primaryColorLight,
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: widget.textfieldPadding ?? const EdgeInsets.all(0),
                child: TextFormField(
                  style: widget.textStyle ??
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Theme.of(context).hintColor,
                          ),
                  textInputAction: widget.textInputAction,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: widget.hintStyle,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  keyboardType: widget.textInputType,
                  inputFormatters: widget.inputFormatter,
                ),
              ),
            ),
            if (widget.iconPath != null)
              GestureDetector(
                onTap: () {
                  if (widget.iconFunction != null) {
                    widget.iconFunction!();
                  }
                },
                child: Padding(
                  padding: widget.iconPadding ?? const EdgeInsets.all(0),
                  child: SvgPicture.asset(
                    widget.iconPath!,
                    height: widget.iconSize,
                    colorFilter: widget.iconColor != null
                        ? ColorFilter.mode(
                            widget.iconColor!,
                            BlendMode.srcIn,
                          )
                        : null,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
