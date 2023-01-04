import "package:cross_array_task_app/activities/block_based/containers/copy.dart";
import "package:cross_array_task_app/activities/block_based/containers/fill_empty.dart";
import "package:cross_array_task_app/activities/block_based/containers/go.dart";
import "package:cross_array_task_app/activities/block_based/containers/mirror.dart";
import "package:cross_array_task_app/activities/block_based/containers/paint.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_component.dart";
import "package:cross_array_task_app/activities/block_based/model/simple_container.dart";
import "package:cross_array_task_app/activities/block_based/options/cell.dart";
import "package:cross_array_task_app/activities/block_based/options/color.dart";
import "package:cross_array_task_app/activities/block_based/options/direction.dart";
import "package:cross_array_task_app/activities/block_based/types/component_type.dart";
import "package:cross_array_task_app/activities/block_based/types/container_type.dart";
import "package:flutter/material.dart";

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final GlobalKey _draggableKey = GlobalKey();

  /// Creating a list of SimpleContainer objects.
  List<SimpleContainer> containers = [
    SimpleContainer(name: "Vai a", type: ContainerType.go),
    SimpleContainer(name: "Colora", type: ContainerType.paint),
    SimpleContainer(name: "Riempi vuoti", type: ContainerType.fillEmpty),
    SimpleContainer(name: "Copia", type: ContainerType.copy),
    SimpleContainer(name: "Specchia", type: ContainerType.mirror),
  ];

  /// Creating a list of SimpleComponent objects.
  List<SimpleComponent> components = [
    SimpleComponent(name: "Colore", type: ComponentType.color),
    SimpleComponent(name: "Cella", type: ComponentType.cell),
    SimpleComponent(name: "Direzione", type: ComponentType.direction),
  ];

  Widget _buildComponentItem({required SimpleComponent component}) {
    switch (component.type) {
      case ComponentType.cell:
        return Draggable<SimpleComponent>(
          data: component,
          feedback: FractionalTranslation(
            translation: Offset.zero,
            child: ClipRRect(
              key: _draggableKey,
              borderRadius: BorderRadius.circular(15),
              child: Card(
                elevation: 20,
                color: Colors.transparent,
                child: Cell(active: false, component: component),
              ),
            ),
          ),
          child: Cell(
            active: false,
            component:
                SimpleComponent(type: component.type, name: component.name),
          ),
        );
      case ComponentType.color:
        return Draggable<SimpleComponent>(
          data: component,
          feedback: FractionalTranslation(
            translation: Offset.zero,
            child: ClipRRect(
              key: _draggableKey,
              borderRadius: BorderRadius.circular(15),
              child: Card(
                elevation: 20,
                color: Colors.transparent,
                child: Color(active: false, component: component),
              ),
            ),
          ),
          child: Color(
            active: false,
            component:
                SimpleComponent(type: component.type, name: component.name),
          ),
        );
      case ComponentType.direction:
        return Draggable<SimpleComponent>(
          data: component,
          feedback: FractionalTranslation(
            translation: Offset.zero,
            child: ClipRRect(
              key: _draggableKey,
              borderRadius: BorderRadius.circular(15),
              child: Card(
                elevation: 20,
                color: Colors.transparent,
                child:
                    Direction(active: false, mode: true, component: component),
              ),
            ),
          ),
          child: Direction(
            active: false,
            mode: true,
            component:
                SimpleComponent(type: component.type, name: component.name),
          ),
        );
    }
  }

  /// It returns a Draggable widget that has a feedback widget that is a Card with a
  /// child that is the result of calling the builder function
  ///
  /// Args:
  ///   container (SimpleContainer): The container that is being dragged.
  ///   builder (Function): This is the function that will be called to build the
  /// widget.
  ///
  /// Returns:
  ///   A Draggable widget.
  Widget _buildLongPressDraggable({
    required SimpleContainer container,
    required Function builder,
  }) =>
      Draggable<SimpleContainer>(
        data: SimpleContainer(name: container.name, type: container.type),
        feedback: FractionalTranslation(
          translation: Offset.zero,
          child: ClipRRect(
            key: _draggableKey,
            borderRadius: BorderRadius.circular(15),
            child: Card(
              elevation: 20,
              color: Colors.transparent,
              child: Function.apply(
                builder,
                [],
                {#active: false, #item: container, #onChange: (Size size) {}},
              ),
            ),
          ),
        ),
        child: Function.apply(
          builder,
          [],
          {#active: false, #item: container, #onChange: (Size size) {}},
        ),
      );

  /// It returns a widget that is a draggable version of the widget that is returned
  /// by the builder function that is passed in
  ///
  /// Args:
  ///   container (SimpleContainer): The container to be built.
  ///
  /// Returns:
  ///   A widget that is a long press draggable.
  Widget _buildContainerItem({required SimpleContainer container}) {
    switch (container.type) {
      case ContainerType.fillEmpty:
        return _buildLongPressDraggable(
          container: container,
          builder: FillEmpty.build,
        );
      case ContainerType.go:
        return _buildLongPressDraggable(
          container: container,
          builder: Go.build,
        );
      case ContainerType.paint:
        return _buildLongPressDraggable(
          container: container,
          builder: Paint.build,
        );
      case ContainerType.copy:
        return _buildLongPressDraggable(
          container: container,
          builder: Copy.build,
        );
      case ContainerType.mirror:
        return _buildLongPressDraggable(
          container: container,
          builder: Mirror.build,
        );
      case ContainerType.none:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.blueGrey,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Comandi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: containers.length + components.length,
                itemBuilder: (BuildContext context, int index) =>
                    index < containers.length
                        ? _buildContainerItem(container: containers[index])
                        : _buildComponentItem(
                            component: components[index - containers.length],
                          ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 5,
                ),
              ),
            ),
          ],
        ),
      );
}
