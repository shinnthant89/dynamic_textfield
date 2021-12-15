import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> addList = [];
  final List<TextEditingController> controllers = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Element Control"),
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final controller = TextEditingController();
              final field = Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "name ${controllers.length + 1}",
                    ),
                  ));

              setState(() {
                controllers.add(controller);
                addList.add(field);
              });
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (addList.isNotEmpty) {
                  addList.removeLast();
                  controllers.removeLast();
                  setState(() {});
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: addList.length,
                  itemBuilder: (context, index) {
                    return addList[index];
                  }),
            ),
            TextButton(
                onPressed: () async {
                  String text = controllers
                      .where((element) => element.text.isNotEmpty)
                      .fold(
                          "",
                          (previousValue, element) =>
                              previousValue += element.text + '\n');

                  final alert = AlertDialog(
                    title: Text("Count: ${controllers.length}"),
                    content: Text(text.trim()),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => alert,
                  );
                  setState(() {});
                },
                child: const Text('Show Message'))
          ],
        ));
  }
}
