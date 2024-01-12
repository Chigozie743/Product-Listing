import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

////////////////////////////////////////////////////////////////////////////////////
// This is for smooth routing or transition. Rather than jumping, we made use of
// the PageTransition package.
////////////////////////////////////////////////////////////////////////////////////

void nextScreen(context, page) {
  Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.fade,
      child: page,
    ),
  );
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
    context,
    PageTransition(
      type: PageTransitionType.fade,
      child: page,
    ),
  );
}

void nextPop(context, page) {
  Navigator.pop(
    context,
    PageTransition(
      type: PageTransitionType.fade,
      child: page,
    ),
  );
}

////////////////////////////////////////////////////////////////////////////////////
// This is to making a jump routing or transition. Rather than jumping, we
// made use of the MaterialPageRoute package. (This is an alternative)
////////////////////////////////////////////////////////////////////////////////////

// void nextScreen(context, page) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => page));
// }
//
void nextScreenReplace1(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

// void nextPop(context, page) {
//   Navigator.pop(context, MaterialPageRoute(builder: (context) => page));
// }
