import 'package:flutter/material.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/pages/product_page.dart';
import '../shared/theme.dart';

class TileProduct extends StatelessWidget {
  final ProductModel product;
  const TileProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage(product : product)),),
      child: Container(
        margin: EdgeInsets.only(bottom: defaultMargin),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                '${product.galleries![0].url}',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.category!.name}',
                    style: subtitleTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${product.name}',
                    style: primaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${product.price}',
                    style: priceTextStyle.copyWith(fontWeight: medium),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
