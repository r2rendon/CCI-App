import 'package:flutter/material.dart';

/// Widget que envuelve una pantalla y permite retroceder deslizando desde la izquierda hacia la derecha
class SwipeBackWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onBack;

  const SwipeBackWrapper({
    super.key,
    required this.child,
    this.onBack,
  });

  @override
  State<SwipeBackWrapper> createState() => _SwipeBackWrapperState();
}

class _SwipeBackWrapperState extends State<SwipeBackWrapper> {
  double _dragStartX = 0.0;
  double _dragDeltaX = 0.0;
  bool _isVerticalScroll = false;

  void _handleBack() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        _dragStartX = details.globalPosition.dx;
        _dragDeltaX = 0.0;
        _isVerticalScroll = false;
      },
      onHorizontalDragUpdate: (details) {
        // Solo detectar si el gesto empieza desde el borde izquierdo (primeros 60px)
        if (_dragStartX < 60) {
          final absDx = details.delta.dx.abs();
          final absDy = details.delta.dy.abs();
          
          if (absDx > absDy * 1.5) {
            // Movimiento principalmente horizontal desde la izquierda
            _dragDeltaX += details.delta.dx;
          } else if (absDy > absDx) {
            // Movimiento principalmente vertical, ignorar este gesto
            _isVerticalScroll = true;
          }
        } else {
          // Si no empezó desde la izquierda, ignorar
          _isVerticalScroll = true;
        }
      },
      onHorizontalDragEnd: (details) {
        // Solo procesar si empezó desde la izquierda y se deslizó hacia la derecha
        // _dragDeltaX positivo = deslizar desde izquierda hacia la derecha (retroceder)
        if (_dragStartX < 60 && !_isVerticalScroll && _dragDeltaX > 80) {
          _handleBack();
        }
        // Resetear valores
        _dragStartX = 0.0;
        _dragDeltaX = 0.0;
        _isVerticalScroll = false;
      },
      behavior: HitTestBehavior.translucent,
      child: widget.child,
    );
  }
}

