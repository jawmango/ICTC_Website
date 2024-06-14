import 'package:flutter/material.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

List<BannerModel> listBanners = [
  BannerModel(id: "1", imagePath: 'assets/images/logo_ictc.png'),
  BannerModel(id: "2", imagePath: 'assets/images/logo_ictc.png'),
  BannerModel(id: "3", imagePath: 'assets/images/course2.png'),
  BannerModel(id: "4", imagePath: 'assets/images/logo_ictc.png'),
];

class _CarouselWidgetState extends State<CarouselWidget> {

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController
    _pageController = PageController(initialPage: 0, keepPage: true,);
  }


  @override
  Widget build(BuildContext context) {
    return BannerCarousel(
      banners: listBanners,
      customizedIndicators: IndicatorModel.animation(
          width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
      height: MediaQuery.sizeOf(context).height * 0.5,
      activeColor: Colors.amberAccent,
      disableColor: Colors.white,
      animation: true,
      borderRadius: 10,
      onTap: (id) => print(id),
      width: MediaQuery.sizeOf(context).height * 0.6,
      indicatorBottom: false,
      pageController: _pageController,
    );
  }

}
