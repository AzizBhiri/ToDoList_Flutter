import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo List',
      home: new TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if(task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Mark "${_todoItems[index]}" as done?\n'),
          actions: <Widget>[
            new FlatButton(
              child: new Icon(Icons.clear_rounded),
              color: Colors.red,
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Icon(Icons.check_rounded),
              color: Colors.green,
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  /* Delete Task using the prompt
  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _promptRemoveTodoItem(index)
    );
  }*/

  /* Delete Task using dissmissible (swipe right)*/
  Widget _buildTodoItem(String todoText, int index) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child : Container (
          child : Align(
            alignment : Alignment.centerLeft,
            child : Icon(Icons.delete_forever, color: Colors.white, size: 30, ),
          ),
        ),
      ),

      key: Key(todoText),
      onDismissed: (direction) {
        setState(() {
        _todoItems.removeAt(index);
      });

    ScaffoldMessenger
        .of(context)
        .showSnackBar(SnackBar(content: Text("$todoText dismissed")));
    },
    child: ListTile(title: Text('$todoText')),
  );

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List')
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        elevation : 10,
        tooltip: 'Add task',
        child: new Icon(Icons.add)
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add a new task')
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)
              ),
            ),
            //_setPriority;
          );
        }
      )
    );
  }

  /*void _setPriority() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Set Task Priority\n'),
          actions: <Widget>[
            new FlatButton(
              child: new Icon(Icons.new_releases_outlined),
              color: Colors.green,
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Icon(Icons.new_releases_outlined),
              color: Colors.yellow,
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
            new FlatButton(
              child: new Icon(Icons.new_releases_outlined),
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );

  }*/
}
