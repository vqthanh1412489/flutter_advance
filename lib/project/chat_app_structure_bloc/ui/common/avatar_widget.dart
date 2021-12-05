import 'package:flutter/material.dart';
import 'package:flutter_advance_widget/project/chat_app_structure_bloc/ui/profile_verify/profile_verify_cubit.dart';
import 'package:provider/src/provider.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: child,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24,
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
