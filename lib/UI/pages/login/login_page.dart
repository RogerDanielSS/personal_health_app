import 'package:flutter/material.dart';
import 'package:personal_health_app/UI/components/password_form_field/password_form_field.dart';
import 'package:personal_health_app/UI/components/styled_text_form_field/styled_text_form_field.dart';
import 'package:personal_health_app/UI/pages/login/login_page_presenter.dart';
import '../../mixins/mixins.dart';

class LoginPage extends StatefulWidget {
  final LoginPagePresenter presenter;

  const LoginPage({super.key, required this.presenter});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with NavigationManager, UIErrorManager {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set up navigation and error handling when the widget is initialized
    handleNavigation(widget.presenter.navigateToStream);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Error handling might need context, so we set it up after dependencies are resolved
    handleMainError(context, widget.presenter.mainErrorStream);
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.presenter.login(_emailController.text, _passwordController.text);
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          image: const DecorationImage(
            image: AssetImage('assets/background_1920x1080.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/logo_128.png',
                height: 200,
              ),
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyledTextFormField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: widget.presenter.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    StyledPasswordFormField(
                      controller: _passwordController,
                      label: 'Senha',
                      validator: widget.presenter.validatePassword,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: _submitForm,
                      child: const Text('Entrar'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}