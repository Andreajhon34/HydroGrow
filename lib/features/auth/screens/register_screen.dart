import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../widgets/auth_widgets.dart';

/// HydroGrow Register Screen.
///
/// Features:
///   - Full name, email, password, confirm-password fields
///   - Terms & Conditions checkbox
///   - 'Daftar Akun Baru' button with loading state
///   - Navigation back to [LoginScreen]
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  // ─── Validation ────────────────────────────────────────────────────────────

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.trim().length < 2) {
      return 'Nama minimal 2 karakter';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[\w\-.+]+@[\w\-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kata sandi tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Kata sandi minimal 6 karakter';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi kata sandi tidak boleh kosong';
    }
    if (value != _passwordController.text) {
      return 'Kata sandi tidak cocok';
    }
    return null;
  }

  // ─── Actions ───────────────────────────────────────────────────────────────

  Future<void> _onRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Harap setujui Syarat & Ketentuan terlebih dahulu',
          ),
          backgroundColor: AppColors.destructiveLight,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate network delay — replace with real registration logic.
    await Future.delayed(const Duration(milliseconds: 1800));

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Akun berhasil dibuat! Selamat berkebun 🌿'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    // Navigate back to Login after successful registration.
    Navigator.of(context).pop();
  }

  void _onTermsTap() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Syarat & Ketentuan'),
        content: const SingleChildScrollView(
          child: Text(
            'Dengan mendaftarkan akun, Anda menyetujui penggunaan data '
            'sesuai Kebijakan Privasi HydroGrow. Data Anda akan digunakan '
            'untuk memberikan layanan pemantauan tanaman hidroponik yang '
            'personal dan optimal.\n\n'
            'Kami berkomitmen untuk menjaga kerahasiaan informasi pribadi '
            'Anda dan tidak akan membagikan data kepada pihak ketiga tanpa '
            'izin Anda.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _agreeToTerms = true);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Setuju'),
          ),
        ],
      ),
    );
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mutedColor = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Back button + header ─────────────────────────────────────
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Kembali',
                  ),
                ),
                const SizedBox(height: 8),
                const HydroGrowHeader(
                  tagline: 'Mulai perjalanan hijau\nhidroponikmu hari ini!',
                ),
                const SizedBox(height: 40),

                // ── Card ─────────────────────────────────────────────────────
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Daftar',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lengkapi data dirimu untuk membuat akun baru.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: mutedColor),
                        ),
                        const SizedBox(height: 24),

                        // ── Full Name ────────────────────────────────────────
                        AuthTextField(
                          controller: _nameController,
                          focusNode: _nameFocus,
                          label: 'Nama Lengkap',
                          hint: 'John Doe',
                          prefixIcon: Icons.person_outline_rounded,
                          textInputAction: TextInputAction.next,
                          validator: _validateName,
                          autofillHints: const [AutofillHints.name],
                          onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                        ),
                        const SizedBox(height: 16),

                        // ── Email ────────────────────────────────────────────
                        AuthTextField(
                          controller: _emailController,
                          focusNode: _emailFocus,
                          label: 'Email',
                          hint: 'nama@email.com',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: _validateEmail,
                          autofillHints: const [AutofillHints.email],
                          onFieldSubmitted: (_) =>
                              _passwordFocus.requestFocus(),
                        ),
                        const SizedBox(height: 16),

                        // ── Password ─────────────────────────────────────────
                        AuthTextField(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          label: 'Kata Sandi',
                          hint: 'Minimal 6 karakter',
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          validator: _validatePassword,
                          autofillHints: const [AutofillHints.newPassword],
                          onFieldSubmitted: (_) => _confirmFocus.requestFocus(),
                        ),
                        const SizedBox(height: 16),

                        // ── Confirm Password ─────────────────────────────────
                        AuthTextField(
                          controller: _confirmPasswordController,
                          focusNode: _confirmFocus,
                          label: 'Konfirmasi Kata Sandi',
                          hint: 'Ulangi kata sandi',
                          prefixIcon: Icons.lock_reset_rounded,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          validator: _validateConfirmPassword,
                          autofillHints: const [AutofillHints.newPassword],
                          onFieldSubmitted: (_) => _onRegister(),
                        ),
                        const SizedBox(height: 20),

                        // ── Terms checkbox ───────────────────────────────────
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: _agreeToTerms,
                                onChanged: (v) =>
                                    setState(() => _agreeToTerms = v!),
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: mutedColor),
                                  children: [
                                    const TextSpan(text: 'Saya setuju dengan '),
                                    TextSpan(
                                      text: 'Syarat & Ketentuan',
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _onTermsTap,
                                    ),
                                    const TextSpan(text: ' yang berlaku'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // ── Register button ──────────────────────────────────
                        PrimaryButton(
                          label: 'Daftar Akun Baru',
                          onPressed: _onRegister,
                          isLoading: _isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Login link ───────────────────────────────────────────────
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: mutedColor),
                      children: [
                        const TextSpan(text: 'Sudah punya akun? '),
                        TextSpan(
                          text: 'Masuk',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
