import 'dart:async';
import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheel_drag_game/icons.dart';
import 'package:wheel_drag_game/images.dart';

class WheelGame extends StatefulWidget {
  const WheelGame({super.key});

  @override
  State<WheelGame> createState() => _WheelGameState();
}

class _WheelGameState extends State<WheelGame> {
  bool isDrag = false;
  bool isSelect = false;
  List<int> selected = [0];
  List<String> images = [
    AppImages.cock1,
    AppImages.cock2,
    AppImages.cock3,
    AppImages.cock4,
    AppImages.cock5,
    AppImages.cock6,
    AppImages.cock7,
    AppImages.cock8,
  ];
  late StreamController<int> _selectedController;
  @override
  void initState() {
    super.initState();
    _selectedController = StreamController<int>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  int? outCome;
  @override
  void dispose() {
    _selectedController.close();
    super.dispose();
  }

  FlipCardController controller = FlipCardController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isDrag = !isDrag;
                          });
                        },
                        child: Container(
                          height: 16,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xffE6E7E8),
                          ),
                          child: Align(
                            alignment:
                                isDrag
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              height: 16,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),

                                color: Color(0xff9A9FB8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        height: 16,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            isSelect = selected.contains(index);
                            return InkWell(
                              onTap: () {
                                if (selected.contains(index)) {
                                  selected.removeAt(index);
                                } else {
                                  selected.add(index);
                                }
                                setState(() {});
                              },
                              child: SvgPicture.asset(
                                isSelect
                                    ? AppIcons.selectedStar
                                    : AppIcons.unSelectedStar,
                                height: 16,
                                width: 16,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 34,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ).copyWith(top: 3),
                    decoration: BoxDecoration(
                      color: Color(0xff9A9FB8),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      'الكلمة الصحيحة',
                      style: GoogleFonts.balooBhaijaan2(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 32,
                    width: 32,

                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(AppIcons.closeIcon),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 280,
                  width: 280,

                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: FortuneWheel(
                    items: List.generate(8, (index) {
                      return FortuneItem(
                        style: FortuneItemStyle(
                          color: Color(0xffE4E2EE),
                          borderWidth: 5,
                          borderColor: Colors.white,
                        ),
                        child: Container(
                          height: 80,
                          width: 80,
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.fill,
                            height: 74,
                            width: 74,
                          ),
                        ),
                      );
                    }),
                    selected: _selectedController.stream,
                    animateFirst: false,
                    onFling: () {
                      List<int> outComes = [0, 1, 2, 3, 4, 5, 6, 7];
                      outCome = outComes[Random().nextInt(outComes.length)];
                      _selectedController.add(outCome ?? 1);
                    },
                    onAnimationEnd: () {
                      setState(() {
                        controller.toggleCard();
                   
                      });
                    },
                    indicators: [
                      FortuneIndicator(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Container(
                                height: 24,
                                width: 24,

                                decoration: BoxDecoration(
                                  color: Color(0xffE4E2EE),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                SvgPicture.asset(AppIcons.wheelCursor, height: 40, width: 64),
                SizedBox(width: 30),
                FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  controller: controller,
                  back: Image.asset(AppImages.cock, height: 220, width: 220),
                  front:
                     Container(
                            height: 220,
                            width: 220,
                            color: Colors.white,
                          ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
