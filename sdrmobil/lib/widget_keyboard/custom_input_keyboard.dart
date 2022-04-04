import 'package:flutter/material.dart';
import 'package:sdrmobil/widget_keyboard/custom_keyboard.dart';

class CustomInputKeyboard extends StatefulWidget {
  final TextEditingController controller;
  final CustomKeyboard keyboard;
  final Function(BuildContext) onSubmit;
  final Future<bool> Function(String) validator;
  //final String labelText;
  final String errorText;
  final FocusNode focusNode;

  const CustomInputKeyboard(
      {@required this.keyboard,
      @required this.controller,      
      this.errorText = "Invalid Format",
      this.onSubmit,
      this.validator,
      this.focusNode,
      Key key})
      : super(key: key);

  @override
  _CustomInputKeyboardState createState() => _CustomInputKeyboardState();
}

class _CustomInputKeyboardState extends State<CustomInputKeyboard> {
  bool _validated = true;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode=widget.focusNode;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      widget.controller.addListener(() {
        focusNode.requestFocus();
        widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();    
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,                        
            children: [
              Expanded(
                flex: 1,                
                child: TextField(
                  cursorColor: Colors.white,
                  readOnly: true,
                  showCursor: true,                    
                  focusNode: focusNode,                                    
                  controller: widget.controller,
                  style: TextStyle(fontSize: 0.1),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      labelText: "",
                      errorText: _validated ? null : widget.errorText),
                ),
              ),

            ],
          ),

          Expanded(
            flex: 4,
            child: widget.keyboard,
          )
        ],
      ),
    );
  }

  submitCallback() async {
    if (widget.validator != null) {
      _validated = await widget.validator(widget.controller.text);
    } else {
      _validated = true;
    }
    setState(() {});
    if (_validated) {
      if (widget.onSubmit != null) {
        await widget.onSubmit(context);
      } else {
        Navigator.of(context).pop(widget.controller.text);
      }
    }
  }
}
