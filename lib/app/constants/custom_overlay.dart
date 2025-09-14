import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fixbuddy/app/utils/theme.dart';

enum SnackAlignment { top, center, bottom }

enum SnackType {
  error(Icons.error),
  info(Icons.info_rounded),
  success(Icons.check_circle);

  const SnackType(this.icon);
  final IconData icon;
}

class CustomSnackbar {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;
  static OverlayEntry _createOverlayEntry(
    String? message,
    SnackAlignment alignment,
    SnackType type,
  ) {
    return OverlayEntry(
      builder: (context) => Stack(
        alignment: Alignment.center,
        // Without Stack we will not able to align our Snackbar at center of widget
        children: [
          Positioned(
            top: alignment == SnackAlignment.top ? kToolbarHeight : null,
            bottom: alignment == SnackAlignment.bottom ? kToolbarHeight : null,
            child: Material(
              color: type == SnackType.error
                  ? Colors.red
                  : type == SnackType.success
                  ? ThemeClass.successGreen
                  : ThemeClass.primaryColor,
              borderRadius: BorderRadius.circular(5),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(type.icon, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          message!,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: Colors.white, fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void show({
    String? message,
    required BuildContext context,
    SnackAlignment alignment = SnackAlignment.bottom,
    SnackType type = SnackType.success,
  }) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _timer?.cancel();
    }

    _overlayEntry = _createOverlayEntry(message!, alignment, type);
    _insertOverlay(context);
  }

  static Future<void> _insertOverlay(BuildContext context) async {
    Navigator.of(context).overlay!.insert(_overlayEntry!);

    _timer = Timer(const Duration(seconds: 3), () {
      if (_overlayEntry != null) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _timer?.cancel();
      }
    });
  }
}
