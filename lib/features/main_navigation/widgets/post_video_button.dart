import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class PostVideoButton extends StatefulWidget {
  const PostVideoButton({
    Key? key,
    required this.onButtonTap,
    required this.inverted,
  }) : super(key: key);

  final VoidCallback onButtonTap;
  final bool inverted;

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onButtonTap();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    _scale = 1 + _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child: Transform.scale(
        scale: _scale,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 20,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff61D4F0),
                  borderRadius: BorderRadius.circular(
                    Sizes.size8,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(
                    Sizes.size8,
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size12,
              ),
              decoration: BoxDecoration(
                color: !widget.inverted || isDark ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(
                  Sizes.size6,
                ),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color:
                      !widget.inverted || isDark ? Colors.black : Colors.white,
                  size: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
