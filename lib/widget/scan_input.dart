import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bili_app/util/color.dart';

///输入框，自定义widget
class ScanInput extends StatefulWidget {
  final String label; //标题名称
  final String placeholder; //提示文字
  final bool isRequired; //是否必填
  final ValueChanged onFocus;

  final ValueChanged<String> onChanged;
  final ValueChanged<bool> focusChanged;
  final bool lineStretch;
  final bool obscureText; //是否获取焦点
  final TextInputType keyboardType;

  const ScanInput(this.label, this.placeholder,
      {Key key,
      this.onChanged,
      this.focusChanged,
      this.onFocus,
      this.lineStretch = false,
      this.obscureText = false,
      this.isRequired = false,
      this.keyboardType})
      : super(key: key);

  @override
  _ScanInputState createState() => _ScanInputState();
}

class _ScanInputState extends State<ScanInput> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = '123';

    super.initState();
    //是否获取光标的监听
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      if (_focusNode.hasFocus) {
        widget.onFocus(true);
      }
      if (widget.focusChanged != null) {
        widget.focusChanged(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                padding: EdgeInsets.only(left: 15),
                width: 100,
                child: Row(
                  children: [
                    widget.isRequired
                        ? Text('*', style: TextStyle(color: Colors.red))
                        : Text('  '),
                    Text(
                      widget.label,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )),
            _input(),
            Icon(
              Icons.center_focus_strong_outlined,
              size: 43,
              color: Colors.grey,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: primary,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      //输入框的样式
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.placeholder ?? '',
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }
}
