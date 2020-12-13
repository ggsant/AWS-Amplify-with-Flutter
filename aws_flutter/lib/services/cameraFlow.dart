import 'package:aws_flutter/screens/cameraPage.dart';
import 'package:aws_flutter/screens/galleryPage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraFlow extends StatefulWidget {
  final VoidCallback shouldLogOut;

  CameraFlow({Key key, this.shouldLogOut}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraFlowState();
}

class _CameraFlowState extends State<CameraFlow> {
  CameraDescription _camera;
  // Este sinalizador funcionará como o estado responsável por indicar quando a câmera deve ser mostrada ou não.
  bool _shouldShowCamera = false;

  // Para garantir que o navegador seja atualizado quando _shouldShowCamera for atualizado, estamos usando uma propriedade calculada para retornar a pilha de navegação correta com base no estado atual. Por enquanto, estamos usando páginas de espaço reservado.
  List<MaterialPage> get _pages {
    return [
      // Show Gallery Page
      MaterialPage(
        child: GalleryPage(
          shouldLogOut: widget.shouldLogOut,
          shouldShowCamera: () => _toggleCameraOpen(true),
        ),
      ),
      // Show Camera Page
      if (_shouldShowCamera)
        MaterialPage(
          child: CameraPage(
            camera: _camera,
            didProvideImagePath: (imagePath) {
              this._toggleCameraOpen(false);
            },
          ),
        ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _getCamera();
  }

  @override
  Widget build(BuildContext context) {
    // Semelhante ao _MyAppState, estamos usando o widget Navigator para determinar que página deve ser mostrada em determinado momento para uma sessão.
    return Navigator(
      pages: _pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  // Este método permitirá alternar se a câmera é mostrada ou não sem precisar implementar setState() no site da chamada.
  void _toggleCameraOpen(bool isOpen) {
    setState(() {
      this._shouldShowCamera = isOpen;
    });
  }

  void _getCamera() async {
    final camerasList = await availableCameras();
    setState(() {
      final firstCamera = camerasList.first;
      this._camera = firstCamera;
    });
  }
}
