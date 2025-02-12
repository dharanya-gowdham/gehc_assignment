import 'package:flutter/material.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlayWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
