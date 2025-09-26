import 'package:flutter/material.dart';
import 'package:personal_health_app/UI/components/password_form_field/password_form_field.dart';
import 'package:personal_health_app/UI/components/styled_text_form_field/styled_text_form_field.dart';
// import 'package:personal_health_app/UI/components/styled_text_form_field.dart';
import 'package:personal_health_app/UI/pages/login/login_page_presenter.dart';

import '../../mixins/mixins.dart';
class LoginPage extends StatelessWidget with NavigationManager, UIErrorManager {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginPagePresenter presenter;

  LoginPage({super.key, required this.presenter});

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      presenter.login(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      handleNavigation(presenter.navigateToStream);
      handleMainError(context, presenter.mainErrorStream);

      return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            image: DecorationImage(
              image:
                  AssetImage('assets/background_1920x1080.png'), // Local image
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            spacing: 40,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/logo_128.png',
                  height: 200,
                ),
              ),
              Form(
                  key: _formKey,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StyledTextFormField(
                          controller: _emailController,
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: presenter.validateEmail,
                        ),
                        SizedBox(height: 16),
                        StyledPasswordFormField(
                          controller: _passwordController,
                          label: 'Senha',
                          validator: presenter.validatePassword,
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.black),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: _submitForm,
                          child: Text('Entrar'),
                        ),
                      ],
                    ),
                  )),
            ],
          ));
    }));
  }
}
