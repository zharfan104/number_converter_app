import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/app_colors.dart';
import '../ui/app_size_constants.dart';
import 'error_tooltip_overlay.dart';

const _kFocusedBorderWidth = 2.0;

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    this.errorMessage,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly = false,
    this.maxLines = 1,
    this.initialValue,
    this.hintText,
  });

  final String labelText;
  final Widget? prefixIcon;
  final String? errorMessage;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final int maxLines;
  final String? initialValue;
  final String? hintText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final GlobalKey _iconKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.errorMessage != widget.errorMessage) {
      _toggleErrorTooltipAfterPostFrame();

      return;
    }

    if (_overlayEntry == null) {
      _toggleErrorTooltipAfterPostFrame();

      return;
    }
  }

  void _toggleErrorTooltipAfterPostFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _toggleErrorTooltip();
    });
  }

  bool get hasErrorMessage => widget.errorMessage != null;

  void _toggleErrorTooltip() {
    if (_overlayEntry == null) {
      if (hasErrorMessage) {
        _overlayEntry = ErrorTooltipOverlay.createOverlayEntry(
          context,
          iconKey: _iconKey,
          message: widget.errorMessage!,
        );
        Overlay.of(context).insert(_overlayEntry!);
      }
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  InputBorder get defaultBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: hasErrorMessage ? AppColors.lightRed : AppColors.lightGrey,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: hasErrorMessage ? AppColors.lightRed : null,
          ),
        ),
        const SizedBox(height: kSpacingSmall),
        TextFormField(
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: hasErrorMessage
                ? GestureDetector(
                    onTap: _toggleErrorTooltip,
                    child: Icon(
                      Icons.info,
                      key: _iconKey,
                      color: AppColors.lightRed,
                    ),
                  )
                : null,
            hintText: widget.hintText,
            border: defaultBorder,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasErrorMessage ? AppColors.lightRed : AppColors.lightGrey,
                width: _kFocusedBorderWidth,
              ),
            ),
            enabledBorder: defaultBorder,
            disabledBorder: defaultBorder,
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
