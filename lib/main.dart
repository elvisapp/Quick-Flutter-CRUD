import 'package:flutter/material.dart';
import 'api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  void _fetchItems() async {
    final items = await ApiService.getItems();
    setState(() {
      _items = items;
    });
  }

  void _addItem() async {
    if (_controller.text.isNotEmpty) {
      await ApiService.addItem(_controller.text);
      _fetchItems();
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aplicación Flutter Simple')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Nombre del Ítem'),
            ),
          ),
          ElevatedButton(
            onPressed: _addItem,
            child: Text('Agregar Ítem'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index]['name']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
