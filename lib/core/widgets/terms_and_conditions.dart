import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _TermsColors {
  static const purple = Color(0xFF7B5CE0);
  static const darkTitle = Color(0xFF1A1A2E);
  static const white = Colors.white;
}

class _TermsSection {
  final String title;
  final String body;
  const _TermsSection(this.title, this.body);
}

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  static const List<_TermsSection> _sections = [
    _TermsSection(
      '1- Collection of Personal Data',
      'The user (customer or service provider) must enter accurate data, '
          'including: Full Name, Phone Number, and Email Address.',
    ),
    _TermsSection(
      '2- Data Sharing',
      'The user agrees to share their basic data with the Application '
          'Administration and other parties within the platform, solely to '
          'facilitate communication and service completion.',
    ),
    _TermsSection(
      '3- Access to Location',
      'The user agrees to grant the application access to their geographical '
          'location, used to display nearby services and facilitate service '
          'provider access. The customer\'s location may be shared with the '
          'provider during order fulfillment.',
    ),
    _TermsSection(
      '4- Verification of Service Provider Identity',
      'The service provider must upload a photo of their personal ID or '
          'official document, used solely for identity verification and '
          'account approval.',
    ),
    _TermsSection(
      '5- Data Storage',
      'User data (including ID photos) is stored securely in the app\'s '
          'database and will not be shared with any unauthorized party.',
    ),
    _TermsSection(
      '6- Data Use',
      'Data is used only to operate and improve the application, and will '
          'not be sold or used outside it without the user\'s consent.',
    ),
    _TermsSection(
      '7- User Responsibility',
      'The user is responsible for the accuracy of the data provided. The '
          'app administration may reject or delete any account with false or '
          'misleading information.',
    ),
    _TermsSection(
      '8- Consent',
      'By clicking "Register" or "Continue," you acknowledge having read '
          'these terms and fully agree to them.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _TermsColors.white,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 55, left: 16, right: 16, bottom: 24),
      decoration: const BoxDecoration(color: _TermsColors.purple),
      child: GestureDetector(
        onTap: () => context.pop(),
        behavior: HitTestBehavior.opaque,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back, color: _TermsColors.white),
            SizedBox(width: 8),
            Text(
              'Back',
              style: TextStyle(
                color: _TermsColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: _TermsColors.purple),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ServiGo Terms and Conditions of Use',
              style: TextStyle(
                color: _TermsColors.darkTitle,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'By using the ServiGo platform (as a service provider or '
              'customer), you agree to the following terms:',
              style: TextStyle(
                color: _TermsColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            ..._sections.map(_buildSection),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(_TermsSection section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              color: _TermsColors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            section.body,
            style: const TextStyle(
              color: _TermsColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
