import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';

typedef ToDoListChangedCallback = Function(Item item, bool completed);
typedef ToDoListRemovedCallback = Function(Item item);

class ToDoListItem extends StatefulWidget {
  ToDoListItem(
      {required this.item,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(item));

  final Item item;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  @override
  State<ToDoListItem> createState() => _CountDownState();

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return completed //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  
}
class _CountDownState extends State<ToDoListItem> {
    //https://api.flutter.dev/flutter/dart-async/Timer-class.html
    
    @override
    void dispose() {
      widget.item.timer?.cancel();
      super.dispose();
    }
    @override
    Widget build(BuildContext context){
      return ListTile(
      onTap: () {
        widget.onListChanged(widget.item, widget.completed);
      },
      onLongPress: widget.completed
          ? () {
              widget.onDeleteItem(widget.item);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: widget._getColor(context),
        child: Text(
          widget.item.timeRemaining.toStringAsFixed(1),
          style: widget._getTextStyle(context),
        ),
      ),
      title: Text(
        widget.item.name,
      ),
    );
      //return Row(
      //  children: [
      //    Text('Time remaining: $_timeRemaining')
      //  ],
      //);
    }
  }