import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            'Aguarde...',
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
