import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:praktikum_1/application/login/bloc/login_bloc.dart';
import 'package:praktikum_1/application/register/view/register.dart';
import 'package:praktikum_1/view/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.submitting) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state.status == LoginStatus.success) {
            if (Navigator.canPop(context)) Navigator.of(context).pop(); // dismiss dialog
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MyHomePage()),
              );
            });
          } else if (state.status == LoginStatus.failure) {
            if (Navigator.canPop(context)) Navigator.of(context).pop(); // dismiss dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    state.errorMessage ?? "Login gagal",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 100.0,
                    child: Icon(Bootstrap.person, size: 100.0),
                  ),
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF881FFF),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  buildInputField("Email", "Masukkan Email", emailController,
                      onChanged: (email) {
                    context.read<LoginBloc>().add(LoginEmailChanged(email));
                  }),
                  const SizedBox(height: 10.0),
                  buildPasswordField(context, state),
                  const SizedBox(height: 30.0),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        final emailText = emailController.text.trim();
                        final passwordText = passwordController.text.trim();

                        if (emailText.isNotEmpty &&
                            passwordText.isNotEmpty) {
                          context.read<LoginBloc>().add(LoginSubmitted());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Field tidak boleh kosong'),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF881FFF),
                          borderRadius:
                              BorderRadius.all(Radius.circular(6.0)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: 'Belum punya akun? ',
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF881FFF)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInputField(
      String label, String hint, TextEditingController controller,
      {Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 16.0, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPasswordField(BuildContext context, LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8.0),
        TextField(
          controller: passwordController,
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginPasswordChanged(value));
          },
          obscureText: !passwordVisible,
          decoration: InputDecoration(
            hintText: 'Masukkan Password',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              child: Icon(passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
          ),
        ),
      ],
    );
  }
}
