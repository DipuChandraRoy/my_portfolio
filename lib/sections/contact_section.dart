import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../widgets/section_title.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Contact Section
// ─────────────────────────────────────────────────────────────────────────────

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(horizontal: isWide ? 60 : 24),
              child: Column(
                children: [
                  const SectionTitle(
                    title: 'Contact',
                    subtitle: 'Let\'s work together',
                  ),
                  const SizedBox(height: 50),
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _ContactInfo()),
                        const SizedBox(width: 40),
                        Expanded(flex: 2, child: _ContactForm()),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _ContactInfo(),
                        const SizedBox(height: 40),
                        _ContactForm(),
                      ],
                    ),
                  const SizedBox(height: 60),
                  _Footer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Contact Info Cards ──────────────────────────────────────────────────────

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Get In Touch',
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Have a project in mind or just want to say hello? '
          'Feel free to reach out. I\'m always open to discussing '
          'new opportunities and creative ideas.',
          style: TextStyle(
            color: AppColors.grey.withValues(alpha: 0.8),
            fontSize: 14,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 30),

        // ── Contact Cards ──
        const _ContactCard(
          icon: Icons.email_rounded,
          title: 'Email',
          value: 'dipuray7779@gmail.com',
        ),
        const SizedBox(height: 16),
        const _ContactCard(
          icon: Icons.phone_rounded,
          title: 'Phone',
          value: '+880 1753-827779',
        ),
        const SizedBox(height: 16),
        const _ContactCard(
          icon: Icons.location_on_rounded,
          title: 'Location',
          value: 'Uttara, Dhaka, Bangladesh',
        ),
        const SizedBox(height: 30),

        // ── Social Links ──
        Row(
          children: [
            _SocialButton(icon: Icons.code_rounded, onTap: () {}),
            const SizedBox(width: 12),
            _SocialButton(icon: Icons.link_rounded, onTap: () {}),
            const SizedBox(width: 12),
            _SocialButton(icon: Icons.telegram, onTap: () {}),
            const SizedBox(width: 12),
            _SocialButton(icon: Icons.facebook_rounded, onTap: () {}),
          ],
        ),
      ],
    );
  }
}

// ─── Contact Card ────────────────────────────────────────────────────────────

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.accent, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.grey.withValues(alpha: 0.6),
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Social Button ───────────────────────────────────────────────────────────

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent
                : AppColors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent
                  : AppColors.accent.withValues(alpha: 0.2),
            ),
          ),
          child: Icon(
            widget.icon,
            color: _hovered ? Colors.black : AppColors.accent,
            size: 20,
          ),
        ),
      ),
    );
  }
}

// ─── Contact Form ────────────────────────────────────────────────────────────

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendToWhatsApp() async {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final subject = _subjectCtrl.text.trim();
    final message = _messageCtrl.text.trim();

    if (name.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter your name and message.'),
          backgroundColor: AppColors.accent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    setState(() => _sending = true);
    try {
      final parts = [
        'Hello Dipu! 👋',
        'Name: $name',
        if (email.isNotEmpty) 'Email: $email',
        if (subject.isNotEmpty) 'Subject: $subject',
        '',
        'Message:',
        message,
      ];
      final uri = Uri.parse(
        'https://wa.me/8801753827779?text=${Uri.encodeComponent(parts.join('\n'))}',
      );
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        _nameCtrl.clear();
        _emailCtrl.clear();
        _subjectCtrl.clear();
        _messageCtrl.clear();
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send Me a Message',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.message_sharp,
                color: Color(0xFF25D366),
                size: 15,
              ),
              const SizedBox(width: 6),
              Text(
                'Opens WhatsApp with your message pre-filled',
                style: TextStyle(
                  color: AppColors.grey.withValues(alpha: 0.55),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ── Name & Email Row ──
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 450) {
                return Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        'Your Name',
                        Icons.person_outline,
                        _nameCtrl,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildField(
                        'Your Email',
                        Icons.email_outlined,
                        _emailCtrl,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildField('Your Name', Icons.person_outline, _nameCtrl),
                    const SizedBox(height: 16),
                    _buildField('Your Email', Icons.email_outlined, _emailCtrl),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 16),

          _buildField('Subject', Icons.subject_rounded, _subjectCtrl),
          const SizedBox(height: 16),

          _buildField(
            'Your Message',
            Icons.message_outlined,
            _messageCtrl,
            maxLines: 5,
          ),
          const SizedBox(height: 24),

          // ── Send Button ──
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _sending ? null : _sendToWhatsApp,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.black,
                disabledBackgroundColor: AppColors.accent.withValues(
                  alpha: 0.5,
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                shadowColor: AppColors.accent.withValues(alpha: 0.4),
              ),
              child: _sending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message_sharp, size: 18),
                        SizedBox(width: 10),
                        Text(
                          'Send via WhatsApp',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    String hint,
    IconData icon,
    TextEditingController ctrl, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.grey.withValues(alpha: 0.5),
          fontSize: 14,
        ),
        prefixIcon: maxLines == 1
            ? Icon(
                icon,
                color: AppColors.accent.withValues(alpha: 0.6),
                size: 20,
              )
            : null,
        filled: true,
        fillColor: AppColors.background,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 16 : 0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
      ),
    );
  }
}

// ─── Footer ──────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: AppColors.grey.withValues(alpha: 0.6),
                fontSize: 13,
              ),
              children: const [
                TextSpan(text: '© 2026 '),
                TextSpan(
                  text: 'Dipu Chandra Ray',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: '. All rights reserved.'),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Built with Flutter 💙',
            style: TextStyle(
              color: AppColors.grey.withValues(alpha: 0.4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
