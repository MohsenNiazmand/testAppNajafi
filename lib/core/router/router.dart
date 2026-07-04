import 'package:go_router/go_router.dart';
import 'package:test_app_najafi/features/home/presentation/pages/home_page.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
