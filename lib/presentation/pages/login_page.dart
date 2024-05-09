import "package:flutter/material.dart";
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/widgets/custom_notification.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    return Button(
                      key: const Key('login_button'),
                      isLoading: authProvider.isLoading,
                      text: 'Masuk',
                      onTap: () async => {
                        await getIt<AuthProvider>().signInWithGoogle(),
                        if (authProvider.isError) {
                            CustomNotification.show(
                              // ignore: use_build_context_synchronously
                              context,
                              message: 'Silakan coba lagi',
                              isSuccess: false,
                            )
                        } else if (authProvider.user != null || true) {
                            CustomNotification.show(
                              // ignore: use_build_context_synchronously
                              context,
                              message: 'Anda berhasil masuk',
                            )
                        }
                      },
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
