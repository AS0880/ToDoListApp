import 'package:flutter/material.dart';
import 'package:todolist/widgets/todo_items.dart';
import '../model/todo.dart';

final todosList = ToDo.todoList;
final _todoController = TextEditingController();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 10, 5),
            child: Column(
              children: [
                textField(),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: todosList.length,
                    itemBuilder: (listViewContext, index){
                      return Dismissible(
                        key: Key(todosList.toString()),
                        child: ToDoItem(todo: todosList[index],),
                        onDismissed: (type) {
                          // final action = type == DismissDirection.endToStart;
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }


  Widget textField() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 5,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(120),
                ),
                child: TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                      hintText: "Write your task here",
                      border: InputBorder.none),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, right: 20),
              child: ElevatedButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _addToDoItem(_todoController.text);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: Size(45, 45),
                  elevation: 10,
                ),
              ),
            ),
          ],
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.lightBlueAccent,
    );
}}
