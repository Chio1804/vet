import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:praktikum_1/application/login/login.dart';
import 'package:praktikum_1/application/register/bloc/register_bloc.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state.status == RegisterStatus.submitting) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state.status == RegisterStatus.success) {
  Navigator.of(context).pop(); // dismiss loading

  if (mounted) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }
}
 else if (state.status == RegisterStatus.failure) {
                Navigator.of(context).pop(); // dismiss loading
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                      child: Text(
                        state.errorMessage ?? "Terjadi kesalahan",
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
              return Column(
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 100.0,
                        child: Icon(Bootstrap.person, size: 100.0),
                      ),
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF881FFF),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  buildInputField("Email", "Masukkan Email", emailController,
                      onChanged: (email) {
                    context
                        .read<RegisterBloc>()
                        .add(RegisterEmailChanged(email));
                  }),
                  const SizedBox(height: 10.0),
                  buildPasswordField(context, state),
                  const SizedBox(height: 20.0),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text("Sudah punya akun? "),
    GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
      child: const Text(
        "Login",
        style: TextStyle(
          color: Color(0xFF881FFF),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),

                  const SizedBox(height: 30.0),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        final emailText = emailController.text.trim();
                        final passwordText = passwordController.text.trim();

                        if (emailText.isNotEmpty &&
                            passwordText.isNotEmpty) {
                          context
                              .read<RegisterBloc>()
                              .add(RegisterSubmitted());
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
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Center(
                          child: Text(
                            "Register",
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
                ],
              );
            },
          ),
        ),
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
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
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

  Widget buildPasswordField(BuildContext context, RegisterState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8.0),
        TextField(
          controller: passwordController,
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(RegisterPasswordChanged(value));
          },
          obscureText: passwordVisible,
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
              child: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
      ],
    );
  }
}
