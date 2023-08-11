import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/model/parameters/login_params.dart';
import 'package:story_app/provider/auth_provider.dart';
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

  bool passwordVisible = false;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
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
      resizeToAvoidBottomInset: false,
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
                          if (value.length < 8) {
                            return "Password harus lebih dari 8 karakter";
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
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        obscureText: !passwordVisible,
                      ),
                      const SizedBox(height: 16),
                      context.watch<LoginProvider>().isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final form = formKey.currentState;
                                  if (form!.validate()) {
                                    await _loginButtonTapped();
                                  }
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
                // const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginButtonTapped() async {
    final ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    final params = LoginParams(
        email: emailController.text, password: passwordController.text);
    final provider = context.read<LoginProvider>();
    final authProvider = context.read<AuthProvider>();
    final result = await provider.doLogin(params);
    authProvider.successLogin();

    if (result && context.mounted) {
      context.go("/");
    } else {
      scaffoldMessengerState.showSnackBar(
        SnackBar(content: Text(provider.message)),
      );
    }
  }
}
