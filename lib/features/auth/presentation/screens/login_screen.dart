import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/di/storage_providers.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/primary_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);

    await ref.read(secureStorageProvider).writeAuthToken('sample_access_token');
    await ref
        .read(secureStorageProvider)
        .writeRefreshToken('sample_refresh_token');

    if (!mounted) {
      return;
    }

    setState(() => _isLoading = false);
    context.go(RoutePaths.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: AppSpacing.paddingAllLg,
        child: Column(
          children: [
            AppTextField(controller: _userController, label: 'Username'),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _passwordController,
              label: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: AppSpacing.xxl),
            PrimaryButton(
              label: 'Login',
              onPressed: _login,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
