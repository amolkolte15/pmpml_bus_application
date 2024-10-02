import 'package:flutter/material.dart';
import 'package:pmpml_map/location_search_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchLocationScreen()),
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
