import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class RoundedTextFieldWithColor extends StatefulWidget {
  const RoundedTextFieldWithColor({
    Key? key,
    required this.controller,
    required this.onColorSelected,
    this.selectedColor = Colors.blue,
  }) : super(key: key);
  final Color selectedColor;
  final TextEditingController controller;
  final Function(Color) onColorSelected;
  @override
  _RoundedTextFieldWithColorState createState() =>
      _RoundedTextFieldWithColorState();
}

class _RoundedTextFieldWithColorState extends State<RoundedTextFieldWithColor> {
  @override
  void initState() {
    super.initState();
    _selectedColor = widget.selectedColor;
  }

  late Color _selectedColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                controller: widget.controller,
                decoration: const InputDecoration(
                  hintText: 'Enter title',
                  hintStyle: TextStyle(
                    // color: AppTheme.lightDisabledColor,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                )),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Select Color'),
                  content: BlockPicker(
                      pickerColor: _selectedColor,
                      onColorChanged: (color) {
                        setState(() {
                          _selectedColor = color;
                        });
                        widget.onColorSelected(color);
                        Navigator.of(context).pop();
                      }),
                ),
              );
            },
            child: CircleAvatar(
              radius: 10.0,
              backgroundColor: _selectedColor,
            ),
          )
        ],
      ),
    );
  }
}
