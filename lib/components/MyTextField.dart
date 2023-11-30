import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Field extends StatelessWidget {
  const Field(
      {super.key,
      this.obcuretext,
      this.initialvalue,
      this.validate,
      this.onchanged,
      this.keyboardtype,
      this.labelcolor,
      this.labelfontsize,
      this.labelfontweight,
      this.labeltext,
      this.error,
      this.maxline,
      this.icon,
      this.sicon,
      required this.enable,
      this.onsubmit,
      this.controller,
      this.ontapouter,
      this.focusNode});
  final String? labeltext;
  final double? labelfontsize;
  final FontWeight? labelfontweight;
  final Color? labelcolor;
  final String? error;
  final Function(String)? onchanged;
  final TextInputType? keyboardtype;
  final int? maxline;
  final Widget? icon;
  final Widget? sicon;
  final bool enable;
  final String? Function(String?)? validate;
  final Function(String)? onsubmit;
  final TextEditingController? controller;
  final String? initialvalue;
  final bool? obcuretext;
  final void Function(PointerDownEvent)? ontapouter;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabled: enable,
        prefixIcon: icon,
        suffixIcon: sicon,
        labelText: labeltext,
        labelStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: labelfontsize ?? 18,
                fontWeight: labelfontweight ?? FontWeight.w500,
                color: labelcolor ?? Colors.black)),
      ),
      validator: validate,
      onFieldSubmitted: onsubmit,
      keyboardType: keyboardtype,
      maxLines: maxline,
      minLines: 1,
      controller: controller,
      onChanged: onchanged,
      initialValue: initialvalue,
      obscureText: obcuretext ?? false,
      onTapOutside: ontapouter,
      focusNode: focusNode,
    );
  }
}
