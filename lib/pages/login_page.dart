import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _signUpWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      _showError("");
        } catch (e) {
      _showError('Unexpected error occurred');
    }
  }

  Future<void> _signUpWithPhone() async {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    try {
      // Note: Supabase authentication with phone number might need additional setup
      final response = await Supabase.instance.client.auth.signUp(
        phone: phone,
        password: password,
      );

      _showError("");
        } catch (e) {
      _showError('Unexpected error occurred');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _signUpWithEmail,
                child: const Text('Sign Up with Email'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _signUpWithPhone,
                child: const Text('Sign Up with Phone'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
