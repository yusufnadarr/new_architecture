import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/bottomBar/view/bottom_bar_view.dart';
import '../../../presentation/bottomBar/view/tests.dart';
import '../../../presentation/home/view/home_view.dart';
import '../../../presentation/landing/cubit/landing_cubit.dart';
import '../../../presentation/landing/cubit/landing_state.dart';
import '../../../presentation/landing/view/landing_view.dart';
import '../../../presentation/login/view/login_view.dart';
import '../../constants/page/page_constants.dart';
import 'router_refresh.dart';

class AppRouter {
  static final _navigatorKey = GlobalKey<NavigatorState>();
  static final _sectionNavigatorKey = GlobalKey<NavigatorState>();
  static final _sectionNavigatorKey2 = GlobalKey<NavigatorState>();
  static final _sectionNavigatorKey3 = GlobalKey<NavigatorState>();

  LandingCubit loginCubit;

  AppRouter(this.loginCubit);

  late final GoRouter router = GoRouter(
    navigatorKey: _navigatorKey,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BottomBarView(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: PageConstants.test1,
                builder: (context, state) => const Test1(),
                routes: <RouteBase>[
                  GoRoute(
                    path: PageConstants.test1Detail,
                    builder: (context, state) => const Test1Detail(),
                  )
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: PageConstants.test2,
                builder: (context, state) => const Test2(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: PageConstants.test3,
                builder: (context, state) => const Test3(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: PageConstants.landing,
        builder: (BuildContext context, GoRouterState state) {
          return const LandingView();
        },
      ),
      GoRoute(
        path: PageConstants.home,
        pageBuilder: (context, state) {
          //final id = state.pathParameters['id'];
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const HomeView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        path: PageConstants.login,
        pageBuilder: (context, state) {
          return CustomTransitionPage<void>(
            key: state.pageKey,
            child: const LoginView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
    ],
    refreshListenable: RouterRefresh(loginCubit.stream),
    redirect: (context, state) {
      if (loginCubit.state == InitialState()) {
        return PageConstants.landing;
      } else if (loginCubit.state == LoginState() &&
          state.fullPath == PageConstants.landing) {
        return PageConstants.login;
      } else if (loginCubit.state == LoggedState() &&
          state.fullPath == PageConstants.landing) {
        return PageConstants.test1;
      }
      return null;
    },
  );
}
