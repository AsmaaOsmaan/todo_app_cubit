import 'package:flutter/material.dart';

import '../theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController ? controller;
  final String hint;
  Widget? widget;

  InputField(
      {required this.title,
    this.controller,
      required this.hint,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleTextStle,
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 14.0),
            height: 52,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(12.0)),
            child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller,
                  cursorColor: Colors.grey[600],
                  readOnly: widget == null ? false : true,
                  style: subTitleTextStle,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subTitleTextStle,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        //context.theme.backgroundColor,
                        width: 0,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,

                        // context.theme.backgroundColor,
                        width: 0,
                      ),
                    ),
                  ),
                )),

                widget ?? Container(),
                // widget==null?? widget;
                //  widget == null ? Container() : widget,
              ],
            ),
          )
        ],
      ),
    );
  }
}
