import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forward_session/utils/app_dimensions.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _nameController = TextEditingController();

  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.asset('assets/signin.png'),
            verticalSpace(10.0),
            const Text(
              "Welcome!\nSign Up",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(15.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 25,
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        label: const Text('Name'),
                        hintText: 'Type your Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 25,
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        label: const Text('Email'),
                        hintText: 'abc@gmail.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 25,
                    ),
                    child: TextFormField(
                      obscureText: _hidePass,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        if (value.length < 7) {
                          return 'Password is too short';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: _hidePass
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _hidePass = !_hidePass;
                            });
                          },
                        ),
                        label: const Text('Password'),
                        hintText: '**********',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 25,
                    ),
                    child: TextFormField(
                      obscureText: _hidePass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        if (value != _passwordController.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: _hidePass
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _hidePass = !_hidePass;
                            });
                          },
                        ),
                        label: const Text('Confirm Password'),
                        hintText: '**********',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(25.0),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _auth.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    await _auth.currentUser!
                        .updateDisplayName(_nameController.text);
                    Navigator.of(context).pushReplacementNamed('/user-screen');
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            verticalSpace(25.0),
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    indent: 25,
                    endIndent: 15,
                    thickness: 2,
                  ),
                ),
                Text(
                  'Other Options',
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(
                  child: Divider(
                    indent: 15,
                    endIndent: 25,
                    thickness: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              child: const Text(
                'Log In',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
