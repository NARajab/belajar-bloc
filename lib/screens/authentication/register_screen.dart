import 'package:belajar_bloc/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/register/register_bloc.dart';
import '../../blocs/auth/register/register_event.dart';
import '../../blocs/auth/register/register_state.dart';
import '../../components/primary_button.dart';
import '../../components/app_text_field.dart';
import 'package:another_flushbar/flushbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;
  String _selectedRole = 'Driver';

  void _register() {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _nikController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showFlushbar("All fields are required", Colors.orange);
      return;
    }

    final bloc = context.read<RegisterBloc>();
    bloc.add(RegisterSubmitted(
      username: _usernameController.text,
      email: _emailController.text,
      nik: _nikController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      role: _selectedRole,
    ));
  }

  void _showFlushbar(String message, Color color) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: color,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          // Tampilkan Flushbar saat berhasil
          Flushbar(
            message: "Register successful!",
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
            flushbarPosition: FlushbarPosition.TOP,
          ).show(context);

          // Navigasi ke LoginScreen setelah berhasil
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
        } else if (state is RegisterFailure) {
          Flushbar(
            message: state.error,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            flushbarPosition: FlushbarPosition.TOP,
          ).show(context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
            backgroundColor: const Color(0xFF304FFE),
            elevation: 5,
            shadowColor: Colors.black,
            titleTextStyle: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
            toolbarHeight: 55,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(width: 55, height: 3, color: Colors.white),
              ),
            ),
          ),
          body: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  const Text(
                    "Lets Join With Us",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40.0),
                  Center(
                      child: Image.asset('assets/images/register.png',
                          height: 250)),
                  const SizedBox(height: 10.0),
                  Card(
                    color: const Color.fromARGB(0, 255, 255, 255),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppTextField(
                            label: 'Username',
                            hintText: 'Enter your username',
                            controller: _usernameController,
                          ),
                          const SizedBox(height: 7),
                          AppTextField(
                            label: 'NIK',
                            hintText: 'Enter your NIK',
                            controller: _nikController,
                            helperText: '*Nomer Induk Karyawan',
                          ),
                          const SizedBox(height: 7),
                          AppTextField(
                            label: 'Email',
                            hintText: 'Enter your email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 7),
                          AppTextField(
                            label: 'Password',
                            hintText: 'Enter your password',
                            controller: _passwordController,
                            obscureText: !_passwordVisible,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 7),
                          AppTextField(
                            label: 'Phone Number',
                            hintText: 'Enter your phone number',
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                          const Text(
                            'Role',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Radio<String>(
                                    value: 'Driver',
                                    groupValue: _selectedRole,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedRole = value!;
                                      });
                                    },
                                  ),
                                  title: const Text('Driver'),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Radio<String>(
                                    value: 'Foreman',
                                    groupValue: _selectedRole,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedRole = value!;
                                      });
                                    },
                                  ),
                                  title: const Text('Foreman'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 50),
                              child: PrimaryButton(
                                text: 'Sign Up',
                                onPressed: _register,
                                width: MediaQuery.of(context).size.width * 0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))),
    );
  }
}
