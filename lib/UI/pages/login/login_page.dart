import 'package:flutter/material.dart';
import 'package:personal_health_app/UI/components/styled_text_form_field.dart';
import 'package:personal_health_app/UI/pages/login/login_page_presenter.dart';

import './../../mixins/navigation_manager.dart';

class LoginPage extends StatelessWidget with NavigationManager {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginPagePresenter presenter;

  LoginPage(
      {super.key,
      required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      handleNavigation(presenter.navigateToStream, clear: true);

      return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            image: DecorationImage(
              image:
                  AssetImage('assets/background_1920x1080.png'), // Local image
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira seu email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        StyledTextFormField(
                          controller: _passwordController,
                          label: 'Senha',
                          enableObscureText: true,
                          keyboardType: TextInputType.none,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            }
                            return null;
                          },
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
                          onPressed: () => presenter.login(
                              _emailController.text, _passwordController.text),
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
