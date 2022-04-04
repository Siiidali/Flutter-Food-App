import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/widgets/head_text.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pc = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double scaleValue = 0.8;
  double _height = 220;

  @override
  void initState() {
    super.initState();
    pc.addListener(() {
      setState(() {
        _currPageValue = pc.page!;
        // print(_currPageValue);
      });
    });
  }

  @override
  void dispose() {
    pc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          child: PageView.builder(
              controller: pc,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _sliderPageItem(position);
              }),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }

  Widget _sliderPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleValue);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          scaleValue + (_currPageValue - index + 1) * (1 - scaleValue);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - scaleValue);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        Container(
          height: 220,
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.orange,
            image: const DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/image/food0.png")),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 120,
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xffe8e8e8),
                      blurRadius: 5,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadText(text: 'Chinese Side'),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Wrap(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: AppColors.mainColor,
                                      size: 15,
                                    ))),
                        const SizedBox(
                          width: 10,
                        ),
                        SmallText(text: '4.5'),
                        const SizedBox(
                          width: 10,
                        ),
                        SmallText(text: '1287'),
                        const SizedBox(
                          width: 10,
                        ),
                        SmallText(text: 'comments')
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndText(
                            icon: Icons.circle_sharp,
                            text: 'Noramal',
                            iconColor: AppColors.iconColor1),
                        const SizedBox(
                          width: 5,
                        ),
                        IconAndText(
                            icon: Icons.location_on,
                            text: '1.7Km',
                            iconColor: AppColors.mainColor),
                        const SizedBox(
                          width: 5,
                        ),
                        IconAndText(
                            icon: Icons.access_time_rounded,
                            text: '32min',
                            iconColor: AppColors.iconColor2),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}
