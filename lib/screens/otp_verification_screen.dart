import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String email;
  final String type; // 'signup' or 'reset'

  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.type,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;
  bool _isResending = false;
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _otpVerified = false;

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String get _otp => _otpControllers.map((c) => c.text).join();

  Future<void> _verifyOtp() async {
    if (_otp.length != 6) {
      _showError('Please enter all 6 digits');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);

      if (widget.type == 'signup') {
        await authService.verifyOtp(email: widget.email, token: _otp, type: 'signup');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Email verified successfully!'),
              backgroundColor: const Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
          context.go('/login');
        }
      } else {
        await authService.verifyOtp(email: widget.email, token: _otp, type: 'recovery');

        setState(() {
          _otpVerified = true;
          _isLoading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('OTP verified! Now set your new password.'),
              backgroundColor: const Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        _showError('Invalid OTP: ${e.toString()}');
      }
    } finally {
      if (mounted && !_otpVerified) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resetPassword() async {
    if (_newPasswordController.text.isEmpty) {
      _showError('Please enter a new password');
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showError('Passwords do not match');
      return;
    }

    final passwordError = ref.read(authServiceProvider).validatePassword(_newPasswordController.text);
    if (passwordError != null) {
      _showError(passwordError);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      await authService.updatePassword(_newPasswordController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Password reset successfully!'),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        context.go('/login');
      }
    } catch (e) {
      if (mounted) {
        _showError('Failed to reset password: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resendOtp() async {
    setState(() => _isResending = true);

    try {
      final authService = ref.read(authServiceProvider);

      if (widget.type == 'signup') {
        await authService.resendSignupOtp(widget.email);
      } else {
        await authService.resendRecoveryOtp(widget.email);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('OTP resent successfully!'),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showError('Failed to resend OTP: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: isDark ? Colors.white : const Color(0xFF1A1A2E)),
                      onPressed: () => context.go('/login'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Icon
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _otpVerified
                            ? [const Color(0xFF10B981), const Color(0xFF34D399)]
                            : [const Color(0xFF6C63FF), const Color(0xFF8B85FF)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: (_otpVerified ? const Color(0xFF10B981) : const Color(0xFF6C63FF)).withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      _otpVerified ? Icons.lock_reset_rounded : Icons.verified_user_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),

                  Text(
                    _otpVerified ? 'Reset Password' : 'Verify OTP',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _otpVerified ? 'Enter your new password' : 'We\'ve sent a 6-digit code to\n${widget.email}',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  if (!_otpVerified) ...[
                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 50,
                          height: 60,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF252540) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
                              ),
                            ),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                _focusNodes[index + 1].requestFocus();
                              }
                              if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 32),
                    
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF8B85FF)]),
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
                        onPressed: _isLoading ? null : _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                              )
                            : const Text('Verify OTP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't receive the code? ", style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
                        TextButton(
                          onPressed: _isResending ? null : _resendOtp,
                          style: TextButton.styleFrom(foregroundColor: const Color(0xFF6C63FF), padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                          child: _isResending
                              ? const SizedBox(height: 14, width: 14, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Text('Resend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ],
                    ),
                  ] else ...[
                    // Password Reset Fields
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF252540) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: TextFormField(
                        controller: _newPasswordController,
                        obscureText: _obscureNewPassword,
                        style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1A1A2E)),
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          labelStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                          prefixIcon: Icon(Icons.lock_rounded, color: const Color(0xFF6C63FF).withOpacity(0.7)),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureNewPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                            onPressed: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF252540) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1A1A2E)),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                          prefixIcon: Icon(Icons.lock_outline_rounded, color: const Color(0xFF6C63FF).withOpacity(0.7)),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                            onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '• At least 6 characters\n• One uppercase letter\n• One lowercase letter\n• One number',
                        style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[500] : Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF34D399)]),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFF10B981).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: _isLoading
                            ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                            : const Text('Reset Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
