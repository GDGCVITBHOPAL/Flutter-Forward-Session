import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('GDSC SESSION'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '${user!.displayName}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _auth.signOut();
          Navigator.pushReplacementNamed(context, '/login');
        },
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
      ),
    );
  }
}
