import 'package:flutter/material.dart';
import 'package:kheticonnect/presentation/custom/widget/loader.dart';

class PaginatedListView extends StatefulWidget {
  final List<Widget> itemList;
  final Future<void> Function()? loadMore;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  const PaginatedListView({
    Key? key,
    required this.itemList,
    this.loadMore,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
  }) : super(key: key);

  @override
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.itemList.length + (widget.loadMore != null ? 1 : 0),
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      itemBuilder: (context, index) {
        if (index >= widget.itemList.length) {
          return _buildLoaderIndicator();
        }
        return widget.itemList[index];
      },
    );
  }

  Widget _buildLoaderIndicator() {
    return const SizedBox.shrink();
  }

  void _loadMore() async {
    if (!_isLoading && widget.loadMore != null) {
      setState(() {
        _isLoading = true;
      });

      await widget.loadMore!();

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}