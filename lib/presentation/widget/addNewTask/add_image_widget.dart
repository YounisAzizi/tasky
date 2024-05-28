import 'package:Tasky/domain/riverpod/is_todo_editing_riv.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:Tasky/theme/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/riverpod/pick_image_riv.dart';
import '../../../domain/riverpod/todos_riv.dart';

class AddImageWidget extends ConsumerStatefulWidget {
  const AddImageWidget({super.key,required this.index});
  final int index;

  @override
  ConsumerState<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends ConsumerState<AddImageWidget> {
  @override
  Widget build(BuildContext context) {
    final todoDetails = ref.watch(todosProvider);
    return InkWell(
      onTap: () {
        ref.read(pickImageProvider).pickImage(ImageSource.gallery);
      },
      child: DottedBorder(
        dashPattern: const [3, 1],
        borderType: BorderType.RRect,
        color: Colors.deepPurple.shade200,
        radius: const Radius.circular(12),
        strokeWidth: 2,
        padding: const EdgeInsets.all(18.0),
        borderPadding: const EdgeInsets.all(6),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(ref.watch(isTodoEditingProvider).isEditing)
            ClipRRect(
              borderRadius:BorderRadius.circular(30) ,
              child: CachedNetworkImage(
                width: 100,
                imageUrl: todoDetails.todos[widget.index]['image'],
                placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 13,
                      width: 13,
                      child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                        strokeWidth: 1,
                        strokeAlign: 5,
                      ),
                    )),
                errorWidget: (context, url, error) => Image.asset('assets/shopping_icon.png'),
              ),
            ),
            SizedBox(width: 5,),
            Icon(Icons.add_photo_alternate_outlined,size: 28,color: Colors.deepPurple,),
            SizedBox(width: 5,),
            Text('Add Img',
            style: TextStyle(
              color: AppColors.mainThemColor,
              fontWeight: FontWeight.w500,
              fontSize: 18
            ),),
          ],
            ),
      ),
    );
  }
}
