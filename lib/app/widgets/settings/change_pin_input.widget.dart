import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePinInput extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final String hint;

  const ChangePinInput({
    Key? key,
    required this.controller,
    required this.obscure,
    required this.hint,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 15,
        keyboardType: const TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          counterStyle: const TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
            color: Colors.grey[400],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
