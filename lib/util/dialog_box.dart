import 'package:flutter/material.dart';
import 'package:to_do/util/bottom.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller; // Specify the type of controller
  final VoidCallback onCansel;
  final VoidCallback onSave;

  DialogBox({
    Key? key, // Add the Key parameter
    required this.controller,
    required this.onCansel,
    required this.onSave,
  }) : super(key: key); // Use super(key: key) to pass the key parameter

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Bottome(
                  text: "Save",
                  onPressed: onSave,
                ),
                SizedBox(
                  width: 8,
                ),
                Bottome(
                  text: "Cancel",
                  onPressed: onCansel,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
