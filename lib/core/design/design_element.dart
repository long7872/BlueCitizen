import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'design_store.dart';

/// Resolve exact Figma colors through existing tokens before using a local value.
Color designColor(String? value) {
  if (value == null || value == 'transparent' || value == 'none') {
    return Colors.transparent;
  }
  final parts = RegExp(
    r'[\d.]+',
  ).allMatches(value).map((m) => double.parse(m.group(0)!)).toList();
  if (parts.length < 3) return Colors.transparent;
  final color = Color.fromARGB(
    parts.length > 3 ? (parts[3] * 255).round() : 255,
    parts[0].round(),
    parts[1].round(),
    parts[2].round(),
  );
  for (final token in [
    AppColors.primaryAqua,
    AppColors.secondaryOceanBlue,
    AppColors.backgroundPrimaryWhite,
    AppColors.backgroundSecondarySky,
    AppColors.surfaceGray50,
    AppColors.surfaceHoverSeafoam,
    AppColors.highlightCoral,
    AppColors.alertSunshine,
    AppColors.textHeadingGray950,
    AppColors.textBodyGray700,
    AppColors.borderGray200,
  ]) {
    if (color == token) return token;
  }
  return color;
}

TextStyle designTextStyle(DesignNode node) {
  final family = node['font'] as String? ?? '';
  final size = (node['size'] as num? ?? 14).toDouble();
  final weight = (node['weight'] as num? ?? 400).toInt();
  return AppTextStyles.body.copyWith(
    fontFamily: family.contains('Patrick')
        ? 'PatrickHand'
        : family.contains('Inter')
        ? 'Inter'
        : AppTextStyles.fontFamily,
    fontSize: size,
    fontWeight: FontWeight.values[((weight / 100).round() - 1).clamp(0, 8)],
    color: designColor(node['color'] as String?),
    height: node['lineHeight'] == null
        ? 1.2
        : (node['lineHeight'] as num).toDouble() / size,
    letterSpacing: (node['letterSpacing'] as num? ?? 0).toDouble(),
    decoration: (node['decoration'] as String? ?? '').contains('underline')
        ? TextDecoration.underline
        : TextDecoration.none,
  );
}

/// Native widget layer; no screenshot of a screen is used to implement a page.
class DesignElement extends StatelessWidget {
  const DesignElement({super.key, required this.node, this.text});
  final DesignNode node;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final rect = designRect(node);
    Widget result;
    switch (node['type']) {
      case 'text':
        result = Text(
          text ?? node['text'] as String,
          style: designTextStyle(node),
          textAlign: switch (node['align']) {
            'center' => TextAlign.center,
            'right' => TextAlign.right,
            _ => TextAlign.left,
          },
          softWrap: true,
          overflow: TextOverflow.visible,
          textScaler: TextScaler.noScaling,
        );
      case 'image':
        final asset = node['asset'] as String;
        final fit = switch (node['fit']) {
          'cover' => BoxFit.cover,
          'contain' => BoxFit.contain,
          _ => BoxFit.fill,
        };
        result = asset.endsWith('.svg')
            ? SvgPicture.asset(asset, fit: fit)
            : Image.asset(asset, fit: fit, filterQuality: FilterQuality.medium);
        final radius = (node['radius'] as num? ?? 0).toDouble();
        if (radius > 0) {
          result = ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: result,
          );
        }
      default:
        final widths = (node['border'] as List? ?? [0, 0, 0, 0]).cast<num>();
        final colors =
            (node['borderColor'] as List? ??
                    [
                      'transparent',
                      'transparent',
                      'transparent',
                      'transparent',
                    ])
                .cast<String>();
        BorderSide side(int i) => widths[i] > 0
            ? BorderSide(
                width: widths[i].toDouble(),
                color: designColor(colors[i]),
              )
            : BorderSide.none;
        final radii = (node['radius'] as List? ?? [0, 0, 0, 0]).cast<num>();
        final background = node['gradient'] as String? ?? 'none';
        final gradientColors = RegExp(
          r'rgba?\([^)]+\)',
        ).allMatches(background).map((m) => designColor(m.group(0))).toList();
        result = DecoratedBox(
          decoration: BoxDecoration(
            color: designColor(node['color'] as String?),
            gradient: gradientColors.length >= 2
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors,
                  )
                : null,
            border: Border(
              top: side(0),
              right: side(1),
              bottom: side(2),
              left: side(3),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radii[0].toDouble()),
              topRight: Radius.circular(radii[1].toDouble()),
              bottomRight: Radius.circular(radii[2].toDouble()),
              bottomLeft: Radius.circular(radii[3].toDouble()),
            ),
          ),
        );
    }
    final opacity = (node['opacity'] as num? ?? 1).toDouble();
    if (opacity < 1) result = Opacity(opacity: opacity, child: result);
    return SizedBox(width: rect.width, height: rect.height, child: result);
  }
}

/// The design uses fixed geometric illustrations. This layer retains their
/// coordinates; the containing page scales to phone width and scrolls vertically.
class DesignLayers extends StatelessWidget {
  const DesignLayers({
    super.key,
    required this.nodes,
    this.offset = Offset.zero,
    this.textOverrides = const {},
  });
  final List<DesignNode> nodes;
  final Offset offset;
  final Map<String, String> textOverrides;
  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      for (final node in nodes)
        Positioned(
          left: designRect(node).left - offset.dx,
          top: designRect(node).top - offset.dy,
          width: designRect(node).width + (node['type'] == 'text' ? 1 : 0),
          height: designRect(node).height,
          child: DesignElement(node: node, text: textOverrides[node['id']]),
        ),
    ],
  );
}
