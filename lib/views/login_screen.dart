import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image
          Image.asset(
            'assets/images/bg_pesantren.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: Colors.green[900]);
            },
          ),
          
          // 2. Green Overlay
          Container(
            color: Colors.green[900]?.withOpacity(0.6),
          ),
          
          // 3. Main Content
          SafeArea(
            child: Column(
              children: [
                // Top Section (Logo and Titles)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Shield Icon in Circle
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.security,
                              size: 40,
                              color: Colors.lightGreenAccent,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Title
                        const Text(
                          'Santri-Pass',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Subtitle
                        const Text(
                          'Secure Campus Monitoring',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Bottom Section (Login Card)
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Welcome Text
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Please login to continue security protocols',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Email/NPM Field
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email/NPM',
                            hintText: 'Enter your ID',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your ID';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        
                        // Password Field
                        TextFormField(
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: '••••••••',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        
                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // TODO: Implement forgot password
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacementNamed(context, '/dashboard');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // OR Divider
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'OR',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Register Subtitle
                        Center(
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        // Register Button
                        OutlinedButton(
                          onPressed: () {
                            // TODO: Implement registration navigation
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green[800],
                            side: BorderSide(color: Colors.green[800]!),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Register as New Security/Parent',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Encrypted Protocols Footer
                Container(
                  color: Colors.black87,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified_user_outlined, color: Colors.grey[400], size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'End-to-End Encrypted Protocols',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
