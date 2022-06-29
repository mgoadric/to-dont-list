import 'package:flutter/material.dart';

class Item {
  const Item({required this.name});

  final String name;
}

typedef ToDoListChangedCallback = Function(Item item, bool completed);
typedef ToDoListRemovedCallback = Function(Item item);

class ToDoListItem extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(item, completed);
      },
      onLongPress: () {
        onDeleteItem(item);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(item.name[0]),
      ),
      title: Text(
        item.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

class ToDoList extends StatefulWidget {
  ToDoList({super.key});

  final List<Item> items = [
    Item(name: 'Make Food'),
    Item(name: 'Do Laundry'),
    Item(name: 'Touch The Puppet Head'),
  ];

  void testing() {
    print("hello");
  }

  // The framework calls createState the first time
  // a widget appears at a given location in the tree.
  // If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses
  // the State object instead of creating a new State object.

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final _itemSet = <Item>{};

  void _handleListChanged(Item item, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      widget.items.remove(item);
      if (!completed) {
        print("Removing");
        _itemSet.add(item);
        widget.items.add(item);
      } else {
        print("Adding Back");
        _itemSet.remove(item);
        widget.items.insert(0, item);
      }
    });
  }

  void _handleDeleteItem(Item item) {
    setState(() {
      print("Deleting item");

      widget.items.remove(item);
    });
  }

  void _handleNewItem() {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      Item item = Item(name: "testing");
      ToDoListItem tditem = ToDoListItem(
        item: item,
        completed: false,
        onListChanged: _handleListChanged,
        onDeleteItem: _handleDeleteItem,
      );
      widget.items.insert(0, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: widget.items.map((item) {
          return ToDoListItem(
            item: item,
            completed: _itemSet.contains(item),
            onListChanged: _handleListChanged,
            onDeleteItem: _handleDeleteItem,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _handleNewItem),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return ToDoList();
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'To Do List',
    home: MyWidget(),
  ));
}
