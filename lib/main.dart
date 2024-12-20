import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'screens/home_screen.dart';
import 'screens/project/project_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/customer_care_screen.dart';
import 'screens/product_screen.dart';
import 'widgets/bottomnavbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const MyHomePage(),
        AppRoutes.project: (_) => const ProjectScreen(),
        AppRoutes.chat: (_) => const ChatScreen(),
        AppRoutes.product: (_) => const ProductScreen(),
        AppRoutes.customercate: (_) => const EditImageScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ProjectScreen(),
    ChatScreen(),
    ProductScreen(),
    EditImageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
