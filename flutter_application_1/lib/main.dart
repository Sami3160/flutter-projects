
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TodoPageState();
  }
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController controller = TextEditingController();
  final List<String> todos = [];
  final List<bool> editable = [];
  final List<TextEditingController> editControllers = [];
  void addTodo() {
    if (controller.text.trim().isEmpty) return;
    setState(() {
      todos.add(controller.text.trim());
      editable.add(false);
      editControllers.add(TextEditingController(text:controller.text.trim()));
      controller.clear();
    });
  }

  void removeTodo(index) {
    setState(() {
      todos.removeAt(index);
      editable.removeAt(index);
    });
  }

  void makeEditable(index) {
    setState(() {
      editable[index] = true;
    });
  }
  void editText(index) {
    setState(() {
      if(editControllers[index].text.trim().isEmpty)return;
      todos[index]=editControllers[index].text.trim();
      editable[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App")),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 60),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(225, 96, 27, 0.774),
                      blurRadius: 20,
                      offset: Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: const Color.fromARGB(204, 158, 158, 158),
                          ),
                        ),
                      ),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "Email or Phone Number",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70),
              GestureDetector(
                onTap: addTodo,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.orange[900],
                  ),
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 70),
              Expanded(
                child: todos.isEmpty
                    ? Center(child: Text("No item added"))
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: editable[index]
                                    ? TextField(
                                        decoration: InputDecoration(
                                          hintText: "update ${todos[index]}",
                                        ),
                                      )
                                    : Text(todos[index]),
                                trailing: Wrap(
                                  children: [
                                    editable[index]
                                        ? IconButton(
                                            onPressed: () => editText(index),
                                            icon: Icon(
                                              Icons.done,
                                              color: Colors.blue,
                                            ),
                                          )
                                        : 
                                          IconButton(
                                            onPressed: () =>
                                                makeEditable(index),
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.blue[700],
                                            ),
                                          ),

                                    IconButton(
                                      onPressed: () => removeTodo(index),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
