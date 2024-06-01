import 'package:Tasky/state_managers/screens/new_task_screen_provider.dart';
import 'package:Tasky/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddImageWidget extends ConsumerWidget {
  final String imageUrl;

  const AddImageWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newTaskScreenState = ref.watch(newTaskScreenProvider);

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        ref.read(newTaskScreenProvider).pickImage(ImageSource.gallery);
      },
      child: newTaskScreenState.imageFile != null
          ? Image.file(newTaskScreenState.imageFile)
          : DottedBorder(
              dashPattern: const [3, 1],
              borderType: BorderType.RRect,
              color: AppColors.mainThemColor,
              radius: const Radius.circular(12),
              strokeWidth: 2,
              padding: const EdgeInsets.all(18.0),
              borderPadding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (ref.watch(newTaskScreenProvider).isEditing)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        width: 100,
                        imageUrl: imageUrl,
                        placeholder: (context, url) => Center(
                            child: SizedBox(
                          height: 13,
                          width: 13,
                          child: CircularProgressIndicator(
                            color: AppColors.mainThemColor,
                            strokeWidth: 1,
                            strokeAlign: 5,
                          ),
                        )),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/shopping_icon.png'),
                      ),
                    ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 28,
                    color: AppColors.mainThemColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add Img',
                    style: TextStyle(
                        color: AppColors.mainThemColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 19),
                  ),
                ],
              ),
            ),
    );
  }
}
