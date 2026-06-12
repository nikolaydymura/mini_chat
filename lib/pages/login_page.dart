import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/user_cubit/user_cubit.dart';
import '../module/di_root.dart';

@RoutePage()
class LoginPage extends StatefulWidget implements AutoRouteWrapper {
  const LoginPage({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<LoginPage> createState() => _LoginPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider.value(value: registry.get<UserCubit>())],
      child: this,
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loginEnabled = false;
  bool _signInBusy = false;
  bool _signUpBusy = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateLoginEnabled);
    _passwordController.addListener(_updateLoginEnabled);
  }

  void _updateLoginEnabled() {
    final emailValid = _emailController.text.contains('@');
    final passwordValid = _passwordController.text.length >= 6;
    final loginEnabled = emailValid && passwordValid;
    _errorMessage = null;
    _loginEnabled = loginEnabled;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_errorMessage != null) ...[
              Text(_errorMessage!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),
            ],
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Type your email',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Type your password',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _loginEnabled && !_signInBusy
                      ? _signInClicked
                      : null,
                  child: _signInBusy
                      ? CircularProgressIndicator.adaptive()
                      : Text('Sing In'),
                ),
                TextButton(
                  onPressed: _loginEnabled && !_signUpBusy
                      ? _signUpClicked
                      : null,
                  child: _signUpBusy
                      ? CircularProgressIndicator.adaptive()
                      : Text('Sing Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signInClicked() async {
    setState(() {
      _signInBusy = true;
    });
    try {
      await context.read<UserCubit>().signIn(
        _emailController.text,
        _passwordController.text,
      );
      widget.onContinue();
    } catch (e, trace) {
      debugPrint('Error during sign up: $e');
      debugPrintStack(stackTrace: trace);
      _errorMessage = 'Email or password is incorrect';
      setState(() {});
    } finally {
      setState(() {
        _signInBusy = false;
      });
    }
  }

  void _signUpClicked() async {
    setState(() {
      _signUpBusy = true;
    });
    try {
      await context.read<UserCubit>().signUp(
        _emailController.text,
        _passwordController.text,
      );
      widget.onContinue();
    } catch (e, trace) {
      debugPrint('Error during sign up: $e');
      debugPrintStack(stackTrace: trace);
      _errorMessage = 'Something went wrong during sign up';
      setState(() {});
    } finally {
      setState(() {
        _signUpBusy = false;
      });
    }
  }
}
