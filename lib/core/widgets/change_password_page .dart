import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  bool _hideOld = true;
  bool _hideNew = true;
  bool _hideConfirm = true;

  @override
  void dispose() {
    _oldPassCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: استدعاء API لتغيير كلمة المرور
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تغيير كلمة المرور بنجاح')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D2D5E);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header
          Container(
            color: primaryColor,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white24,
                        shape: const CircleBorder(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'تغيير كلمة المرور',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.lock_outline,
                      color: Colors.white, size: 36),
                ),
              ],
            ),
          ),

          // Form
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              margin: const EdgeInsets.only(top: -16),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      'يرجى إدخال كلمة المرور القديمة ثم كلمة المرور الجديدة',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 24),

                    _buildField(
                      label: 'كلمة المرور الحالية',
                      controller: _oldPassCtrl,
                      obscure: _hideOld,
                      toggle: () => setState(() => _hideOld = !_hideOld),
                      validator: (v) =>
                          v!.isEmpty ? 'هذا الحقل مطلوب' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildField(
                      label: 'كلمة المرور الجديدة',
                      controller: _newPassCtrl,
                      obscure: _hideNew,
                      toggle: () => setState(() => _hideNew = !_hideNew),
                      validator: (v) =>
                          v!.length < 6 ? 'يجب أن تكون 6 أحرف على الأقل' : null,
                    ),
                    const SizedBox(height: 16),

                    _buildField(
                      label: 'تأكيد كلمة المرور الجديدة',
                      controller: _confirmPassCtrl,
                      obscure: _hideConfirm,
                      toggle: () =>
                          setState(() => _hideConfirm = !_hideConfirm),
                      validator: (v) => v != _newPassCtrl.text
                          ? 'كلمتا المرور غير متطابقتين'
                          : null,
                    ),
                    const SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('حفظ التغييرات',
                          style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 12),

                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('إلغاء'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF555555))),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey),
              onPressed: toggle,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}