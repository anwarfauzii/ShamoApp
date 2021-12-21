import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/providers/wishlist_provider.dart';
import 'package:shamo/shared/theme.dart';
import 'package:shamo/widgets/custom_button.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int currentIndex = 0;
  List images = [
    'assets/image_shoe.png',
    'assets/image_shoe.png',
    'assets/image_shoe.png',
  ];

  List familiarShoes = [
    'assets/image_shoe.png',
    'assets/image_shoe2.png',
    'assets/image_shoe3.png',
    'assets/image_shoe4.png',
    'assets/image_shoe5.png',
    'assets/image_shoe6.png',
    'assets/image_shoe7.png',
    'assets/image_shoe8.png',
    'assets/image_shoe9.png',
  ];
  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    Widget indicator(int index) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: currentIndex == index ? 16 : 4,
        height: 4,
        decoration: BoxDecoration(
          color: currentIndex == index ? primaryColor : const Color(0xffC4C4C4),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    Widget familiarShoesCard(String imageUrl) {
      return Container(
        margin: const EdgeInsets.only(right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child:
              Image.asset(imageUrl, width: 54, height: 54, fit: BoxFit.cover),
        ),
      );
    }

    Widget header() {
      int index = -1;
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: 20, left: defaultMargin, right: defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.chevron_left),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.shopping_bag,
                    color: backgroundColor1,
                  ),
                )
              ],
            ),
          ),
          CarouselSlider(
            items: widget.product.galleries!
                .map((image) => Image.network('${image.url}',
                    width: MediaQuery.of(context).size.width,
                    height: 310,
                    fit: BoxFit.cover))
                .toList(),
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.galleries!.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          )
        ],
      );
    }

    Widget content() {
      int index = -1;
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 17),
        padding: EdgeInsets.symmetric(vertical: defaultMargin),
        decoration: BoxDecoration(
          color: backgroundColor1,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.product.name}',
                        style: primaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: semiBold),
                      ),
                      Text(
                        '${widget.product.category!.name}',
                        style: secondaryTextStyle.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      wishlistProvider.setProduct(widget.product);
                      if (wishlistProvider.isWishlist(widget.product)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: secondaryColor,
                            content: const Text(
                                'Has Been added to the wishlist',
                                textAlign: TextAlign.center),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: alertColor,
                            content: const Text(
                                'Has been removed from the wishlist',
                                textAlign: TextAlign.center),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: wishlistProvider.isWishlist(widget.product)
                            ? secondaryColor
                            : subtitleColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.favorite_rounded,
                          color: wishlistProvider.isWishlist(widget.product)
                              ? primaryTextColor
                              : backgroundColor1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price starts from', style: primaryTextStyle),
                  Text(
                    '\$${widget.product.price}',
                    style: priceTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: primaryTextStyle.copyWith(fontWeight: medium),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${widget.product.description}',
                      style: subtitleTextStyle.copyWith(fontWeight: light),
                      textAlign: TextAlign.justify,
                    ),
                  ]),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Text(
                'Fimiliar Shoes',
                style: primaryTextStyle.copyWith(fontWeight: medium),
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: familiarShoes.map((image) {
                  index++;
                  return Container(
                      margin: EdgeInsets.only(left: index == 0 ? 16 : 0),
                      child: familiarShoesCard(image));
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                children: [
                  SizedBox(
                    width: 54,
                    height: 54,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        side: BorderSide(color: primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Icon(
                        Icons.chat,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 130,
                    height: 54,
                    margin: const EdgeInsets.only(left: 16),
                    child: CustomButton(
                      onPressed: () {},
                      text: 'Add to Cart',
                      textColor: primaryTextColor,
                      backgroundColor: primaryColor,
                      textSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor6,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}
