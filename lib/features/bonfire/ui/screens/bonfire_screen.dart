import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroll/features/bonfire/states/bonfire_bloc.dart';
import 'package:stroll/features/bonfire/states/bonfire_event.dart';
import 'package:stroll/features/bonfire/states/bonfire_state.dart';
import 'package:stroll/features/bonfire/ui/widgets/question_card.dart';
import 'package:stroll/shared/widgets/custom_icon_btn.dart';

class BonfireScreen extends StatelessWidget {
  const BonfireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg-img.png',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 60.0, 5.0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Stroll Bonfire',
                      style: TextStyle(
                        fontSize: 34.0,
                        color: Color(0xFFCCC8FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 3.0),
                    Container(
                      margin: EdgeInsets.only(top: 7.0, left: 4.0),
                      child: SvgPicture.asset(
                        'assets/icons/arrow_down.svg',
                        height: 9.0,
                        width: 5.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/time.svg',
                      height: 15.0,
                      width: 13.0,
                    ),
                    const SizedBox(width: 3.0),
                    Text(
                      '22h 00m',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    SvgPicture.asset(
                      'assets/icons/people.svg',
                      height: 13.0,
                      width: 10.0,
                    ),
                    const SizedBox(width: 3.0),
                    Text(
                      '103',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                BlocBuilder<BonfireBloc, BonfireState>(
                    builder: (context, state) {
                  String? _selectedOption;
                  if (state is OptionSelectionChanged) {
                    _selectedOption = state.selectedOption;
                  }

                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipOval(
                              child: Image.asset(
                                'assets/images/profile_img.png',
                                width: 60.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: const Text(
                                      'Angelina, 28',
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        color: Color(0xFFF5F5F5),
                                        fontWeight: FontWeight.bold,
                                        height: 2.8,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0, bottom: 8.0, right: 28.0),
                                    child: const Text(
                                      'What is your favorite time of the day?',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFFF5F5F5),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: const Text(
                          '“Mine is definitely the peace in the morning.”',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromRGBO(203, 201, 255, 0.6),
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: <Widget>[
                          QuestionCard(
                            option: 'A',
                            questionText: 'The peace in the early mornings',
                            onSelectionChanged: (isSelected) {
                              if (isSelected) {
                                context
                                  .read<BonfireBloc>()
                                  .add(const OptionSelected('A'));
                              }
                            },
                            isSelected: _selectedOption == 'A',
                          ),

                          QuestionCard(
                            option: 'B',
                            questionText: 'The magical golden hours',
                            onSelectionChanged: (isSelected) {
                              if (isSelected) {
                                context
                                  .read<BonfireBloc>()
                                  .add(const OptionSelected('B'));
                              }
                            },
                            isSelected: _selectedOption == 'B',
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          QuestionCard(
                            option: 'C',
                            questionText: 'Wind-down time after dinners',
                            onSelectionChanged: (isSelected) {
                              if (isSelected) {
                                context
                                  .read<BonfireBloc>()
                                  .add(const OptionSelected('C'));
                              }
                            },
                            isSelected: _selectedOption == 'C',
                          ),
                          QuestionCard(
                            option: 'D',
                            questionText: "The serenity past midnight",
                            onSelectionChanged: (isSelected) {
                              if (isSelected) {
                                context
                                  .read<BonfireBloc>()
                                  .add(const OptionSelected('D'));
                              }
                            },
                            isSelected: _selectedOption == 'D',
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Pick your option.\nwho has a similar mind.',
                              style: const TextStyle(
                                color: Color(0xFFE5E5E5),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            CustomIconBtn(
                              backgroundColor: Colors.transparent,
                              borderColor: const Color(0xFF8B88EF),
                              borderWidth: 2.2,
                              onPressed: () {
                                // Action when the button is pressed
                              },
                              child: SvgPicture.asset(
                                'assets/icons/mic.svg',
                                width: 19.0,
                                height: 26.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            CustomIconBtn(
                              backgroundColor: const Color(0xFF8B88EF),
                              borderColor: const Color(0xFF8B88EF),
                              borderWidth: 2.2,
                              onPressed: () {
                                // Action when the button is pressed
                              },
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: const Color(0xFF020202),
                                size: 26.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
