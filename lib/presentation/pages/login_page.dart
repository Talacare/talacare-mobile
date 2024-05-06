import "package:flutter/material.dart";
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/injection.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  SnackBar buildSnackBar() {
    return const SnackBar(
      key: Key('snack_bar'),
      backgroundColor: Colors.red,
      content: Text(
        'Failed to sign in. Try again.',
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  key: const Key('login_preview'),
                  child: SizedBox(
                    width: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/images/login_preview.png'),
                    ),
                  ),
                ),
                const Gap(60),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    if (authProvider.isError) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(buildSnackBar());
                        },
                      );
                    }
                    return Button(
                      key: const Key('login_button'),
                      isLoading: authProvider.isLoading,
                      text: 'Masuk',
                      onTap: () async =>
                          await getIt<AuthProvider>().signInWithGoogle(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
