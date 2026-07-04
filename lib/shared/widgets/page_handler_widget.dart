import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageHandlerWidget extends HookConsumerWidget {
  const PageHandlerWidget({
    required this.onRefresh,
    required this.child,
    required this.scrollController,
    this.onPaginate,
    this.enablePullUp,
    this.loading,
    super.key,
  });

  final bool? enablePullUp;
  final Future<void> Function()? onPaginate;
  final RefreshCallback onRefresh;
  final Widget child;
  final ScrollController scrollController;
  final bool? loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        scrollController.addListener(() async {
          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              (enablePullUp ?? true)) {
            if (onPaginate != null) {
              await onPaginate!();
            }
            if (scrollController.hasClients) {
              await scrollController.animateTo(
                scrollController.position.pixels + 100,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          }
        });
        return null;
      },
      [],
    );
    return Stack(
      children: [
        Align(child: RefreshIndicator(onRefresh: onRefresh, child: child)),
        if (loading ?? false)
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
