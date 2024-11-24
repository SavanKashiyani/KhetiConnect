import 'package:flutter/material.dart';
import 'package:kheticonnect/data/enums/product_process_status_enum.dart';
import 'package:kheticonnect/data/enums/product_status_enum.dart';
import 'package:kheticonnect/data/model/product_status.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../resources/strings.dart';
import '../../../../resources/styles/app_decoration.dart';
import '../../../../util/text_styles.dart';
import '../../../../util/widget_util.dart';
import '../../../custom/widget/custom_text.dart';

class ProductStatusWidget extends StatelessWidget {
  final ProductStatus productStatus;
  bool showFullView;
  String? sellerStatus;

   ProductStatusWidget({super.key, required this.productStatus, this.showFullView = true, this.sellerStatus});

  @override
  Widget build(BuildContext context) {
    late Color color;
    switch (productStatus.key.toProductStatusEnum()) {
      case ProductStatusEnum.AvailableForRent:
        color = ColorName.green;
        break;
      case ProductStatusEnum.Booked:
        color = ColorName.blue;
        break;
      case ProductStatusEnum.RequestReceived:
        color = ColorName.primary800;
        break;
      case ProductStatusEnum.Occupied:
        color = ColorName.redDark;
        break;
      case ProductStatusEnum.NotAvailable:
        color = ColorName.coffee;
        break;
      case ProductStatusEnum.Cancelled:
        color = ColorName.coffee;
        break;
      case ProductStatusEnum.Completed:
        color = ColorName.green;
        break;
      case ProductStatusEnum.Approved:
        color = ColorName.green;
        break;
      case ProductStatusEnum.Pending:
        color = ColorName.yellow100;
        if(sellerStatus == ProductProcessStatusEnum.RequestRejectedBySeller.value) {
          color = ColorName.red;
        }
        break;
      default:
        color = ColorName.red;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      decoration:
          AppDecoration.getBoxDecoration(color.withOpacity(0.06), radius: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              height: 4,
              width: 4,
              decoration: AppDecoration.getBoxDecoration(color, radius: 4),
            ),
          ),
          // addWidth(4),
          Expanded(
            flex: showFullView ? 1 :0,
            child: CustomText(
              text: getProductStatus(),
              maxLines: 3,
              style: TextStyles.jakarta.medium.of(
                10,
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }

  String getProductStatus() {
    if(productStatus.key != null && sellerStatus!=null) {
      debugPrint("Product Status = ${productStatus.key} Seller Status = $sellerStatus");
      if(productStatus.key == ProductStatusEnum.Pending.value && sellerStatus == ProductProcessStatusEnum.RequestRejectedBySeller.value) {
        return Strings.rejected();
      }else if(productStatus.key == ProductStatusEnum.Pending.value && sellerStatus == ProductProcessStatusEnum.RequestCancelledByUser.value) {
        return Strings.cancelled();
      }
    }
    return productStatus.value ?? productStatus.key.toProductStatusEnum().type;
  }
}
