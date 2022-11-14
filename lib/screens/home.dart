import 'package:flutter/material.dart';
import 'package:todolist/widgets/todo_items.dart';
import '../model/todo.dart';

final todoList = ToDo.todoList;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController controller;
  bool isButtonActive = true;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      final isButtonActive = controller.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                    itemCount: todoList.length,
                    itemBuilder: (listViewContext, index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(todoList.toString()),
                        child: ToDoItem(
                          todo: todoList[index],
                        ),
                        onDismissed: (direction) {
                          todoList.removeAt(index);
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
      todoList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    controller.clear();
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
                  controller: controller, //_todoController,
                  //_todoController.addListener(() { final isButtonActive = controller.text.isNotEmpty})
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
                onPressed: isButtonActive
                    ? () {
                        setState(() => isButtonActive = false);
                        _addToDoItem(controller.text);
                      }
                    : null,
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
  }
}
