import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/screen/products/providers/ProductsProvider.dart';
import '../widgets/SpecificProductManageWidget.dart';
import 'package:solo_shop_app_practice/common/Widgets/DrawerWidget.dart';
import 'EditProduct.dart';

class ManageProduct extends StatelessWidget {
  static const route='/ManageProduct';

  Future<void> refresh(BuildContext context) async{
    await Provider.of<ProductsProvider>(context,listen: false).fetchProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushNamed(context, EditProduct.route,);

              },
              icon: Icon(Icons.add))

        ],
      ),
      body: FutureBuilder(
        future: refresh(context),
        builder: (context,snapShot){
          return snapShot.connectionState == ConnectionState.waiting?
          Center(child: CircularProgressIndicator(),):
          RefreshIndicator(
            onRefresh: ()=>refresh(context),
            child: Consumer<ProductsProvider>(
              builder: (context,productProvider,child){
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: productProvider.items.length,
                    itemBuilder: (context,index)=>SpecificUserProduct(
                        id: productProvider.items[index].id,
                        title: productProvider.items[index].title,
                        imageUrl: productProvider.items[index].imageUrl),
                  ),
                );
              },

            ),
          );
        },
      ),
    );
  }
}
