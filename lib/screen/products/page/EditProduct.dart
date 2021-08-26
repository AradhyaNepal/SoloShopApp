import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solo_shop_app_practice/models/Product.dart';
import 'package:solo_shop_app_practice/screen/products/providers/ProductsProvider.dart';

class EditProduct extends StatefulWidget {
  static const route='EditProduct';
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool isLoading=false;
  var _editedProduct=Product(
      id: 'C10',
      title: '',
      description: '',
      price: 0,
      imageUrl: '');
  final _priceFocusNode=FocusNode();
  final _descriptionFocusNode=FocusNode();
  final _imageUrlController=TextEditingController();
  final _imageUrlFocusNode=FocusNode();
  final _form=GlobalKey<FormState>();
  bool forEdit=false;
  bool _isInit=true;
  var _initValues={
    'title':'',
    'description':'',
    'price':'',
    'imageUrl':'',

  };
  @override
  void initState() {
    // TODO: implement initState
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl(){
    if(!_imageUrlFocusNode.hasFocus){
      setState(() {

      });
    }

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit){
      final String? productId=ModalRoute.of(context)!.settings.arguments as String?;
      if (productId!=null){
        _editedProduct=Provider.of<ProductsProvider>(context,listen: false).findById(productId);
        _initValues={
          'title':_editedProduct.title,
          'description':_editedProduct.description,
          'price':_editedProduct.price.toString() ,
          'imageUrl':_editedProduct.imageUrl,

        };
        _imageUrlController.text=_initValues['imageUrl'].toString();
        forEdit=true;
      }

    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: (){
                _saveForm();
              },
              icon: Icon(Icons.save)
          )
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            TextFormField(
              initialValue: _initValues['title'],
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onSaved: (value){
                _editedProduct.title=value!;
              },
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter Some Text';
                }
                  return null;
              },
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
            ),
            TextFormField(
              initialValue: _initValues['price'],
              decoration: InputDecoration(labelText: 'Price'),
              focusNode: _priceFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (value)=>_editedProduct.price=double.parse(value!),
              onFieldSubmitted: (_)=>{
                FocusScope.of(context).requestFocus(_descriptionFocusNode)
              },
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter Some Text';
                }
                if(double.tryParse(value)==null){
                  return 'Please Enter valid number';
                }
                if (double.parse(value)<=0){
                  return 'Please enter number greater than Zero';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _initValues['description'],
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              keyboardType: TextInputType.multiline,
              onSaved: (value)=>_editedProduct.description=value!,
              onFieldSubmitted: (_){
                _saveForm();
              },
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter Some Text';
                }
                return null;
              },

            ),

            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 8,right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.grey)
                  ),
                  child:_imageUrlController.text.isEmpty?Text('Enter URL'):
                  FittedBox(
                    child:Image.network(
                        _imageUrlController.text,
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Image Url'
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Some Text';
                      }

                      return null;
                    },
                    onSaved: (value)=>_editedProduct.imageUrl=value!,
                  ),
                )
              ],
            ),
            isLoading?Center(child: CircularProgressIndicator(),):SizedBox(),

          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  void _saveForm(){
    setState(() {
      isLoading=true;

    });
    if(_form.currentState!.validate()){
    _form.currentState!.save();
    if(forEdit){
      Provider.of<ProductsProvider>(context,listen: false).updateProduct(_editedProduct.id, _editedProduct).then((value) {
        setState(() {
          isLoading=false;
        });
        Navigator.pop(context);
      }

      );

    }
    else{

      Provider.of<ProductsProvider>(context,listen: false).addProduct(_editedProduct).then((value){
        setState(() {
          isLoading=false;
        });
        Navigator.pop(context);
      }).catchError((error){
         return showDialog<Null>(
            context: context,
            builder: (context)=>AlertDialog(
              title: Text('Can not connect') ,
              content: Text('There was an error '+error.toString()),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);// TO remove alert dialog
                      //Then will be automatically executed when alert dialog is closed
                    },
                    child:Text('Okay')
                )
              ],
            )
        );
      }

      );
    }

    }

  }
}
