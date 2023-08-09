import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/model/parameters/register_params.dart';
import 'package:story_app/provider/register_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Akun"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Nama Lengkap",
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong.';
                      }
                      if (value.length < 8) {
                        return "Password harus lebih dari 8 karakter";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  const SizedBox(height: 8),
                  context.watch<RegisterProvider>().isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final form = formKey.currentState;
                              if (form!.validate()) {
                                await _registerButtonTapped();
                              }
                            },
                            child: const Text("Daftar"),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _registerButtonTapped() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final params = RegisterParams(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text);
    final provider = context.read<RegisterProvider>();
    final result = await provider.register(params);

    if (result && context.mounted) {
      context.pop('User berhasil dibuat');
    } else {
      scaffoldMessengerState.showSnackBar(
        SnackBar(content: Text(provider.message)),
      );
    }
  }
}
