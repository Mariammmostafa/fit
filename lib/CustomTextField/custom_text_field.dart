import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool? isPassword;
  final String? hind;
  final bool? enabled;
  final int? maxLines, minLines, maxLength;
  final String? obscuringCharacter, value;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onChanged, onFieldSubmitted, onSaved;
  final void Function()? onEditingComplete, onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget, prefixIcon;
  final IconData? icon;
  final TextInputAction? actions;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.controller,
    this.isPassword,
    this.hind,
    this.enabled,
    this.obscuringCharacter,
    this.value,
    this.onValidate,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.suffixWidget,
    this.icon,
    this.prefixIcon,
    this.actions,
    this.focusNode,

  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}
class _CustomTextFieldState extends State<CustomTextField>{
  bool obscureText = true;
  @override
  Widget build (BuildContext context ) {
    var theme= Theme.of(context);
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.value,
      validator: widget.onValidate,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
     obscureText: widget.isPassword ?? false ? obscureText : false,
      obscuringCharacter: '*',
      keyboardType: widget.keyboardType,
     inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      style: theme.textTheme.bodyLarge!.copyWith(
        color: theme.primaryColor,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.actions ?? TextInputAction.done,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword ?? false ?
            InkWell(
              onTap: (){
                setState(() {
                  obscureText = !obscureText;
                });
              },

              child: Icon(

                obscureText? Icons.visibility_off: Icons.visibility,
                color: Colors.black,
              ),
            )
            :widget.suffixWidget,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hind,

hintStyle: const TextStyle(fontSize: 18,color: Colors.grey),
        counterText: "",

      border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF1B5E20),
            width: 1

          ),
        ),

       contentPadding: const EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 10,),

       enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
        color: Color(0xFF1B5E20),
    width: 1
    ),
       ),
        errorStyle: TextStyle(
          color: Colors.red,

        ),
        errorMaxLines: 4,
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
         color: Colors.red,
          ),
        ),
      ),
    );


  }

}