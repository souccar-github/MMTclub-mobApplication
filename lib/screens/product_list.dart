import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mmt_club/bloc/categoryBloc/category_bloc.dart';
import 'package:mmt_club/bloc/export_bloc.dart';
import 'package:mmt_club/bloc/productsBloc/products_bloc.dart';
import 'package:mmt_club/widgets/shimmer_list.dart';
import '../Localization/Localization.dart';
import '../bloc/newsBloc/news_bloc.dart';
import '../styles/app_colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/product/product_card.dart';

class ProductList extends StatefulWidget {
  static String routeName = "/ProductList";
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductsBloc productBloc = ProductsBloc();
  bool isSortingAtoZ = true;
  bool isFiltering = false;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    productBloc.add(const GetAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localization.of(context).getTranslatedValue("products"),
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textBlack,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textBlack,
            )),
      ),
      body: BlocBuilder(
        bloc: productBloc,
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is GetAllProductsWaiting) {
            return const ShimmerList();
          } else if (state is GetAllProductsSuccessfully) {
            return Column(
              children: [
                Container(
                  color: Colors.transparent,
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        size: 15.h,
                        icon: !isSortingAtoZ
                            ? FontAwesomeIcons.sortAlphaUp
                            : FontAwesomeIcons.sortAlphaDown,
                        onPressed: () {
                          setState(() {
                            isSortingAtoZ = !isSortingAtoZ;
                          });
                        },
                        text: Localization.of(context)
                            .getTranslatedValue("sorting"),
                      ),
                      CustomText(
                        text: Localization.of(context)
                            .getTranslatedValue("filtering"),
                        onPressed: () async {
                          CategoryBloc categoryBloc = CategoryBloc();
                          categoryBloc.add(GetCategoryEvent());
                          return buildFilteringDialog(context, categoryBloc);
                        },
                      ),
                    ],
                  ),
                ),
                state.productDetailsModels.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            Localization.of(context)
                                .getTranslatedValue("no_items_found"),
                            style: TextStyle(
                              fontSize: 17,
                              color: AppColors.basicColor,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: state.productDetailsModels.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = state.productDetailsModels;
                            if (isSortingAtoZ) {
                              data.sort((a, b) {
                                return a.name
                                    .toLowerCase()
                                    .compareTo(b.name.toLowerCase());
                              });
                            } else {
                              data = List.from(data.reversed);
                            }
                            return ProductCard(
                              product: data[index],
                            );
                          },
                        ),
                      )
              ],
            );
          } else if (state is GetAllProductsError) {
            SnackBar(
              content: Text(
                state.error.toString(),
                style: TextStyle(color: AppColors.textWhite),
              ),
              backgroundColor: AppColors.error,
            );
            return const SizedBox.shrink();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<dynamic> buildFilteringDialog(
      BuildContext context, CategoryBloc categoryBloc) {
    int? catID = -1;
    return showDialog(
      context: context,
      builder: (ctx) {
        return BlocBuilder(
          bloc: categoryBloc,
          builder: (context, state) {
            if (state is GetCategoryWaiting) {
              return const AlertDialog(
                content: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is GetCategorySuccessfully) {
              return AlertDialog(
                title: TextField(
                  controller: searchController,
                  cursorHeight: 25,
                  cursorColor: AppColors.basicColor,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  maxLines: 1,
                ),
                content: StatefulBuilder(
                  builder: (cxtStateFulBuilder, setInnerState) {
                    return ListView.builder(
                      itemCount: state.cats.length,
                      itemBuilder: (cxt, index) {
                        return ListTile(
                          title: Text(state.cats[index].name),
                          leading: Radio<int>(
                            toggleable: true,
                            value: state.cats[index].id,
                            groupValue: catID,
                            onChanged: (var value) {
                              log(catID.toString());
                              setInnerState(() {
                                catID = value;
                              });
                            },
                            activeColor: AppColors.basicColor,
                          ),
                        );
                      },
                    );
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (searchController.text.isNotEmpty || catID != -1) {
                        productBloc.add(GetAllProductsEvent(
                            catID: catID == -1 ? null : catID,
                            keyword: searchController.text.isEmpty
                                ? null
                                : searchController.text));
                      }

                      Navigator.of(ctx).pop();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
