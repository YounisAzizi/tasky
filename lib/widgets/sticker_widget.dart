import 'package:Tasky/const/image_res.dart';
import 'package:Tasky/widgets/custom_circle_container.dart';
import 'package:flutter/material.dart';

class StickerWidget extends StatefulWidget {
  const StickerWidget({super.key, this.isSignUp = false});
  final bool isSignUp;

  @override
  State<StickerWidget> createState() => _StickerWidgetState();
}

class _StickerWidgetState extends State<StickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: widget.isSignUp ? 350 : 482,
      child: Stack(
        children: [
          Positioned(
            top: widget.isSignUp ? 90 : 126,
            left: widget.isSignUp ? -35 : -85,
            child: Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(70, 240, 128, 1).withOpacity(0.1),
                    Color.fromRGBO(70, 240, 138, 0.1).withOpacity(0.1),
                    Colors.transparent
                  ],
                  transform: GradientRotation(20),
                ),
              ),
            ),
          ),
          Positioned(
            top: widget.isSignUp ? 180 : 232,
            right: widget.isSignUp ? -35 : -85,
            child: Container(
              height: 160,
              width: 169,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(37, 85, 255, 1).withOpacity(0.1),
                    Color.fromRGBO(37, 85, 255, 0.25).withOpacity(0.1),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: widget.isSignUp ? 280 : 330,
            right: 226,
            child: Container(
              height: 160,
              width: 169,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(70, 189, 240, 1).withOpacity(0.1),
                    Color.fromRGBO(70, 179, 240, 0.15).withOpacity(0.1),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -70,
            right: 20,
            child: Container(
              height: 160,
              width: 169,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: RadialGradient(
                  colors: [
                    Color.fromRGBO(237, 240, 70, 1).withOpacity(0.1),
                    Color.fromRGBO(240, 233, 70, 0.15).withOpacity(0.1),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),
          // Background image
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              ImageRes.human,
              height: widget.isSignUp ? 130 : 159,
              width: 184,
            ),
          ),
          // Sticker Watch
          Positioned(
            top: widget.isSignUp ? 45 : 69,
            left: 104,
            child: Image.asset(
              ImageRes.watch,
              height: 50,
              width: 40,
            ),
          ),
          // Sticker Flower
          Positioned(
            top: widget.isSignUp ? 200 : 279,
            left: 79,
            child: Image.asset(
              ImageRes.flower,
              height: 52,
              width: 36,
            ),
          ),
          // Sticker Coffee
          Positioned(
            top: widget.isSignUp ? 235 : 310,
            left: 65,
            child: Transform.rotate(
              angle: 20, // Convert degrees to radians
              child: Image.asset(
                ImageRes.coffee,
                width: 18,
                height: 22,
              ),
            ),
          ),
          // Sticker Candy
          Positioned(
            top: widget.isSignUp ? 120 : 180,
            left: 84,
            child: Image.asset(
              ImageRes.candy,
              height: 26,
              width: 26,
            ),
          ),
          // Sticker Calendar
          Positioned(
            top: widget.isSignUp ? 106 : 136,
            left: 281,
            child: Image.asset(
              ImageRes.calenderImage,
              height: 27,
              width: 32,
            ),
          ),
          // Sticker Book
          Positioned(
            bottom: widget.isSignUp ? 160 : 205,
            right: 117,
            child: Image.asset(
              ImageRes.book,
              width: 62,
              height: 42,
            ),
          ),
          Positioned(
            top: widget.isSignUp ? 33 : 73,
            right: 154,
            child: CustomCircleContainer(
              color: Color.fromRGBO(146, 222, 255, 1),
              width: 8,
              height: 8,
            ),
          ),
          Positioned(
            top: widget.isSignUp ? 52 : 92,
            right: 202,
            child: CustomCircleContainer(
              color: Color.fromRGBO(190, 159, 255, 1),
              width: 4,
              height: 4,
            ),
          ),
          Positioned(
            top: widget.isSignUp ? 320 : 383,
            left: 250,
            child: CustomCircleContainer(
              color: Color.fromRGBO(234, 237, 42, 1),
              width: 8,
              height: 8,
            ),
          ),
          Positioned(
            top: widget.isSignUp ? 300 : 391,
            left: 138,
            child: CustomCircleContainer(
              color: Color.fromRGBO(255, 215, 228, 1),
              width: 8,
              height: 8,
            ),
          ),
          Positioned(
            top: widget.isSignUp ? 320 : 405,
            right: 230,
            child: CustomCircleContainer(
              color: Color.fromRGBO(164, 231, 249, 1),
              width: 4,
              height: 4,
            ),
          ),
        ],
      ),
    );
  }
}
