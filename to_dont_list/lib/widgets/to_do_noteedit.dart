import 'package:to_dont_list/objects/item.dart';
import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    Item item, String value, TextEditingController textController);

class ToDoNoteEdit extends StatefulWidget {
  const ToDoNoteEdit({
    super.key,
    required this.item,
    required this.onListChanged,
  });

  final Item item;
  final ToDoListAddedCallback onListChanged;

  @override
  State<ToDoNoteEdit> createState() => _ToDoNoteEditState();
}

class _ToDoNoteEditState extends State<ToDoNoteEdit> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  // final TextEditingController _inputController = TextEditingController()..text = widget.item.name;
  TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    valueText = widget.item.name;
    _inputController = TextEditingController(text: widget.item.name);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Item:'),
      content: TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        controller: _inputController,
        decoration: const InputDecoration(hintText: "Empty. Press Cancel to restore text."),
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: const Text('Cancel'),
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListChanged(widget.item, valueText, _inputController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
}
