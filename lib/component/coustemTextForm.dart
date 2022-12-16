import 'package:flutter/material.dart';

class CostumTextForm extends StatelessWidget {
  final String hint;
  TextEditingController mycontroller;
  String? Function(String?)? val;
  CostumTextForm({required this.hint,required this.mycontroller,this.val});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        validator:val ,
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.blueGrey
            )
          )
        ),
      ),
    );
  }
}
