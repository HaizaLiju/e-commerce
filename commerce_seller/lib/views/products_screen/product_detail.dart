import 'package:commerce/const/const.dart';
import 'package:commerce/views/widgets/text_style.dart';
import 'package:get/get.dart';


class ProductDetail extends StatelessWidget {
  final dynamic data;
  const ProductDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: darkGrey)
        ),
        title: boldText(text: "${data['name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             VxSwiper.builder(
              autoPlay: true,
              height: 350,
              itemCount: data['imgs'].length, 
              aspectRatio: 16/9,
              viewportFraction: 1.0,
              itemBuilder: (context,index){
              return Image.network(
                 data['imgs'][index], 
                width: double.infinity, 
                fit: BoxFit.cover,
                );
            }),
            
            10.heightBox,            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: "${data['name']}", color: fontGrey, size: 16.0),

                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "${data['category']}", color: fontGrey, size: 16.0),
                      
                      10.widthBox,
                      normalText(text: "${data['subcategory']}", color: fontGrey, size: 16.0),
                    ],
                  ),

                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['rating']),
                    onRatingUpdate: (value){},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                    stepInt: true,
                  ),

                  10.heightBox,
                  boldText(text: "\$${data['price']}", color: red, size: 18.0),
                  //"${data['price']}".numCurrency.text.color(lightBlue).fontFamily(bold).size(18).make(),

                  20.heightBox,
                   Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Colors", color: fontGrey)
                              // child: "Color: ".text.color(textfieldGrey).make(),
                            ),
                    
                            Row(
                              children: 
                                List.generate(
                                  data['colors'].length, 
                                  (index) => 
                                      VxBox()
                                      .size(40, 40)
                                      .roundedFull
                                      .color(Color(data['colors'][index]))
                                      .margin(const EdgeInsets.symmetric(horizontal: 6))
                                      .make()
                                      .onTap(() {
                                      }),                                   
                                ),
                            ),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),

                        10.heightBox,
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Quantity", color: fontGrey),
                              //child: "Quantity: ".text.color(textfieldGrey).make(),
                            ),
                            normalText(text: "${data['quantity']} items", color: fontGrey),
                          ],
                        ),                    
                      ],
                    ).box.white.padding(const EdgeInsets.all(8)).shadowSm.make(),
                    const Divider(),
                    10.heightBox,
                    boldText(text: "Description", color: fontGrey),
                    //"Description".text.color(darkFontGrey).fontFamily(semibold).make(),
    
                    10.heightBox,
                    normalText(text: "${data['desc']}", color: fontGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}