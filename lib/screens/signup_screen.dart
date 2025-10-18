import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateEmailRealtime() {
    setState(() {
      _emailError = ref.read(authServiceProvider).validateEmail(_emailController.text);
    });
  }

  void _validatePasswordRealtime() {
    setState(() {
      _passwordError = ref.read(authServiceProvider).validatePassword(_passwordController.text);
    });
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final response = await authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        if (response.user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Please check your email for the verification code.'),
              backgroundColor: const Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
          context.push('/verify-otp', extra: {
            'email': _emailController.text.trim(),
            'type': 'signup',
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup failed: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [const Color(0xFF0F0F1E), const Color(0xFF1A1A2E)]
                : [const Color(0xFFF8F9FE), const Color(0xFFEEF1FF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                        ),
                        onPressed: () => context.go('/login'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Logo
                    Hero(
                      tag: 'app_logo',
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [const Color(0xFF8B85FF), const Color(0xFF6C63FF)]
                                : [const Color(0xFF6C63FF), const Color(0xFF8B85FF)],
                          ),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C63FF).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.shopping_bag_rounded,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join Bazar Sodai today',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            fontSize: 16,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Email Field
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF252540) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: const Color(0xFF6C63FF).withOpacity(0.7),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        onChanged: (_) => _validateEmailRealtime(),
                        validator: (value) {
                          return ref.read(authServiceProvider).validateEmail(value ?? '');
                        },
                      ),
                    ),
                    if (_emailError != null && _emailController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 16),
                        child: Text(
                          _emailError!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF252540) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: TextStyle(
                          color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: const Color(0xFF6C63FF).withOpacity(0.7),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        onChanged: (_) => _validatePasswordRealtime(),
                        validator: (value) {
                          return ref.read(authServiceProvider).validatePassword(value ?? '');
                        },
                      ),
                    ),
                    if (_passwordError != null && _passwordController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 16),
                        child: Text(
                          _passwordError!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Confirm Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF252540) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        style: TextStyle(
                          color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            color: const Color(0xFF6C63FF).withOpacity(0.7),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                            onPressed: () {
                              setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Sign Up Button
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C63FF).withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sign In Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go('/login'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF6C63FF),
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
