import 'package:fcc_app_front/export.dart';

class CstmBtn extends StatefulWidget {
  final double? height;
  final double? iconHeight;

  final TextStyle? textStyle;
  final double? width;
  final bool isLogin;
  final String? iconPath;
  final bool dropShadow;
  final EdgeInsets padding;
  final BorderSide? borderSide;
  final Color? textColor;
  final Color? color;
  final String text;
  final Widget? child;
  final MainAxisAlignment alignment;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final void Function() onTap;

  const CstmBtn({
    this.height,
    this.iconHeight,
    this.textStyle,
    this.width,
    this.isLogin = false,
    this.iconPath,
    this.dropShadow = false,
    this.padding = const EdgeInsets.all(0),
    this.borderSide,
    this.textColor,
    this.color,
    required this.text,
    this.child,
    this.alignment = MainAxisAlignment.center,
    this.borderRadius,
    this.margin,
    required this.onTap,
    this.gradient,
    Key? key,
  }) : super(key: key);

  // Добавлено: параметр для градиента
  final Gradient? gradient;

  @override
  State<CstmBtn> createState() => _CstmBtnState();
}

class _CstmBtnState extends State<CstmBtn> {
  bool isOnTap = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (TapDownDetails details) {
          setState(() {
            isOnTap = true;
          });
        },
        onTapCancel: () {
          setState(() {
            isOnTap = false;
          });
        },
        onTapUp: (TapUpDetails details) {
          setState(() {
            isOnTap = false;
          });
        },
        child: AnimatedOpacity(
          opacity: isOnTap ? 0.7 : 1,
          duration: const Duration(milliseconds: 100),
          child: Container(
            height: widget.height ?? 60,
            width: widget.width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(15),
              gradient: widget.gradient,
              color: widget.gradient == null ? widget.color ?? Theme.of(context).primaryColor : null,
              border: widget.borderSide != null ? Border.fromBorderSide(widget.borderSide!) : null,
              boxShadow: widget.dropShadow
                  ? <BoxShadow>[
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : <BoxShadow>[],
            ),
            child: Padding(
              padding: widget.padding,
              child: !widget.isLogin
                  ? Row(
                      mainAxisAlignment: widget.alignment,
                      children: <Widget>[
                        if (widget.iconPath != null)
                          SvgPicture.asset(
                            widget.iconPath!,
                            height: widget.iconHeight,
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        widget.child ??
                            Text(
                              widget.text,
                              style: widget.textStyle ??
                                  Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: widget.textColor,
                                      ),
                            ),
                      ],
                    )
                  : const Center(
                      child: CupertinoActivityIndicator(),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
