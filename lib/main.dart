import 'package:example_architecture/core/services/locator/locator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/router/app_router.dart';
import 'presentation/landing/cubit/landing_cubit.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LandingCubit>(
      create: (BuildContext context) => LandingCubit()..controlUser(),
      child: Builder(
        builder: (BuildContext context) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routerConfig: AppRouter(context.read<LandingCubit>()).router,
        ),
      ),
    );
  }
}
