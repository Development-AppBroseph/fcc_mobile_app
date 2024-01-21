import 'package:fcc_app_front/export.dart';

class CustomField extends StatefulWidget {
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final double? height;
  final double? width;
  final TextStyle? hintStyle;
  final List<TextInputFormatter> inputFormatter;
  final String? hintText;
  final Widget? prefix;
  final bool? hintAlignment;
  final EdgeInsets? margin;
  final String? suffixText;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? bordercolor;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledinputBorder;
  final TextStyle? suffixtextstyle;
  final BoxBorder? border;
  final Function(String)? onChanged;
  final String Function(String)? validator;
  final TextInputType? inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets textPadding;
  final BorderRadius borderRadius;
  final Color? suffixIconColor;
  final bool? obscureText;
  final Color baseColor;
  final FocusNode? focusNode;

  const CustomField(
      {Key? key,
      this.controller,
      this.prefix,
      this.inputFormatter = const <TextInputFormatter>[],
      this.padding = const EdgeInsets.symmetric(horizontal: 15),
      this.hintStyle,
      this.inputType,
      this.hintText,
      this.suffixText,
      this.margin,
      this.suffixtextstyle,
      this.textStyle,
      this.baseColor = Colors.transparent,
      this.onChanged,
      this.obscureText,
      this.suffixIcon,
      this.textPadding = const EdgeInsets.only(left: 15),
      this.validator,
      this.border,
      this.enabledBorder,
      this.bordercolor,
      this.contentPadding = const EdgeInsets.symmetric(vertical: 8),
      this.prefixIcon,
      this.height,
      this.width,
      this.disabledinputBorder,
      this.focusNode,
      this.hintAlignment,
      this.focusedBorder,
      this.borderRadius = const BorderRadius.all(Radius.circular(5)),
      this.suffixIconColor})
      : super(key: key);

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  String error = '';
  Color currentColor = Colors.black12;

  @override
  void initState() {
    super.initState();
    currentColor = widget.baseColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding!,
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height,
        padding: widget.textPadding,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: widget.baseColor,
        ),
        margin: widget.contentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              obscureText: widget.obscureText ?? false,
              focusNode: widget.focusNode,
              inputFormatters: widget.inputFormatter,
              keyboardType: widget.inputType,
              onChanged: (String v) {
                if (widget.validator != null) {
                  String validation = widget.validator!(v);
                  setState(() {
                    error = validation;
                  });
                }
                if (widget.onChanged != null) {
                  widget.onChanged!(v);
                }
              },
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ??
                    Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                filled: widget.hintAlignment ?? false,
                prefix: widget.prefix,
                suffixText: widget.suffixText,
                suffixStyle: widget.suffixtextstyle,
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                focusedBorder: widget.focusedBorder ??
                    UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1.5,
                      ),
                    ),
                disabledBorder: widget.disabledinputBorder,
                enabledBorder: widget.enabledBorder ??
                    UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1.5,
                      ),
                    ),
              ),
              controller: widget.controller,
            ),
            if (error != '')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    //  SvgPicture.asset('assets/warning.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        error,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
