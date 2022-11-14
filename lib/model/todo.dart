class ToDo {
  String? id;
  String? todoText;

  ToDo({
    required this.id,
    required this.todoText,
  });


  static List<ToDo> todoList = [
      ToDo(id: '01', todoText: 'todoText'),
      ToDo(id: '02', todoText: 'todoText'),
      ToDo(id: '03', todoText: 'todoText')
];
}