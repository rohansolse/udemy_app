import 'package:flutter/material.dart';
import 'package:udemy_app/dice_roller.dart';
// import 'package:udemy_app/text_container.dart';

const startAllignment = Alignment.topCenter;
const endtAllignment = Alignment.bottomCenter;

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.color1, this.color2, {super.key});

  const GradientContainer.purple({super.key})
      : color1 = Colors.deepPurple,
        color2 = Colors.indigo;

  final Color color1;
  final Color color2;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: startAllignment,
          end: endtAllignment,
        ),
      ),
      child: const Center(
        // child: TextDecorator('Hello Rohan !'),
        child: DiceRoller(),
      ),
    );
  }
}

// class GradientContainer extends StatelessWidget {
//   const GradientContainer({super.key, required this.colors});
//   final List<Color> colors;
//   @override
//   Widget build(context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: colors,
//           begin: startAllignment,
//           end: endtAllignment,
//         ),
//       ),
//       child: const Center(
//         child: TextDecorator('Hello Rohan !'),
//       ),
//     );
//   }
// }
