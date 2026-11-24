import 'package:flutter/material.dart';
import 'theme.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showBack;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showBack)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              )
            else
              const SizedBox(height: 20),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800)),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle!,
                  style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ],
        ),
      ),
    );
  }
}

class AppPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showBack;
  final List<Widget> children;

  const AppPage({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(title: title, subtitle: subtitle, showBack: showBack),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;
  final EdgeInsetsGeometry padding;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.color,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;

  const StatusChip({
    super.key,
    required this.label,
    this.background = AppColors.successBg,
    this.foreground = AppColors.success,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration:
          BoxDecoration(color: background, borderRadius: BorderRadius.circular(8)),
      child: Text(label,
          style: TextStyle(
              color: foreground, fontSize: 12, fontWeight: FontWeight.w700)),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader(this.title, {super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark)),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: const Text('Lihat Semua',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
            ),
        ],
      ),
    );
  }
}

class EmptyCard extends StatelessWidget {
  final String title;
  final String? message;

  const EmptyCard({super.key, required this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark)),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textMuted)),
            ],
          ],
        ),
      ),
    );
  }
}