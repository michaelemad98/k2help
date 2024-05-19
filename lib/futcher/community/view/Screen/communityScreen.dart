import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/about/view/widgets/edttxtcomment/edtcomment.dart';
import 'package:k2help/futcher/community/controller/communityController.dart';
import 'package:k2help/futcher/community/model/communitymodel.dart';
import 'package:k2help/futcher/community/view/widgets/comment/comments.dart';
import 'package:k2help/futcher/community/view/widgets/edtPost/edtpost.dart';
import 'package:k2help/helper/scalesize.dart';
import 'package:k2help/helper/sherdprefrence/shardprefKeyConst.dart';
import 'package:k2help/helper/sherdprefrence/sharedprefrenc.dart';

import '../widgets/edtcomment/edtcomment.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'k2Help',
          style: TextStyle(color: Colors.white),
          textScaleFactor: ScaleSize.textScaleFactor(context),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          GetBuilder(
              init: CommunityController(),
              builder: (controller) {
                return Container(
                    margin: EdgeInsets.all(10),
                    child: IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      onPressed: ()async {

                      },
                    ));
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(17),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Community',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
                textScaleFactor: ScaleSize.textScaleFactor(context),
              ),
              SizedBox(
                height: 16,
              ),
              GetBuilder(
                  init: CommunityController(),
                  builder: (controller) {
                    return EDTPost(
                      tec: controller.postTec,
                      onPressed: () {
                        var isLogin = CacheHelper.getData(key: isLoginkey);
                        print(isLogin);
                        if (isLogin == null || isLogin == false) {
                          isLogin = false;
                          // /*
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Please Login First"),
                                content: Text(
                                    "You need to log in to access this feature."),
                                actions: <Widget>[
                                  Expanded(
                                    child: TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Get.toNamed('/login');
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          // */
                          // update();
                        } else {
                          isLogin = true;
                          controller.CreatePost();
                          // update();
                        }
                      },
                      file: controller.myfile,
                      imgPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.orange,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: height * 0.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.PickImagefromCamera();
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: EdgeInsets.all(20),
                                          child: Icon(
                                            Icons.camera_alt,
                                          )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.PickImagefromGalary();
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: EdgeInsets.all(20),
                                          child: Icon(
                                            Icons.photo,
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    );
                  }),
              SizedBox(
                height: 16,
              ),
              GetBuilder(
                  init: CommunityController(),
                  builder: (controller) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .orderBy(
                            'created_at',
                            descending: true,
                          )
                          .snapshots(),
                      builder:
                          (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                        if (chatSnapshot.connectionState ==
                            ConnectionState.waiting) {
                           return Container();
                        }
                        final chatDocs = chatSnapshot.data!.docs;

                        return Container(
                          height: height * 0.5,
                          child: ListView.builder(
                              key: const PageStorageKey('page'),
                              reverse: false,
                              controller: controller.scrollController,
                              // shrinkWrap: true,
                              itemCount: chatDocs.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(16),
                                  padding: EdgeInsets.all(16),
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FutureBuilder(
                                              future: FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(
                                                      '${chatDocs[index]['uid']}')
                                                  .get(),
                                              builder: (context, userSnapshot) {
                                                if (userSnapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Text('');
                                                } else if (userSnapshot
                                                    .hasData) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${userSnapshot.data!['first_name']} ${userSnapshot.data!['last_name']}',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        textScaleFactor:
                                                            ScaleSize
                                                                .textScaleFactor(
                                                                    context),
                                                      ),

                                                    ],
                                                  );
                                                } else {
                                                  return Text('');
                                                }
                                              }),
                                          Icon(Icons
                                              .arrow_drop_down_circle_rounded),
                                        ],
                                      ),
                                      Text(
                                        '${chatDocs[index]['description']}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.w500),
                                        textScaleFactor:
                                            ScaleSize.textScaleFactor(context),
                                      ),
                                      chatDocs[index]['image'] != null
                                          ? Container(
                                              margin: EdgeInsets.all(10),
                                              child: Image.network(
                                                '${chatDocs[index]['image']}',
                                                height: width * 0.4,
                                                fit: BoxFit.fill,
                                              ))
                                          : Container(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Expanded(child: EdtComment(tec: controller.commentTEC,hintText: 'Type first Comment',)),
                                          TextButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.cyan),
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.white,
                                                    isScrollControlled: true,
                                                    context: context,
                                                    builder: (context) {
                                                      return DraggableScrollableSheet(
                                                        expand: false,
                                                        builder: (context,ScrollController scrollController){
                                                         return SingleChildScrollView(
                                                           controller: scrollController,
                                                          child: Container(
                                                            width: double.infinity,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                20,
                                                                            top:
                                                                                10),
                                                                    child: Text(
                                                                      'Comment',
                                                                      style:
                                                                          TextStyle(),
                                                                      textScaleFactor:
                                                                          ScaleSize
                                                                              .textScaleFactor(
                                                                                  context),
                                                                    )),

                                                                Container(

                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        20,
                                                                        vertical:
                                                                        10),
                                                                    child: Expanded(
                                                                        child:
                                                                        EdtComment(
                                                                          tec: controller
                                                                              .commentTEC,
                                                                          hintText:
                                                                          'Write comment',
                                                                          prefixIcon:
                                                                          IconButton(
                                                                            icon: Icon(
                                                                              Icons
                                                                                  .arrow_forward_ios,
                                                                              color: Colors
                                                                                  .cyan,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              controller.AddCommentonFirestore(
                                                                                  chatDocs[index]
                                                                                      .id);
                                                                            },
                                                                          ),
                                                                        )
                                                                    )),
                                                                StreamBuilder(
                                                                    stream: FirebaseFirestore
                                                                        .instance
                                                                        .collection('posts')
                                                                        .doc(chatDocs[index].id).collection('comments').orderBy('created_at',descending: true).snapshots(),
                                                                    builder: (ctx, AsyncSnapshot<QuerySnapshot>commentSnapshot) {

                                                                      if (chatSnapshot.connectionState ==
                                                                          ConnectionState.waiting) {
                                                                        return CircularProgressIndicator();
                                                                      }
                                                                        final commentDocs = commentSnapshot.data!.docs;
                                                                        return ListView.builder(
                                                                            physics: NeverScrollableScrollPhysics(),
                                                                            shrinkWrap: true,
                                                                            itemCount: commentDocs.length,
                                                                            itemBuilder: (context, commentindex) {
                                                                              return Container(
                                                                                margin: EdgeInsets.all(10),
                                                                                padding: EdgeInsets.all(10),
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(color: Colors.black,width: 2),
                                                                                  borderRadius: BorderRadius.circular(25)
                                                                                ),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        FutureBuilder(
                                                                                            future: FirebaseFirestore.instance
                                                                                                .collection('users')
                                                                                                .doc(
                                                                                                '${commentDocs[commentindex]['useruid']}')
                                                                                                .get(),
                                                                                          builder: (context, userSnapshot) {
                                                                                            if(userSnapshot.connectionState == ConnectionState.waiting){
                                                                                              return Container();
                                                                                            }
                                                                                            return Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Text('${userSnapshot.data!['first_name']} ${userSnapshot.data!['last_name']}',style: TextStyle(
                                                                                                    color: Colors.black,
                                                                                                    fontWeight:
                                                                                                    FontWeight
                                                                                                        .w900),
                                                                                                  textScaleFactor:
                                                                                                  ScaleSize
                                                                                                      .textScaleFactor(
                                                                                                      context),),
                                                                                              ],
                                                                                            );
                                                                                          }
                                                                                        ),
                                                                                        // Text('${controller.formatTimestamp(commentDocs[commentindex]['created_at'])}')
                                                                                      ],
                                                                                    ),

                                                                                    Container(
                                                                                      margin: EdgeInsets.only(left: 20,top: 20),
                                                                                      child: Text("${commentDocs[commentindex]['description']}",style: TextStyle(
                                                                                          color: Colors.black,
                                                                                          fontWeight:
                                                                                          FontWeight
                                                                                              .w500),
                                                                                        textScaleFactor:
                                                                                        ScaleSize
                                                                                            .textScaleFactor(
                                                                                            context),),
                                                                                    ),
                                                                                    TextButton(
                                                                                        style: ButtonStyle(
                                                                                          foregroundColor:
                                                                                          MaterialStateProperty.all<
                                                                                              Color>(Colors.cyan),
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          // Get.back();
                                                                                          showModalBottomSheet(
                                                                                            backgroundColor:
                                                                                            Colors.white,
                                                                                            isScrollControlled: true,
                                                                                            context: context,
                                                                                            builder: (BuildContext context) {
                                                                                              return  DraggableScrollableSheet(
                                                                                                  expand: false,
                                                                                                  builder: (context,ScrollController scrollController){
                                                                                                    return SingleChildScrollView(
                                                                                                      controller: scrollController,
                                                                                                      child: Container(
                                                                                                        width: double.infinity,
                                                                                                        child: Column(
                                                                                                          crossAxisAlignment:
                                                                                                          CrossAxisAlignment
                                                                                                              .start,
                                                                                                          children: [
                                                                                                            Container(
                                                                                                                margin: EdgeInsets
                                                                                                                    .only(
                                                                                                                    left:
                                                                                                                    20,
                                                                                                                    top:
                                                                                                                    10),
                                                                                                                child: Text(
                                                                                                                  'Replay',
                                                                                                                  style:
                                                                                                                  TextStyle(),
                                                                                                                  textScaleFactor:
                                                                                                                  ScaleSize
                                                                                                                      .textScaleFactor(
                                                                                                                      context),
                                                                                                                )),

                                                                                                            Container(

                                                                                                                padding: EdgeInsets
                                                                                                                    .symmetric(
                                                                                                                    horizontal:
                                                                                                                    20,
                                                                                                                    vertical:
                                                                                                                    10),
                                                                                                                child: Expanded(
                                                                                                                    child:
                                                                                                                    EdtComment(
                                                                                                                      tec: controller
                                                                                                                          .replayTEC,
                                                                                                                      hintText:
                                                                                                                      'Write replay',
                                                                                                                      prefixIcon:
                                                                                                                      IconButton(
                                                                                                                        icon: Icon(
                                                                                                                          Icons
                                                                                                                              .arrow_forward_ios,
                                                                                                                          color: Colors
                                                                                                                              .cyan,
                                                                                                                        ),
                                                                                                                        onPressed:
                                                                                                                            () {
                                                                                                                          // controller.AddCommentonFirestore(
                                                                                                                          //     chatDocs[index]
                                                                                                                          //         .id);
                                                                                                                              controller.AddReplaytofFirestore(chatDocs[index].id,commentDocs[commentindex].id);
                                                                                                                        },
                                                                                                                      ),
                                                                                                                    )
                                                                                                                )),
                                                                                                            // /*
                                                                                                            StreamBuilder(
                                                                                                                stream: FirebaseFirestore
                                                                                                                    .instance
                                                                                                                    .collection('posts')
                                                                                                                    .doc(chatDocs[index].id).collection('comments').doc(commentDocs[commentindex].id).collection('replies').orderBy('created_at',descending: true).snapshots(),
                                                                                                                builder: (ctx, AsyncSnapshot<QuerySnapshot>replaySnapshot) {

                                                                                                                  if (chatSnapshot.connectionState ==
                                                                                                                      ConnectionState.waiting) {
                                                                                                                    return CircularProgressIndicator();
                                                                                                                  }
                                                                                                                  final replayDocs = replaySnapshot.data!.docs;
                                                                                                                  return ListView.builder(
                                                                                                                      physics: NeverScrollableScrollPhysics(),
                                                                                                                      shrinkWrap: true,
                                                                                                                      itemCount: replayDocs.length,
                                                                                                                      itemBuilder: (context, replayindex) {
                                                                                                                        return Container(
                                                                                                                          margin: EdgeInsets.all(10),
                                                                                                                          padding: EdgeInsets.all(10),
                                                                                                                          decoration: BoxDecoration(
                                                                                                                              border: Border.all(color: Colors.black,width: 2),
                                                                                                                              borderRadius: BorderRadius.circular(25)
                                                                                                                          ),
                                                                                                                          child: Column(
                                                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                            children: [
                                                                                                                              Row(
                                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                children: [
                                                                                                                                  FutureBuilder(
                                                                                                                                      future: FirebaseFirestore.instance
                                                                                                                                          .collection('users')
                                                                                                                                          .doc(
                                                                                                                                          '${replayDocs[replayindex]['useruid']}')
                                                                                                                                          .get(),
                                                                                                                                      builder: (context, userSnapshot) {
                                                                                                                                        if(userSnapshot.connectionState == ConnectionState.waiting){
                                                                                                                                          return Container();
                                                                                                                                        }
                                                                                                                                        return Column(
                                                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                          children: [
                                                                                                                                            Text('${userSnapshot.data!['first_name']} ${userSnapshot.data!['last_name']}',style: TextStyle(
                                                                                                                                                color: Colors.black,
                                                                                                                                                fontWeight:
                                                                                                                                                FontWeight
                                                                                                                                                    .w900),
                                                                                                                                              textScaleFactor:
                                                                                                                                              ScaleSize
                                                                                                                                                  .textScaleFactor(
                                                                                                                                                  context),),
                                                                                                                                          ],
                                                                                                                                        );
                                                                                                                                      }
                                                                                                                                  ),
                                                                                                                                  // Text('${controller.formatTimestamp(commentDocs[commentindex]['created_at'])}')
                                                                                                                                ],
                                                                                                                              ),

                                                                                                                              Container(
                                                                                                                                margin: EdgeInsets.only(left: 20,top: 20),
                                                                                                                                child: Text("${replayDocs[replayindex]['description']}",style: TextStyle(
                                                                                                                                    color: Colors.black,
                                                                                                                                    fontWeight:
                                                                                                                                    FontWeight
                                                                                                                                        .w500),
                                                                                                                                  textScaleFactor:
                                                                                                                                  ScaleSize
                                                                                                                                      .textScaleFactor(
                                                                                                                                      context),),
                                                                                                                              ),

                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        );
                                                                                                                      });

                                                                                                                }),
                                                                                                                // */

                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  }
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                        child:
                                                                                        Text('replay')),

                                                                                  ],
                                                                                ),
                                                                              );
                                                                            });

                                                                    }),

                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                        }
                                                      );
                                                    });
                                              },
                                              child:
                                                  Text(
                                                      'Comments'
                                                  )
                                          ),

                                        ],
                                      )

                                    ],
                                  ),
                                );
                              }),
                        );
                      },
                    );

                  })
            ],
          ),
        ),
      ),
    );
  }
}
