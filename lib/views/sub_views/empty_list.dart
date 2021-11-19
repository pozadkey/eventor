import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 40, 15, 40),
      child: Column(
        children: [
          Icon(
            Icons.list,
            color: Colors.grey[500],
          ),
          Text(
            'You have an empty list.',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
