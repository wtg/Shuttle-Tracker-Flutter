import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShuttleSVG extends StatefulWidget {
  final Color svgColor;

  ShuttleSVG({this.svgColor});

  @override
  _ShuttleSVGState createState() => _ShuttleSVGState();
}

class _ShuttleSVGState extends State<ShuttleSVG> {
  String _getString() {
    var svgInput = widget.svgColor.value
        .toRadixString(16)
        .toString()
        .replaceAll('0xff', '');

    var svgString =
        '''<svg width="60px" height="60px" viewBox="0 0 60 60" version="1.1" 
        xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <title>shuttle</title>
        <defs></defs>
        <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
            <g id="shuttle">
                <path d="M51.353,0.914 C51.648,1.218 51.72,1.675 51.532,2.054 L27.532,50.469
                C27.362,50.814 27.011,51.025 26.636,51.025 C26.58,51.025 26.524,51.02 26.467,51.01
                  C26.032,50.936 25.697,50.583 25.643,50.145 L23.098,29.107 L0.835,25.376\
                  C0.402,25.304 0.067,24.958 0.009,24.522 C-0.049,24.086 0.184,23.665 0.583,23.481
                    L50.218,0.701 C50.603,0.524 51.058,0.609 51.353,0.914 Z" id="Background" 
                    fill="#$svgInput"></path>
                <path d="M51.353,0.914 C51.058,0.609 50.603,0.524 50.218,0.701 L0.583,23.481
                C0.184,23.665 -0.049,24.086 0.009,24.522 C0.067,24.958 0.402,25.304 0.835,25.376
                  L23.098,29.107 L25.643,50.145 C25.697,50.583 26.032,50.936 26.467,51.01
                  C26.524,51.02 26.58,51.025 26.636,51.025 C27.011,51.025 27.362,50.814 27.532,50.469
                    L51.532,2.054 C51.72,1.675 51.648,1.218 51.353,0.914 Z M27.226,46.582
                    L24.994,28.125 C24.94,27.685 24.603,27.332 24.166,27.259 L4.374,23.941
                      L48.485,3.697 L27.226,46.582 Z" id="Shape" fill="#000"></path>
            </g>
        </g>
        </svg>''';
    return svgString;
  }

  @override
  Widget build(BuildContext context) {
    var svgString = _getString();
    return SvgPicture.string(svgString);
  }
}
