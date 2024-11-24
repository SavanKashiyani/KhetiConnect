import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/app_bar/custom_app_bar.dart';
import 'package:kheticonnect/util/extensions.dart';
import '../../../resources/strings.dart';

class ProductImageZoomScreen extends BaseWidget {
  final List<String?> productImages;
  int index;

  ProductImageZoomScreen(this.productImages, this.index, {super.key});

  bool isImageZoomed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      extendBodyBehindAppBar: false,
      body: Column(children: [
        _renderBackArrow(),
        _renderPageView(),
      ]),
    );
  }

  _renderPageView() {
    return PhotoViewGallery.builder(
      itemCount: productImages.length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(productImages[index] ?? ''),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        );
      },
      backgroundDecoration: const BoxDecoration(color: Colors.white),
      pageController: PageController(initialPage: index),
      scrollDirection: Axis.horizontal,
    ).expanded;
  }

  _renderBackArrow() {
    return CustomAppBar(
      title: Strings.productImages(),
    );
  }
}
