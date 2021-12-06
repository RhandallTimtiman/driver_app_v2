import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthInput extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final String hint;
  final VoidCallback toggle;
  final bool isPassword;
  final String prefixIcon;

  const AuthInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.toggle,
    required this.isPassword,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        inputFormatters: isPassword
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ]
            : null,
        maxLength: 32,
        keyboardType: isPassword
            ? const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              )
            : null,
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(fontSize: 14, color: Colors.white),
        decoration: InputDecoration(
          counterStyle: const TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          filled: true,
          fillColor: Colors.grey[900],
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
            color: Colors.grey[400],
          ),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          suffixIcon: isPassword
              ? Padding(
                  child: IconTheme(
                    data: IconThemeData(color: Theme.of(context).primaryColor),
                    child: IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                        size: 24.0,
                      ),
                      onPressed: toggle,
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                )
              : null,
          prefixIcon: Container(
            padding: isPassword
                ? const EdgeInsets.all(10)
                : const EdgeInsets.all(13),
            child: Image(
              image: AssetImage(
                prefixIcon,
              ),
              width: 5,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hint is required!';
          }
          return null;
        },
      ),
    );
  }
}
