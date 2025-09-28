import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/pocketbase_service.dart';
import 'pages/login_page.dart';
import 'pages/character_list_page.dart';
import 'pages/add_character_page.dart';
import 'pages/edit_character_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<PocketBaseService>.value(
      value: PocketBaseService(),
      child: MaterialApp(
        title: 'PocketBase Characters',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginPage(),
          '/list': (_) => const CharacterListPage(),
          '/add': (_) => const AddCharacterPage(),
          '/edit': (_) => const EditCharacterPage(),
        },
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      ),
    );
  }
}
