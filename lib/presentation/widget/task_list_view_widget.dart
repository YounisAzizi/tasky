import 'package:Tasky/core/res/image_res.dart';
import 'package:Tasky/domain/riverpod/todos_riv.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../routes/routes.dart';
import '../../theme/text_style.dart';
import '../screen/main_screen.dart';

class TaskListView extends ConsumerStatefulWidget {
  final Status status;


  const TaskListView({super.key, required this.status});

  @override
  ConsumerState<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends ConsumerState<TaskListView> {
  @override
  Widget build(BuildContext context) {
    final todoDetails = ref.watch(todosProvider);

    return ListView.builder(
      itemCount: todoDetails.length,
      itemBuilder: (context, index) {
        if (widget.status == Status.all || todoDetails[index]['status'] == statusToString(widget.status)) {
          return InkWell(
            onTap: () {
              context.go("${Routes.taskDetails}${todoDetails[index]}");
              context.go('${Routes.taskDetails.replaceFirst(':index', '$index')}');
              // context.go("${Routes.verify}${emailController.text}");
            },
            child: Row(
              children: [
                Expanded(
                  child:
                ClipRRect(
                  borderRadius:BorderRadius.circular(30) ,
                  child: CachedNetworkImage(
                    imageUrl: todoDetails[index]['image'],
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
                ),),
                SizedBox(width: 5,),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              todoDetails[index]['title'].toString().length>12?
                              Text('${'${todoDetails[index]['title']!}'.substring(0,12)} ...',style: Styles.titleStyle,maxLines: 1,):
                              Text('${todoDetails[index]['title']!}',style: Styles.titleStyle,maxLines: 1,),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                  color: getStatusColor(todoDetails[index]['status']!),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    todoDetails[index]['status']!,
                                    maxLines: 1,
                                    style:  TextStyle(color:
                                    getStatusTextColor(todoDetails[index]['status']!)),
                                  ),
                                ),
                              ),
                              const Icon(Icons.more_vert,
                              color: Colors.black,
                              size: 30,),
                            ],
                          ),
                          Text(todoDetails[index]['desc']!,maxLines: 1,overflow: TextOverflow.ellipsis,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                   Icon(Icons.flag_outlined,color: priorityColor(todoDetails[index]['priority']!),),
                              Text(todoDetails[index]['priority']!, style:  TextStyle(color: priorityColor(todoDetails[index]['priority']!))),

                                ],
                              ),
                              Text('${todoDetails[index]['createdAt']!}'.substring(0,10)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'inprogress':
        return Colors.blue.withOpacity(0.2);
      case 'waiting':
        return Colors.deepOrange.withOpacity(0.2);
      case 'finished':
        return Colors.green.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case 'inprogress':
        return Colors.blue;
      case 'waiting':
        return Colors.deepOrange;
      case 'finished':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color priorityColor(String priority) {
    switch (priority) {
      case 'medium':
        return Colors.blue;
      case 'low':
        return Colors.deepOrange;
      case 'high':
        return Colors.deepPurple;
      default:
        return Colors.grey;
    }
  }
}
