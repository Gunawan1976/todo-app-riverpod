import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditText extends StatelessWidget {

  final TextEditingController? customController;
  final String? titleTextField;
  final String? hintTextField;
  final String? errorText;
  final int? maxLength;
  final bool? readOnly;
  final bool? enabled;
  final bool? isImportant;
  final bool? expand;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final bool? obscure;
  final bool? customSuffix;
  final bool? isTahun;
  final void Function()? onTapObscure;
  final String? Function(String?)? validator;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? borderRadius;
  final Color? borderSideColor;
  final Color? fillColor;
  final void Function(String)? onFieldSubmitted;

  EditText(
      {super.key,
        this.customController,
        this.titleTextField,
        this.readOnly = false,
        this.enabled,
        this.hintTextField,
        this.onChanged,
        this.isImportant,
        this.keyboardType,
        this.errorText,
        this.inputFormatters,
        this.obscureText= false,
        this.obscure = false,
        this.onTapObscure,
        this.maxLength,
        this.validator,
        this.maxLines,
        this.suffixIcon,
        this.customSuffix = false,
        this.isTahun = false, this.prefixIcon, this.borderRadius, this.borderSideColor, this.fillColor, this.onFieldSubmitted, this.expand});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      controller: customController,
      autocorrect: false,
      keyboardType: keyboardType ?? TextInputType.text,
      onFieldSubmitted: (value) {},
      validator: validator,
      onChanged: onChanged,
      obscuringCharacter: "*",
      readOnly: readOnly ?? false,
      enabled: enabled,
      expands: expand ?? false,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorText: errorText,
        errorStyle: TextStyle(fontSize: 14.sp),
        fillColor: readOnly == true ? Colors.transparent : fillColor,
        filled: true,
        hintText: hintTextField,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 13.sp,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 6),
          ),
          borderSide:
          BorderSide(width: 1, color: borderSideColor ?? Colors.grey), //<-- SEE HERE
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 6),
          ),
          borderSide:
          BorderSide(width: 1, color:borderSideColor ??  Colors.grey), //<-- SEE HERE
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 6),
          ),
          borderSide:
          BorderSide(width: 1, color:borderSideColor ?? Colors.grey), //<-- SEE HERE
        ),
      ),
    );
  }
}