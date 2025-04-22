import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracing_game/tracing_game.dart';
import 'package:wheel_drag_game/icons.dart';

class LetterTracing extends StatefulWidget {
  const LetterTracing({super.key});

  @override
  State<LetterTracing> createState() => _LetterTracingState();
}

class _LetterTracingState extends State<LetterTracing> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  bool isDrag = false;
  bool isSelect = false;
  List<int> selected = [0];
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
            Expanded(
              child: TracingCharsGame(
                showAnchor: true,
                onTracingUpdated: (i) async {
                  print('onTracingUpdated $i');
                },
                onCurrentTracingScreenFinished: (index) async {
                  print('onCurrentTracingScreenFinished $index');
                },
                onGameFinished: (index) async {
                  print('onGameFinished $index');
                },
                loadingIndictor: Center(child: CircularProgressIndicator()),
                traceShapeModel: [
                  TraceCharsModel(
                    chars: [
                      TraceCharModel(
                        char: 'd',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                      TraceCharModel(
                        char: 'A',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  TraceCharsModel(
                    chars: [
                      TraceCharModel(
                        char: 'ب',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  TraceCharsModel(
                    chars: [
                      TraceCharModel(
                        char: 'ت',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  TraceCharsModel(
                    chars: [
                      TraceCharModel(
                        char: 'ث',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  TraceCharsModel(
                    chars: [
                      TraceCharModel(
                        char: 'ج',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  TraceCharsModel(
                    chars: [
                      TraceCharModel(
                        char: 'ح',
                        traceShapeOptions: const TraceShapeOptions(
                          innerPaintColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
