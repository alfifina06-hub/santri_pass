import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate initialization and navigation to Dashboard
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, '/dashboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/bg_pesantren.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: Colors.green[900]);
            },
          ),
          
          // Greenish/Dark Overlay to make text readable
          Container(
            color: Colors.green[900]?.withOpacity(0.6), // Adjust opacity and color as needed
          ),
          
          // Main Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green.shade800, width: 4),
                ),
                child: Center(
                  child: Icon(
                    Icons.security, // or Icons.shield
                    size: 50,
                    color: Colors.green.shade900,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Title
              const Text(
                'Santri-Pass',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              
              // Subtitle
              const Text(
                'Secure, Serene, & Integrated\nCampus Management',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
              const Spacer(flex: 2),
              
              // Progress Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                ),
              ),
              const SizedBox(height: 20),
              
              // Status Text
              Text(
                'INITIALIZING SECURITY PROTOCOLS...',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(flex: 1),
              
              // Footer
              Text(
                'VERSION 2.4.0 • POWERED BY BOARDING OS',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.6),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
