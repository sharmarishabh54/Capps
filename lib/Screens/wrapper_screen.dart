import 'package:capps/Screens/screens.dart';
import 'package:capps/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WrapperScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authUser = watch(authStateChangedProvider).data?.value;
    if (authUser != null) {
      return Home();
    } else {
      return Onboarding();
    }
  }
}
