import 'package:flutter/material.dart';
import 'package:flutter_chat/components/auth_form.dart';
import 'package:flutter_chat/core/models/auth_form_data.dart';
import 'package:flutter_chat/core/services/auth/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() {
        _isLoading = true;
      });

      if (formData.isLogin) {
        await AuthService().login(formData.email, formData.password);
      } else {
        await AuthService().signup(
            formData.name, formData.email, formData.password, formData.image);
      }
    } catch (e) {
      //tratar erro
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(children: [
        Center(
          child: SingleChildScrollView(
            child: AuthForm(onSubmit: _handleSubmit),
          ),
        ),
        if (_isLoading)
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
