import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckBox extends StatefulWidget {
  final ValueSetter<bool>? isCheckedCallback;
  final bool? isTitle;
  final String? title;

  const CustomCheckBox({
    required this.isCheckedCallback,
    super.key,
    this.isTitle = false,
    this.title,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return widget.isTitle!
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: _isChecked,
                activeColor: Colors.white,
                onChanged: (value) {
                  _isChecked = value!;
                  widget.isCheckedCallback!(_isChecked);
                  setState(() {});
                },
              ),
              InkWell(
                onTap: () {
                  _isChecked = !_isChecked;
                  widget.isCheckedCallback!(_isChecked);
                  setState(() {});
                },
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          )
        : Checkbox(
            value: _isChecked,
            activeColor: Colors.white,
            onChanged: (value) {
              _isChecked = value!;
              widget.isCheckedCallback!(_isChecked);
              setState(() {});
            },
          );
  }
}
