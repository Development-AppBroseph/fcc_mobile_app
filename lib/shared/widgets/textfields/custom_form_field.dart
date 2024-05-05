import 'package:fcc_app_front/export.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    this.isFromPlacingOrder,
    this.controller,
    this.onEditingComplete,
    this.textInputAction,
    this.hintText,
    this.readOnly,
    this.textInputType,
    this.textInputFormatter,
    this.validator,
    this.initialValue,
    super.key,
  });
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? hintText;
  final bool? isFromPlacingOrder;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final String? Function(String? value)? validator;
  final String? initialValue;
  final bool? readOnly;
  final VoidCallback? onEditingComplete;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.controller != null) {
      widget.controller?.text = widget.initialValue ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      child: TextFormField(
        textAlignVertical:
            widget.isFromPlacingOrder != null ? TextAlignVertical.center : null,
        initialValue: widget.initialValue,
        onEditingComplete: widget.onEditingComplete,
        readOnly: widget.readOnly ?? false,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              color: Theme.of(context).hintColor,
            ),
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: widget.isFromPlacingOrder != null
              ? EdgeInsets.only(top: 10.h)
              : null,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: hintColor,
              ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        inputFormatters: widget.textInputFormatter,
        keyboardType: widget.textInputType,
        validator: widget.validator,
      ),
    );
  }
}
