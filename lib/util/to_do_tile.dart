import 'package:flutter/material.dart';

class ToDoTile extends StatefulWidget {
  final String taskName;
  final bool? taskComplete;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback onDelete;

  ToDoTile({
    required this.taskName,
    this.taskComplete,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  _ToDoTileState createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  bool? _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.taskComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        widget.onDelete();
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Checkbox(
                  value: _isChecked ?? false,
                  onChanged: (newValue) {
                    setState(() {
                      _isChecked = newValue;
                    });
                    widget.onChanged?.call(
                        newValue); // Notify the parent widget of the change
                  },
                  activeColor: Colors.black,
                ),
                Text(
                  widget.taskName,
                  style: TextStyle(
                    decoration: (_isChecked ?? false)
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
