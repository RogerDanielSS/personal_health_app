import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/usecases/usecases.dart';
import 'package:personal_health_app/presentation/components/styled_text_form_field.dart';

import '../../main/factories/pages/home_page/home_page_factory.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  LoginPage({
    super.key,
    required this.authentication,
    required this.saveCurrentAccount,
  });

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // Perform login logic here (e.g., API call)

      try {
        final account = await authentication
            .auth(AuthenticationParams(email: email, password: password));

        await saveCurrentAccount.save(account);

        // Navigate to the HomePage only if login is successful
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => makeHomePage()),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => makeHomePage()),
        );
      } catch (e) {
        // Handle any errors that occur during the login process
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again later.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
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
                          onPressed: () => _login(context),
                          child: Text('Entrar'),
                        ),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
