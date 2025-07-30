import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/login/login_bloc.dart';
import '../../blocs/auth/login/login_event.dart';
import '../../blocs/auth/login/login_state.dart';
import '../../blocs/auth/register/register_bloc.dart';
import '../../services/auth_service.dart';
import '../../repositories/auth_repository.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/autentications/register_service.dart';
import '../home/home_screen.dart';
import './register_screen.dart';
import './send_email_screen.dart';
import '../../components/primary_button.dart';
import '../../components/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool rememberMe = false;
  bool passwordVisible = false;

  final authRepository = AuthRepository(AuthService());

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _loadRememberedEmail();
  }

  Future<void> _loadRememberedEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rememberedEmail = prefs.getString('rememberedEmail');
    if (rememberedEmail != null) {
      setState(() {
        emailController.text = rememberedEmail;
        rememberMe = true;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
    return BlocProvider(
      create: (_) => LoginBloc(authRepository: authRepository),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              _showFlushbar(state.message, Colors.green);
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              });
            } else if (state is LoginFailure) {
              _showFlushbar(state.error, Colors.red);
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "Hi, Welcome Back! 👋",
                        style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Hello again, you've been missed!",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child:
                        Image.asset('assets/images/admin.png', height: 250),
                      ),
                      const SizedBox(height: 30),
                      AppTextField(
                        controller: emailController,
                        hintText: 'example@mail.com',
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: passwordController,
                        hintText: 'Please Enter Your Password',
                        label: 'Password',
                        obscureText: !passwordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() => passwordVisible = !passwordVisible);
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() => rememberMe = val);
                                  }
                                },
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                              ),
                              const Text('Remember Me'),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                    const SendEmailScreen()),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: PrimaryButton(
                          text: 'Login',
                          isLoading: isLoading,
                          width: MediaQuery.of(context).size.width * 0.8,
                          onPressed: () {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              _showFlushbar(
                                  'Email and password cannot be empty.',
                                  Colors.red);
                              return;
                            }

                            context.read<LoginBloc>().add(
                              LoginSubmitted(
                                email: email,
                                password: password,
                                rememberMe: rememberMe,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => RegisterBloc(RegisterServices()),
                                  child: const RegisterScreen(),
                                ),
                              ),
                            );
                          },

                          child: RichText(
                            text: const TextSpan(
                              text: "Don’t have an account ? ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              children: [
                                TextSpan(
                                  text: "Register",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
