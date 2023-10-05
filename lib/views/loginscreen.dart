import 'package:flutter/material.dart';
import 'package:flutter_pembukuan_transaksi_benkel/models/login.dart';
import 'package:flutter_pembukuan_transaksi_benkel/providers/login_screen_provider.dart';
import 'package:flutter_pembukuan_transaksi_benkel/views/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // get token from shared preferences
      final token = await SharedPreferences.getInstance();
      if (token.getString('token') != null) {
        // ignore: use_build_context_synchronously
        if (!context.mounted) return;
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const MainScreen();
          },
        ));
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // create a simple login screen
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(34.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // future delayed zero
                      // to make sure the state is updated
                      Future.delayed(Duration.zero, () async {
                        await context.read<LoginScreenProvider>().login(
                              LoginModel(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                        // ignore: use_build_context_synchronously
                        if (!context.mounted) return;
                        if (context.read<LoginScreenProvider>().status ==
                            'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Berhasil Login'),
                            ),
                          );
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const MainScreen();
                            },
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Username / Password Salah'),
                            ),
                          );
                        }
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(200, 50)),
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
