import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 29, 29, 1),
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Color.fromRGBO(255, 27, 27, 1),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed 
        backgroundColor: Color.fromRGBO(33, 29, 29, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: 
              Icon(
                  Icons.home,
                  size: 50),
            label: 'Home Page'
          ),
          BottomNavigationBarItem(
            icon: 
              Icon(
                  Icons.settings_outlined,
                  size: 50),
            label: 'Project'
          ),
          BottomNavigationBarItem(
            icon: 
              Icon(
                  Icons.home,
                  size: 50),
            label: 'Chat'
          ),
          BottomNavigationBarItem(
            icon: 
              Icon(
                  Icons.home,
                  size: 50),
            label: 'Product'
          ),
          BottomNavigationBarItem(
            icon: 
              Icon(
                  Icons.home,
                  size: 50),
            label: 'Customer Care',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}