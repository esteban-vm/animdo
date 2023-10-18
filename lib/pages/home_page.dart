import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late double _buttonSize;
  late Tween<double> _bgScale;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _buttonSize = 100.0;
    _bgScale = Tween(begin: 0.0, end: 1.0);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animController.repeat();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            _background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _button(),
                _icon(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _background() {
    return TweenAnimationBuilder(
      tween: _bgScale,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubicEmphasized,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget _button() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _buttonSize += _buttonSize == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.bounceInOut,
          height: _buttonSize,
          width: _buttonSize,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(_buttonSize),
          ),
          child: const Center(
            child: Text(
              'Basic!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return AnimatedBuilder(
      animation: _animController.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animController.value * 2 * pi,
          child: child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100.0,
        color: Colors.white,
      ),
    );
  }
}
