import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

import 'package:flutter_svg/flutter_svg.dart';

/// Reusable branded text field for auth screens.
class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.validator,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscure,
      validator: widget.validator,
      autofillHints: widget.autofillHints,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, size: 20)
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
                tooltip: _obscure
                    ? 'Tampilkan kata sandi'
                    : 'Sembunyikan kata sandi',
              )
            : null,
      ),
    );
  }
}

/// A full-width elevated primary button with loading state.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryForeground,
                ),
              ),
            )
          : Text(label),
    );
  }
}

/// Divider with centered label (e.g. "atau").
class LabeledDivider extends StatelessWidget {
  const LabeledDivider({super.key, this.label = 'atau'});

  final String label;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.bodySmall?.color;
    return Row(
      children: [
        Expanded(child: Divider(color: color)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label, style: TextStyle(color: textColor, fontSize: 12)),
        ),
        Expanded(child: Divider(color: color)),
      ],
    );
  }
}

/// Google sign-in button following brand guidelines.
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _GoogleLogoIcon(size: 20),
          SvgPicture.asset('assets/icons/google.svg', height: 20, width: 20),
          const SizedBox(width: 10),
          Text(
            'Masuk dengan Google',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isDark
                  ? AppColors.foregroundDark
                  : AppColors.foregroundLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleLogoIcon extends StatelessWidget {
  const _GoogleLogoIcon({this.size = 24});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    // Blue arc (right)
    canvas.drawArc(
      rect,
      -0.25,
      1.57,
      false,
      Paint()
        ..color = AppColors.googleBlue
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18,
    );

    // Red arc (top-left)
    canvas.drawArc(
      rect,
      3.93,
      1.05,
      false,
      Paint()
        ..color = AppColors.googleRed
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18,
    );

    // Yellow arc (bottom-left)
    canvas.drawArc(
      rect,
      2.88,
      1.05,
      false,
      Paint()
        ..color = AppColors.googleYellow
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18,
    );

    // Green arc (bottom-right)
    canvas.drawArc(
      rect,
      -0.25 + 1.57,
      0.63,
      false,
      Paint()
        ..color = AppColors.googleGreen
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.18,
    );

    // Horizontal bar
    canvas.drawRect(
      Rect.fromLTRB(
        cx,
        cy - size.height * 0.09,
        cx + r * 0.75,
        cy + size.height * 0.09,
      ),
      Paint()..color = AppColors.googleBlue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// HydroGrow brand header (logo + tagline).
class HydroGrowHeader extends StatelessWidget {
  const HydroGrowHeader({
    super.key,
    this.tagline = 'Tanam, Pantau & Optimalkan\nKebun Hidroponikmu',
  });

  final String tagline;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        // Logo container
        Container(
          width: 80,
          height: 80,
          // decoration: BoxDecoration(
          //   color: AppColors.primary.withValues(alpha: 0.15),
          //   borderRadius: BorderRadius.circular(24),
          // ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Icon(
              //   Icons.water_drop_rounded,
              //   size: 32,
              //   color: AppColors.primary.withValues(alpha: 0.5),
              // ),
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.eco_rounded,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // App name
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineMedium,
            children: [
              TextSpan(
                text: 'Hydro',
                style: TextStyle(
                  color: isDark
                      ? AppColors.foregroundDark
                      : AppColors.foregroundLight,
                ),
              ),
              const TextSpan(
                text: 'Grow',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Tagline
        // Text(
        //   tagline,
        //   textAlign: TextAlign.center,
        //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        //     color: isDark
        //         ? AppColors.mutedForegroundDark
        //         : AppColors.mutedForegroundLight,
        //     height: 1.5,
        //   ),
        // ),
      ],
    );
  }
}
