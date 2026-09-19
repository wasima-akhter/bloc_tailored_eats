import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import 'reset_password_page.dart';

class VerifyForgotPasswordPage extends StatefulWidget {
  const VerifyForgotPasswordPage({super.key, required this.email});

  final String email;

  @override
  State<VerifyForgotPasswordPage> createState() =>
      _VerifyForgotPasswordPageState();
}

class _VerifyForgotPasswordPageState extends State<VerifyForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verify() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthCubit>().verifyForgotPasswordOtp(
      email: widget.email,
      otp: _otpController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            final token = context
                .read<AuthCubit>()
                .forgotPasswordActivationToken;

            if (token == null || token.isEmpty) {
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResetPasswordPage(token: token),
              ),
            );
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 32),

                      const Text(
                        'Enter verification code',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text('Enter the OTP sent to ${widget.email}.'),

                      const SizedBox(height: 32),

                      AuthTextField(
                        controller: _otpController,
                        label: 'OTP',
                        hint: 'Enter OTP',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'OTP is required';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      AuthButton(
                        text: 'Verify OTP',
                        isLoading: state is AuthLoading,
                        onPressed: _verify,
                      ),
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
