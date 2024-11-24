import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/model/BannerInfo.dart';

class BannerListWidget extends StatefulWidget {
  const BannerListWidget(
      {super.key, required this.bannerList, required this.onBannerButtonClick});

  final List<BannerInfo> bannerList;
  final Function(BannerInfo banner) onBannerButtonClick;

  @override
  State<BannerListWidget> createState() => _BannerListWidgetState();
}

class _BannerListWidgetState extends State<BannerListWidget> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return widget.bannerList.isEmpty
        ? const SizedBox.shrink()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16.5),
                height: 165,
                child: CarouselSlider(
                  items: widget.bannerList
                      .map((banner) => _getBannerWidget(banner))
                      .toList(),
                  options: CarouselOptions(
                      height: 165,
                      clipBehavior: Clip.none,
                      enableInfiniteScroll: true,
                      // viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(milliseconds: 1400),
                      scrollDirection: Axis.horizontal,
                      onPageChanged:
                          (int index, CarouselPageChangedReason reason) {
                        setState(() {
                          currentPage = index;
                        });
                      }),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                clipBehavior: Clip.antiAlias,
                constraints: BoxConstraints.loose(Size.fromWidth(0.9.sw)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: ColorName.gray400,
                ),
                child: AnimatedSmoothIndicator(
                  effect: const ExpandingDotsEffect(
                    dotHeight: 6,
                    spacing: 0,
                    radius: 3,
                    strokeWidth: 26,
                    dotColor: ColorName.gray400,
                    activeDotColor: ColorName.gray700,
                  ),
                  count: widget.bannerList.length,
                  activeIndex: currentPage,
                ),
              )
            ],
          );
  }

  Widget _getBannerWidget(BannerInfo banner) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomImageView(
                imagePath: banner.image ?? '',
                height: 165,
                radius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
