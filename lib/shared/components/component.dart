import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/webview_screen.dart';

Widget buildArcticleItem(article, context) => InkWell(
      onTap: () {
        NavigatorTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: '${article['urlToImage']}',

              fit: BoxFit.cover,

              width: 120.0,

              height: 120.0,

              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),

              // في حالة التحميل

              progressIndicatorBuilder: (context, url, progress) =>
                  CircularProgressIndicator(
                value: progress.progress,
              ),

              // في حالة الخطا

              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, BuildContext context, {isSearch = false}) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArcticleItem(list[index], context),
        separatorBuilder: (context, index) => MyDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

Widget MyDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 10.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void NavigatorTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Widget),
    );

void NavigatorAndRemove(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

Widget defualtFormField({
  required TextInputType Type,
  required TextEditingController Controller,
  Function? onsubmit,
  Function? onTap,
  required String? Function(String? val) validate,
  required String text,
  required IconData pre,
  bool isPassword = false,
  IconData? suff,
  Function? suffpressed,
  Function? onchange,
  Function? onSubmit,
}) =>
    TextFormField(
      keyboardType: Type,
      controller: Controller,
      onFieldSubmitted: (String value) {
        onsubmit!(value);
      },
      onChanged: (String value) {
        onchange!(value);
      },
      validator: (value) {
        return validate(value);
      },
      onTap: () {
        onTap!();
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        label: Text(
          text,
        ),
        prefixIcon: Icon(pre),
        suffixIcon: suff != null
            ? IconButton(
                icon: Icon(
                  suff,
                ),
                onPressed: () {
                  suffpressed!();
                })
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
          10.0,
        )),
      ),
    );
