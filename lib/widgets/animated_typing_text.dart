import 'dart:async';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AnimatedTypingText — types through a list of strings, deletes, then repeats.
// ─────────────────────────────────────────────────────────────────────────────

class AnimatedTypingText extends StatefulWidget {
  final List<String> texts;
  final TextStyle style;
  final Duration typeSpeed;
  final Duration deleteSpeed;
  final Duration pauseDuration;

  const AnimatedTypingText({
    super.key,
    required this.texts,
    required this.style,
    this.typeSpeed = const Duration(milliseconds: 80),
    this.deleteSpeed = const Duration(milliseconds: 45),
    this.pauseDuration = const Duration(milliseconds: 1800),
  });

  @override
  State<AnimatedTypingText> createState() => _AnimatedTypingTextState();
}

class _AnimatedTypingTextState extends State<AnimatedTypingText> {
  String _displayed = '';
  int _textIndex = 0;
  bool _deleting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _schedule(const Duration(milliseconds: 500));
  }

  void _schedule(Duration delay) {
    _timer = Timer(delay, _tick);
  }

  void _tick() {
    if (!mounted) return;
    final full = widget.texts[_textIndex];

    setState(() {
      if (!_deleting) {
        // Typing forward
        if (_displayed.length < full.length) {
          _displayed = full.substring(0, _displayed.length + 1);
        } else {
          _deleting = true;
          _schedule(widget.pauseDuration);
          return;
        }
      } else {
        // Deleting backward
        if (_displayed.isNotEmpty) {
          _displayed = _displayed.substring(0, _displayed.length - 1);
        } else {
          _deleting = false;
          _textIndex = (_textIndex + 1) % widget.texts.length;
        }
      }
    });

    _schedule(_deleting ? widget.deleteSpeed : widget.typeSpeed);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            _displayed,
            style: widget.style,
          ),
        ),
        // Blinking cursor
        _BlinkingCursor(color: widget.style.color ?? Colors.white),
      ],
    );
  }
}

// ── Blinking cursor ──────────────────────────────────────────────────────────

class _BlinkingCursor extends StatefulWidget {
  final Color color;
  const _BlinkingCursor({required this.color});

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(
        width: 2,
        height: 22,
        margin: const EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}
