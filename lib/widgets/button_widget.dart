import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final String label;

  const ButtonWidget({Key? key, required this.onClicked, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size(100, 42)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.more_time, size: 28),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        onPressed: onClicked,
      );
}

//from https://github.com/JohannesMilke/cupertino_datepicker_example/blob/master/lib/widget/button_widget.dart