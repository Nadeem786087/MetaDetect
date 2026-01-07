import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MetaDetectApp());
}

class MetaDetectApp extends StatelessWidget {
  const MetaDetectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MetaDetect',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD81B60),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            elevation: 2,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD81B60), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.elasticOut),
      ),
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );
    
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD81B60),
              Color(0xFFAD1457),
              Color(0xFF880E4F),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                padding: const EdgeInsets.all(28),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.favorite,
                                  size: 80,
                                  color: Color(0xFFD81B60),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'MetaDetect',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black26,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Evidence-Based Screening',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Early Detection • Better Outcomes',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 50),
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Initializing Clinical Protocol...',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.health_and_safety,
      title: 'Clinical-Grade Screening',
      description: 'Based on WHO, NCCN & American Cancer Society guidelines. Evidence-based assessment tailored for you.',
      color: Color(0xFFD81B60),
    ),
    OnboardingPage(
      icon: Icons.lock_outline,
      title: '100% Private & Secure',
      description: 'All data stays on your device. No internet required. No data collection. Your privacy guaranteed.',
      color: Color(0xFF1976D2),
    ),
    OnboardingPage(
      icon: Icons.people_outline,
      title: 'Serving Underserved',
      description: 'Designed for communities with limited healthcare access. Free, accessible, and culturally sensitive.',
      color: Color(0xFF388E3C),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  if (_currentPage < _pages.length - 1)
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text('Skip'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 100,
              color: page.color,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: page.color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            page.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  
  String? _gender;
  String? _ethnicity;
  String? _familyHistory;
  String? _previousConditions;
  String? _medications;
  String? _smoking;
  String? _alcohol;
  
  bool _agreedToTerms = false;
  bool _understandsLimitations = false;
  bool _consentForResearch = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      if (_validateCurrentStep()) {
        setState(() => _currentStep++);
        _pageController.animateToPage(
          _currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _proceed();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        if (_nameController.text.trim().isEmpty) {
          _showSnackBar('Please enter your name', Colors.orange);
          return false;
        }
        if (_ageController.text.trim().isEmpty) {
          _showSnackBar('Please enter your age', Colors.orange);
          return false;
        }
        return true;
      case 3:
        if (!_agreedToTerms || !_understandsLimitations) {
          _showSnackBar('Please accept all required terms', Colors.orange);
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _proceed() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms || !_understandsLimitations) {
      _showSnackBar('Please accept all required terms to continue', Colors.red);
      return;
    }

    final profile = UserProfile(
      name: _nameController.text.trim(),
      age: int.tryParse(_ageController.text) ?? 0,
      gender: _gender,
      ethnicity: _ethnicity,
      familyHistory: _familyHistory,
      previousConditions: _previousConditions,
      medications: _medications,
      smoking: _smoking,
      alcohol: _alcohol,
      bmi: _calculateBMI(),
      consentForResearch: _consentForResearch,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => WelcomeScreen(profile: profile),
      ),
    );
  }

  double _calculateBMI() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    final height = double.tryParse(_heightController.text) ?? 0;
    return height > 0 ? weight / (height * height) : 0;
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Information'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildBasicInfoStep(),
                  _buildMedicalHistoryStep(),
                  _buildLifestyleStep(),
                  _buildConsentStep(),
                ],
              ),
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (_currentStep + 1) / 4,
                    minHeight: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Step ${_currentStep + 1}/4',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _getStepTitle(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0: return 'Basic Information';
      case 1: return 'Medical History';
      case 2: return 'Lifestyle Factors';
      case 3: return 'Consent & Privacy';
      default: return '';
    }
  }

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Information',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Help us personalize your assessment',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Full Name *',
              prefixIcon: Icon(Icons.person_outline),
              hintText: 'Enter your name',
            ),
            validator: (v) => v!.trim().isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age *',
              prefixIcon: Icon(Icons.calendar_today_outlined),
              suffixText: 'years',
              hintText: 'Enter your age',
            ),
            validator: (v) {
              if (v!.isEmpty) return 'Required';
              final age = int.tryParse(v);
              if (age == null || age < 10 || age > 120) {
                return 'Enter valid age (10-120)';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _gender,
            decoration: const InputDecoration(
              labelText: 'Gender',
              prefixIcon: Icon(Icons.wc_outlined),
            ),
            items: ['Female', 'Male', 'Other', 'Prefer not to say']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => _gender = v),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _ethnicity,
            decoration: const InputDecoration(
              labelText: 'Ethnicity (for risk assessment)',
              prefixIcon: Icon(Icons.public_outlined),
            ),
            items: ['Caucasian', 'African American', 'Hispanic/Latino', 'Asian', 'Mixed', 'Other']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => _ethnicity = v),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalHistoryStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Medical History',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Important for accurate risk assessment',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: _familyHistory,
            decoration: const InputDecoration(
              labelText: 'Family History of Breast/Ovarian Cancer',
              prefixIcon: Icon(Icons.family_restroom),
            ),
            items: [
              'None',
              'First-degree relative (mother, sister, daughter)',
              'Second-degree relative (aunt, grandmother)',
              'Multiple relatives',
              'Unknown'
            ].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
            onChanged: (v) => setState(() => _familyHistory = v),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: _previousConditions,
            decoration: const InputDecoration(
              labelText: 'Previous Breast Conditions',
              prefixIcon: Icon(Icons.medical_information_outlined),
              hintText: 'e.g., benign lumps, cysts',
            ),
            maxLines: 2,
            onChanged: (v) => _previousConditions = v,
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: _medications,
            decoration: const InputDecoration(
              labelText: 'Current Medications',
              prefixIcon: Icon(Icons.medication_outlined),
              hintText: 'List any regular medications',
            ),
            maxLines: 2,
            onChanged: (v) => _medications = v,
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyleStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lifestyle Factors',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'These factors affect breast cancer risk',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: _smoking,
            decoration: const InputDecoration(
              labelText: 'Smoking Status',
              prefixIcon: Icon(Icons.smoking_rooms_outlined),
            ),
            items: ['Never', 'Former smoker', 'Current smoker']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => _smoking = v),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _alcohol,
            decoration: const InputDecoration(
              labelText: 'Alcohol Consumption',
              prefixIcon: Icon(Icons.local_bar_outlined),
            ),
            items: [
              'None',
              'Light (1-7 drinks/week)',
              'Moderate (8-14 drinks/week)',
              'Heavy (15+ drinks/week)'
            ].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
            onChanged: (v) => setState(() => _alcohol = v),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Weight',
                    suffixText: 'kg',
                    prefixIcon: Icon(Icons.monitor_weight_outlined),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Height',
                    suffixText: 'm',
                    prefixIcon: Icon(Icons.height_outlined),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_calculateBMI() > 0)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.analytics_outlined, color: Colors.blue[700], size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'BMI: ${_calculateBMI().toStringAsFixed(1)}',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildConsentStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Consent & Privacy',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Please review and accept',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.lock, color: Colors.green[700]),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your Privacy: All data stays on your device. No internet connection required.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green[900],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            value: _agreedToTerms,
            onChanged: (v) => setState(() => _agreedToTerms = v!),
            title: const Text(
              'I understand this is a screening tool, not a diagnostic test, and does not replace professional medical examination.',
              style: TextStyle(fontSize: 13),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          const Divider(),
          CheckboxListTile(
            value: _understandsLimitations,
            onChanged: (v) => setState(() => _understandsLimitations = v!),
            title: const Text(
              'I will seek immediate medical attention if I have severe symptoms, regardless of screening results.',
              style: TextStyle(fontSize: 13),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          const Divider(),
          CheckboxListTile(
            value: _consentForResearch,
            onChanged: (v) => setState(() => _consentForResearch = v!),
            title: const Text(
              'I consent to anonymized data use in bioinformatics research (optional)',
              style: TextStyle(fontSize: 13),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _previousStep,
                  icon: const Icon(Icons.arrow_back, size: 20),
                  label: const Text('Back'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 12),
            Expanded(
              flex: _currentStep == 0 ? 1 : 1,
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentStep == 3 ? 'Complete' : 'Next',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Icon(_currentStep == 3 ? Icons.check_circle : Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfile {
  final String name;
  final int age;
  final String? gender;
  final String? ethnicity;
  final String? familyHistory;
  final String? previousConditions;
  final String? medications;
  final String? smoking;
  final String? alcohol;
  final double bmi;
  final bool consentForResearch;

  UserProfile({
    required this.name,
    required this.age,
    this.gender,
    this.ethnicity,
    this.familyHistory,
    this.previousConditions,
    this.medications,
    this.smoking,
    this.alcohol,
    required this.bmi,
    this.consentForResearch = false,
  });
}

class WelcomeScreen extends StatelessWidget {
  final UserProfile profile;
  
  const WelcomeScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Hello, ${profile.name.split(' ').first}!',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.favorite, size: 80, color: Colors.white70),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatCard(
                      context,
                      '2.3M',
                      'Women diagnosed globally per year',
                      Icons.public,
                      Colors.red,
                    ),
                    const SizedBox(height: 12),
                    _buildStatCard(
                      context,
                      '99%',
                      'Survival rate when detected early',
                      Icons.favorite,
                      Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildStatCard(
                      context,
                      '1 in 8',
                      'Women will develop breast cancer',
                      Icons.info_outline,
                      Colors.orange,
                    ),
                    const SizedBox(height: 24),
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.verified, color: Colors.green[700], size: 28),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'Clinical Validation',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildCheckItem('WHO & NCCN Guidelines'),
                            _buildCheckItem('American Cancer Society Standards'),
                            _buildCheckItem('Multi-Factor Risk Assessment'),
                            _buildCheckItem('100% Private & Free'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple[50]!, Colors.pink[50]!],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.purple[200]!),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.people, color: Colors.purple[700], size: 28),
                          const SizedBox(height: 12),
                          const Text(
                            'Serving Underserved Communities',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Healthcare is a human right. This tool is designed for communities with limited access to medical facilities.',
                            style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EducationalScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        icon: const Icon(Icons.assignment_outlined),
                        label: const Text(
                          'Begin Assessment',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red[300]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.emergency, color: Colors.red[700], size: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Emergency? Get help immediately. Don\'t wait for screening.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red[900],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label, IconData icon, Color color) {
    return Card(
      elevation: 2,
      color: color.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green[700], size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class EducationalScreen extends StatelessWidget {
  const EducationalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breast Cancer Awareness'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.secondaryContainer,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Knowledge Saves Lives',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Understanding signs and risk factors empowers you',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Warning Signs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildWarningCard(
                'New lump or mass',
                'Most common early sign - usually painless',
                Icons.error_outline,
              ),
              _buildWarningCard(
                'Nipple changes',
                'Discharge, retraction, or inversion',
                Icons.warning_amber,
              ),
              _buildWarningCard(
                'Skin changes',
                'Dimpling, redness, or orange-peel texture',
                Icons.info_outline,
              ),
              _buildWarningCard(
                'Breast size/shape change',
                'One breast appears different',
                Icons.change_circle_outlined,
              ),
              const SizedBox(height: 24),
              const Text(
                'Risk Factors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildRiskSection(
                'Non-Modifiable',
                [
                  'Age (risk increases after 40)',
                  'Family history',
                  'Genetic mutations (BRCA1/2)',
                  'Dense breast tissue',
                ],
                Colors.orange,
              ),
              const SizedBox(height: 12),
              _buildRiskSection(
                'Modifiable',
                [
                  'Obesity',
                  'Physical inactivity',
                  'Alcohol consumption',
                  'Smoking',
                ],
                Colors.blue,
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                color: Colors.green[50],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb, color: Colors.green[700]),
                          const SizedBox(width: 10),
                          const Text(
                            'Prevention Tips',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildTip('Maintain healthy weight'),
                      _buildTip('Exercise regularly'),
                      _buildTip('Limit alcohol intake'),
                      _buildTip('Don\'t smoke'),
                      _buildTip('Get regular screenings'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ScreeningScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  icon: const Icon(Icons.assignment),
                  label: const Text(
                    'Start Risk Assessment',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.grey[700], size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'This tool provides educational information only. Consult healthcare providers for medical advice.',
                        style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningCard(String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.red[700]),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        dense: true,
      ),
    );
  }

  Widget _buildRiskSection(String title, List<String> items, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 10),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item, style: const TextStyle(fontSize: 13))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check, color: Colors.green[700], size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

class ScreeningScreen extends StatefulWidget {
  const ScreeningScreen({super.key});

  @override
  State<ScreeningScreen> createState() => _ScreeningScreenState();
}

class _ScreeningScreenState extends State<ScreeningScreen> {
  int currentStep = 0;
  final _pageController = PageController();
  
  // All question responses
  String? ageGroup, familyHistory, previousScreening, previousBreastProblems;
  String? breastLump, lumpCharacteristics, lumpLocation, axillarySwelling;
  String? nippleChanges, skinChanges, breastPain;
  String? bonePain, unexplainedWeightLoss, fatigue, symptomDuration;

  RiskResult? result;
  bool loading = false;

  void _nextStep() {
    if (currentStep < 3) {
      if (_validateCurrentStep()) {
        setState(() => currentStep++);
        _pageController.animateToPage(
          currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _analyzeRisk();
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
      _pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        if (ageGroup == null || familyHistory == null || previousScreening == null || previousBreastProblems == null) {
          _showSnackBar('Please answer all required questions');
          return false;
        }
        return true;
      case 1:
        if (breastLump == null || axillarySwelling == null || nippleChanges == null || skinChanges == null || breastPain == null) {
          _showSnackBar('Please answer all required questions');
          return false;
        }
        return true;
      case 2:
        if (bonePain == null || unexplainedWeightLoss == null || fatigue == null) {
          _showSnackBar('Please answer all required questions');
          return false;
        }
        return true;
      case 3:
        if (symptomDuration == null) {
          _showSnackBar('Please answer all required questions');
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _analyzeRisk() async {
    setState(() => loading = true);
    
    await Future.delayed(const Duration(milliseconds: 1500));

    final engine = ClinicalRiskEngine();
    final analysis = engine.evaluate(
      ageGroup: ageGroup!,
      familyHistory: familyHistory!,
      previousScreening: previousScreening!,
      previousBreastProblems: previousBreastProblems!,
      breastLump: breastLump!,
      lumpCharacteristics: lumpCharacteristics ?? 'Not applicable',
      lumpLocation: lumpLocation ?? 'Not applicable',
      axillarySwelling: axillarySwelling!,
      nippleChanges: nippleChanges!,
      skinChanges: skinChanges!,
      breastPain: breastPain!,
      bonePain: bonePain!,
      unexplainedWeightLoss: unexplainedWeightLoss!,
      fatigue: fatigue!,
      symptomDuration: symptomDuration!,
    );

    setState(() {
      result = analysis;
      loading = false;
      currentStep = 4;
    });
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinical Assessment'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? _buildLoadingView()
          : currentStep < 4
              ? Column(
                  children: [
                    _buildProgressIndicator(),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildDemographicsStep(),
                          _buildBreastSymptomsStep(),
                          _buildSystemicSymptomsStep(),
                          _buildTimelineStep(),
                        ],
                      ),
                    ),
                    _buildNavigationButtons(),
                  ],
                )
              : _buildResultsView(),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Analyzing Your Responses',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Applying clinical guidelines...',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (currentStep + 1) / 4,
                    minHeight: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Step ${currentStep + 1}/4',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _getStepTitle(),
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (currentStep) {
      case 0: return 'Demographics & Medical History';
      case 1: return 'Breast-Specific Symptoms';
      case 2: return 'Systemic Symptoms';
      case 3: return 'Timeline & Summary';
      default: return '';
    }
  }

  Widget _buildDemographicsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Demographics & Medical History',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Age and medical history are important risk factors',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 20),
          _buildQuestionCard(
            'What is your age group?',
            ageGroup,
            ['Under 30', '30-39', '40-49', '50-59', '60 or above'],
            (v) => setState(() => ageGroup = v),
          ),
          _buildQuestionCard(
            'Family history of breast/ovarian cancer?',
            familyHistory,
            [
              'Yes - First-degree relative',
              'Yes - Second-degree relative',
              'No family history',
              'Unknown'
            ],
            (v) => setState(() => familyHistory = v),
          ),
          _buildQuestionCard(
            'When was your last breast screening?',
            previousScreening,
            ['Never screened', 'Within last year', '1-3 years ago', 'More than 3 years ago'],
            (v) => setState(() => previousScreening = v),
          ),
          _buildQuestionCard(
            'Previous breast problems or biopsies?',
            previousBreastProblems,
            [
              'Yes - Benign breast disease',
              'Yes - Previous breast cancer',
              'Yes - Atypical hyperplasia',
              'No previous problems'
            ],
            (v) => setState(() => previousBreastProblems = v),
          ),
        ],
      ),
    );
  }

  Widget _buildBreastSymptomsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Breast-Specific Symptoms',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Answer honestly about any changes you\'ve noticed',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 20),
          _buildQuestionCard(
            'Have you detected any breast lump or mass?',
            breastLump,
            [
              'Yes - Definite hard lump',
              'Yes - Soft or mobile lump',
              'Possible lump - uncertain',
              'No lump detected'
            ],
            (v) {
              setState(() {
                breastLump = v;
                if (v == 'No lump detected') {
                  lumpCharacteristics = 'Not applicable';
                  lumpLocation = 'Not applicable';
                }
              });
            },
          ),
          if (breastLump != null && breastLump != 'No lump detected') ...[
            _buildQuestionCard(
              'Lump characteristics (if present):',
              lumpCharacteristics,
              ['Fixed and hard', 'Mobile and soft', 'Growing in size', 'Painful', 'Unchanged for months'],
              (v) => setState(() => lumpCharacteristics = v),
            ),
            _buildQuestionCard(
              'Lump location:',
              lumpLocation,
              ['Upper outer area', 'Upper inner area', 'Lower outer area', 'Lower inner area', 'Around nipple'],
              (v) => setState(() => lumpLocation = v),
            ),
          ],
          _buildQuestionCard(
            'Swelling in armpit (axillary area)?',
            axillarySwelling,
            ['Yes - Definite swelling', 'Possible swelling', 'No swelling'],
            (v) => setState(() => axillarySwelling = v),
          ),
          _buildQuestionCard(
            'Nipple changes?',
            nippleChanges,
            [
              'Yes - Bloody discharge',
              'Yes - Clear/milky discharge',
              'Yes - Inversion or retraction',
              'Yes - Rash or eczema-like changes',
              'No nipple changes'
            ],
            (v) => setState(() => nippleChanges = v),
          ),
          _buildQuestionCard(
            'Skin changes on breast?',
            skinChanges,
            [
              'Yes - Dimpling or puckering',
              'Yes - Redness or warmth',
              'Yes - Orange-peel texture',
              'Yes - Thickened skin',
              'No skin changes'
            ],
            (v) => setState(() => skinChanges = v),
          ),
          _buildQuestionCard(
            'Breast or nipple pain?',
            breastPain,
            [
              'Yes - Severe persistent pain',
              'Yes - Moderate persistent pain',
              'Yes - Mild or cyclical pain',
              'No pain'
            ],
            (v) => setState(() => breastPain = v),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemicSymptomsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Systemic Symptoms',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'May indicate advanced disease if present with breast changes',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 20),
          _buildQuestionCard(
            'Persistent bone or back pain?',
            bonePain,
            [
              'Yes - Severe persistent pain',
              'Yes - Moderate pain',
              'Yes - Mild occasional pain',
              'No bone pain'
            ],
            (v) => setState(() => bonePain = v),
          ),
          _buildQuestionCard(
            'Unexplained weight loss?',
            unexplainedWeightLoss,
            [
              'Yes - Significant (>10 kg)',
              'Yes - Moderate (5-10 kg)',
              'Yes - Mild (<5 kg)',
              'No weight loss'
            ],
            (v) => setState(() => unexplainedWeightLoss = v),
          ),
          _buildQuestionCard(
            'Unusual fatigue or weakness?',
            fatigue,
            [
              'Yes - Severe fatigue',
              'Yes - Moderate fatigue',
              'Yes - Mild fatigue',
              'No unusual fatigue'
            ],
            (v) => setState(() => fatigue = v),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Symptom Timeline',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Duration helps assess urgency and progression',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 20),
          _buildQuestionCard(
            'How long have you had these symptoms?',
            symptomDuration,
            [
              'Less than 2 weeks',
              '2 weeks - 1 month',
              '1-3 months',
              '3-6 months',
              'More than 6 months',
              'No symptoms - screening only'
            ],
            (v) => setState(() => symptomDuration = v),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[50]!, Colors.teal[50]!],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[300]!),
            ),
            child: Column(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700], size: 28),
                const SizedBox(height: 12),
                const Text(
                  'Assessment Complete',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Click "Get Assessment" for your personalized risk analysis',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(
    String question,
    String? value,
    List<String> options,
    Function(String) onChanged,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Required',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...options.map((option) => RadioListTile<String>(
                  title: Text(option, style: const TextStyle(fontSize: 14)),
                  value: option,
                  groupValue: value,
                  onChanged: (v) => onChanged(v!),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  activeColor: Theme.of(context).colorScheme.primary,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (currentStep > 0)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _previousStep,
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Back'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            if (currentStep > 0) const SizedBox(width: 12),
            Expanded(
              flex: currentStep == 0 ? 1 : 1,
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentStep == 3 ? 'Get Assessment' : 'Next',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Icon(currentStep == 3 ? Icons.check_circle : Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsView() {
    if (result == null) return Container();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 4,
            color: result!.color.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: result!.color, width: 3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(result!.icon, size: 60, color: result!.color),
                  const SizedBox(height: 16),
                  Text(
                    result!.level,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: result!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: result!.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Risk Score: ${result!.score.toStringAsFixed(1)}/100',
                      style: TextStyle(
                        fontSize: 16,
                        color: result!.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    result!.urgency,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Clinical Recommendation',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    result!.recommendation,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          if (result!.factors.isNotEmpty) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.orange[700], size: 22),
                        const SizedBox(width: 10),
                        const Text(
                          'Risk Factors Identified',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...result!.factors.take(5).map((factor) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.orange[700],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  factor,
                                  style: const TextStyle(fontSize: 13, height: 1.4),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Card(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.list_alt, color: Colors.blue[700], size: 22),
                      const SizedBox(width: 10),
                      const Text(
                        'Next Steps',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...result!.nextSteps.take(4).toList().asMap().entries.map((entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: Colors.blue[700],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '${entry.key + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: const TextStyle(fontSize: 13, height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber[300]!),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info, color: Colors.amber[900], size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'DISCLAIMER: This is a screening tool only. It does not diagnose or replace professional medical examination. Consult healthcare providers for medical advice.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.amber[900],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      currentStep = 0;
                      result = null;
                      ageGroup = familyHistory = previousScreening = previousBreastProblems = null;
                      breastLump = lumpCharacteristics = lumpLocation = axillarySwelling = null;
                      nippleChanges = skinChanges = breastPain = null;
                      bonePain = unexplainedWeightLoss = fatigue = symptomDuration = null;
                    });
                    _pageController.jumpToPage(0);
                  },
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('New', style: TextStyle(fontSize: 14)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.home, size: 18),
                  label: const Text('Home', style: TextStyle(fontSize: 14)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClinicalRiskEngine {
  RiskResult evaluate({
    required String ageGroup,
    required String familyHistory,
    required String previousScreening,
    required String previousBreastProblems,
    required String breastLump,
    required String lumpCharacteristics,
    required String lumpLocation,
    required String axillarySwelling,
    required String nippleChanges,
    required String skinChanges,
    required String breastPain,
    required String bonePain,
    required String unexplainedWeightLoss,
    required String fatigue,
    required String symptomDuration,
  }) {
    double score = 0;
    List<String> factors = [];

    // Age stratification
    if (ageGroup == '60 or above') {
      score += 18;
      factors.add('Advanced age (60+) - elevated risk');
    } else if (ageGroup == '50-59') {
      score += 15;
      factors.add('Age 50-59 - elevated risk');
    } else if (ageGroup == '40-49') {
      score += 10;
      factors.add('Age 40-49 - moderate risk');
    } else if (ageGroup == '30-39') {
      score += 5;
      factors.add('Age 30-39 - lower baseline risk');
    }

    // Family history
    if (familyHistory.contains('First-degree')) {
      score += 20;
      factors.add('Strong family history - 2-3x risk');
    } else if (familyHistory.contains('Second-degree')) {
      score += 10;
      factors.add('Moderate family history');
    } else if (familyHistory.contains('Multiple')) {
      score += 25;
      factors.add('Multiple relatives with cancer - very high risk');
    }

    // Previous problems
    if (previousBreastProblems.contains('Previous breast cancer')) {
      score += 25;
      factors.add('History of breast cancer - high recurrence risk');
    } else if (previousBreastProblems.contains('Atypical')) {
      score += 15;
      factors.add('Atypical hyperplasia - 4-5x risk');
    } else if (previousBreastProblems.contains('Benign')) {
      score += 5;
      factors.add('Previous benign disease');
    }

    // Screening status
    if (previousScreening == 'Never screened' || previousScreening.contains('More than 3')) {
      score += 10;
      factors.add('Overdue for screening');
    }

    // Breast lump - CRITICAL
    if (breastLump.contains('Definite hard')) {
      score += 30;
      factors.add('CRITICAL: Hard breast mass detected');
      
      if (lumpCharacteristics.contains('Fixed and hard')) {
        score += 18;
        factors.add('ALARMING: Fixed, hard mass');
      } else if (lumpCharacteristics.contains('Growing')) {
        score += 15;
        factors.add('Progressive growth of mass');
      }
      
      if (lumpLocation.contains('Upper outer')) {
        score += 5;
        factors.add('Upper outer quadrant - common site');
      }
    } else if (breastLump.contains('Soft or mobile')) {
      score += 15;
      factors.add('Palpable mobile mass - needs evaluation');
      
      if (lumpCharacteristics.contains('Growing')) {
        score += 10;
        factors.add('Enlarging mass');
      }
    } else if (breastLump.contains('Possible')) {
      score += 12;
      factors.add('Uncertain breast abnormality');
    }

    // Axillary swelling
    if (axillarySwelling.contains('Definite')) {
      score += 25;
      factors.add('CRITICAL: Axillary lymphadenopathy');
    } else if (axillarySwelling.contains('Possible')) {
      score += 12;
      factors.add('Possible lymph node involvement');
    }

    // Nipple changes
    if (nippleChanges.contains('Bloody')) {
      score += 20;
      factors.add('CRITICAL: Bloody nipple discharge');
    } else if (nippleChanges.contains('inversion') || nippleChanges.contains('retraction')) {
      score += 18;
      factors.add('Nipple retraction/inversion');
    } else if (nippleChanges.contains('Rash')) {
      score += 15;
      factors.add('Nipple/areolar rash - possible Paget\'s disease');
    } else if (nippleChanges.contains('Clear/milky')) {
      score += 8;
      factors.add('Non-bloody discharge');
    }

    // Skin changes
    if (skinChanges.contains('Orange-peel')) {
      score += 22;
      factors.add('CRITICAL: Peau d\'orange - inflammatory breast cancer');
    } else if (skinChanges.contains('Redness or warmth')) {
      score += 20;
      factors.add('CRITICAL: Skin erythema - inflammatory signs');
    } else if (skinChanges.contains('Dimpling or puckering')) {
      score += 18;
      factors.add('Skin dimpling - concerning sign');
    } else if (skinChanges.contains('Thickened')) {
      score += 15;
      factors.add('Skin thickening');
    }

    // Breast pain
    if (breastPain.contains('Severe persistent')) {
      score += 8;
      factors.add('Severe persistent pain');
    } else if (breastPain.contains('Moderate persistent')) {
      score += 5;
      factors.add('Persistent breast pain');
    }

    // Systemic symptoms
    if (bonePain.contains('Severe persistent')) {
      score += 20;
      factors.add('CRITICAL: Severe bone pain - metastatic concern');
    } else if (bonePain.contains('Moderate')) {
      score += 12;
      factors.add('Moderate bone pain');
    } else if (bonePain.contains('Mild')) {
      score += 6;
      factors.add('Mild bone pain');
    }

    if (unexplainedWeightLoss.contains('Significant')) {
      score += 18;
      factors.add('CRITICAL: Significant weight loss');
    } else if (unexplainedWeightLoss.contains('Moderate')) {
      score += 12;
      factors.add('Moderate weight loss');
    } else if (unexplainedWeightLoss.contains('Mild')) {
      score += 6;
      factors.add('Mild weight loss');
    }

    if (fatigue.contains('Severe')) {
      score += 10;
      factors.add('Severe fatigue');
    } else if (fatigue.contains('Moderate')) {
      score += 5;
      factors.add('Moderate fatigue');
    }

    // Duration
    if (symptomDuration.contains('More than 6 months')) {
      score += 12;
      factors.add('Chronic symptoms (>6 months)');
    } else if (symptomDuration.contains('3-6 months')) {
      score += 10;
      factors.add('Symptoms 3-6 months');
    } else if (symptomDuration.contains('1-3 months')) {
      score += 7;
      factors.add('Symptoms 1-3 months');
    }

    score = math.min(score, 100);
    
    return _generateResult(score, factors);
  }

  RiskResult _generateResult(double score, List<String> factors) {
    if (score >= 75) {
      return RiskResult(
        level: 'CRITICAL RISK',
        score: score,
        color: const Color(0xFFB71C1C),
        icon: Icons.emergency,
        urgency: 'URGENT MEDICAL ATTENTION REQUIRED',
        recommendation:
            'CRITICAL FINDINGS: Multiple concerning signs detected. Seek medical attention within 24-48 hours. Contact your healthcare provider, visit urgent care, or go to emergency department. Do not delay.',
        factors: factors,
        nextSteps: [
          'URGENT: Seek medical evaluation within 24-48 hours',
          'Request clinical breast examination',
          'Ask for diagnostic mammography and ultrasound',
          'Request referral to breast surgeon if available',
          'Bring written list of symptoms and their duration',
        ],
      );
    } else if (score >= 50) {
      return RiskResult(
        level: 'HIGH RISK',
        score: score,
        color: const Color(0xFFD84315),
        icon: Icons.error,
        urgency: 'Prompt Medical Evaluation Needed',
        recommendation:
            'HIGH-RISK FINDINGS: Several concerning signs warrant prompt evaluation. Schedule appointment within 3-7 days for clinical examination and appropriate imaging.',
        factors: factors,
        nextSteps: [
          'Schedule medical appointment within 3-7 days',
          'Request thorough clinical breast examination',
          'Discuss need for diagnostic imaging',
          'Document all symptoms with dates',
        ],
      );
    } else if (score >= 30) {
      return RiskResult(
        level: 'MODERATE RISK',
        score: score,
        color: const Color(0xFFFF8F00),
        icon: Icons.warning,
        urgency: 'Medical Consultation Recommended',
        recommendation:
            'MODERATE-RISK FINDINGS: Some concerning features should be evaluated. Schedule routine appointment within 2-3 weeks for assessment.',
        factors: factors,
        nextSteps: [
          'Schedule appointment within 2-3 weeks',
          'Request clinical breast examination',
          'Discuss personal risk factors',
          'Continue monthly self-examinations',
        ],
      );
    } else if (score >= 15) {
      return RiskResult(
        level: 'LOW-MODERATE RISK',
        score: score,
        color: const Color(0xFFFBC02D),
        icon: Icons.info,
        urgency: 'Routine Follow-up Appropriate',
        recommendation:
            'LOW-MODERATE RISK: Minor risk factors noted. Schedule routine check-up within 4-6 weeks. Continue regular screening according to guidelines.',
        factors: factors.isEmpty ? ['Some minor risk factors noted'] : factors,
        nextSteps: [
          'Schedule routine check-up within 4-6 weeks',
          'Follow age-appropriate screening guidelines',
          'Perform monthly breast self-examinations',
          'Maintain healthy lifestyle',
        ],
      );
    } else {
      return RiskResult(
        level: 'LOW RISK',
        score: score,
        color: const Color(0xFF388E3C),
        icon: Icons.check_circle,
        urgency: 'Continue Routine Screening',
        recommendation:
            'LOW RISK: Current breast cancer risk appears low. Continue age-appropriate screening and maintain breast health awareness.',
        factors: factors.isEmpty ? ['No significant risk factors at this time'] : factors,
        nextSteps: [
          'Follow standard screening guidelines',
          'Perform monthly breast self-examination',
          'Maintain healthy weight and exercise',
          'Limit alcohol, avoid smoking',
          'Report any new symptoms promptly',
        ],
      );
    }
  }
}

class RiskResult {
  final String level;
  final double score;
  final Color color;
  final IconData icon;
  final String urgency;
  final String recommendation;
  final List<String> factors;
  final List<String> nextSteps;

  RiskResult({
    required this.level,
    required this.score,
    required this.color,
    required this.icon,
    required this.urgency,
    required this.recommendation,
    required this.factors,
    required this.nextSteps,
  });
}
