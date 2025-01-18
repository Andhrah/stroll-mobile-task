import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String questionText;
  final String option;
  final ValueChanged<bool> onSelectionChanged;
  final bool isSelected;

  const QuestionCard({
    super.key,
    required this.questionText,
    required this.option,
    required this.onSelectionChanged,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelectionChanged(!isSelected),
      child: Container(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 8, right: 0),
        margin: EdgeInsets.fromLTRB(8.0, 10.0, 5.0, 5.0),
        decoration: BoxDecoration(
          color: const Color(0xFF232A2E),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(35, 42, 46, 1),
              blurRadius: 4.0,
              offset: const Offset(0.0, 2.0),
            ),
          ],
          border: Border.all(
            color: isSelected ? const Color(0xFF8B88EF) : Colors.transparent,
            width: isSelected ? 2.0 : 0.0,
          ),
        ),
        width: 196.0,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(2.0),
              margin: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
              width: 25.0,
              height: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color:
                    isSelected ? const Color(0xFF8B88EF) : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : const Color(0xFFC4C4C4),
                  width: isSelected ? 2.0 : 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    color: isSelected ? Color(0xFFF5F5F5) : Color(0xFFC4C4C4),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 125.0,
              child: Text(
                questionText,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
