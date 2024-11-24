import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';
import '../../base/api_render_state.dart';

//ignore: must_be_immutable
class StackLoader extends StatelessWidget {
  late List<ApiRenderState?> state;
  final Widget child;

  StackLoader(
      {super.key,
      ApiRenderState? state,
      List<ApiRenderState?>? stateList,
      required this.child}) {
    this.state = stateList ?? [state];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: state.any((element) => element is Loading),
          child: _buildLoader(),
        ),
        Visibility(
          visible: state.any((element) => element is LoadMore),
          child: _buildBottomLoader(),
        )
      ],
    );
  }
}

Widget _buildLoader() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        color: Colors.transparent,
      ),
      Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: ColorName.white,
        ),
        padding: const EdgeInsets.all(16),
        child: const Center(
          child: CircularProgressIndicator(
            color: ColorName.primary,
            strokeWidth: 2,
            backgroundColor: ColorName.gray50,
          ),
        ),
      ),
    ],
  );
}

Widget _buildBottomLoader() {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: LinearProgressIndicator(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
