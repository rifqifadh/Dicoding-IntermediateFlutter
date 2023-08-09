import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/model/parameters/login_params.dart';
import 'package:story_app/provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selamat Datang.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              const Text(
                "Silahkan login menggunakan akun yg sudah terdaftar.",
              ),
              const Spacer(flex: 1),
              const SizedBox(height: 32),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email.';
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
                          return 'Please enter your password.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Passwotd",
                      ),
                    ),
                    const SizedBox(height: 16),
                    context.watch<LoginProvider>().isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _loginButtonTapped();
                              },
                              child: const Text("Login"),
                            ),
                          ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          final String? result =
                              await context.push("/register");
                          if (result != null &&
                              result.isNotEmpty &&
                              context.mounted) {
                            final ScaffoldMessengerState
                                scaffoldMessengerState =
                                ScaffoldMessenger.of(context);
                            scaffoldMessengerState.showSnackBar(
                              SnackBar(content: Text(result)),
                            );
                          }
                        },
                        child: const Text("Daftar"),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      )),
    );
  }

  _loginButtonTapped() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final params = LoginParams(
        email: emailController.text, password: passwordController.text);
    final provider = context.read<LoginProvider>();
    final result = await provider.doLogin(params);

    if (result && context.mounted) {
      context.go("/");
    } else {
      scaffoldMessengerState.showSnackBar(
        SnackBar(content: Text(provider.message)),
      );
    }
  }
}
