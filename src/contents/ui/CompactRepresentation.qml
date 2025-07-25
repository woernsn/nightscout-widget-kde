import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.core
import org.kde.plasma.extras as PlasmaExtras
import org.kde.kquickcontrolsaddons
import org.kde.plasma.components

ColumnLayout {

    anchors.fill: parent

    Label {
        id: currentBG_compact
        text: glucose + "\n" + trend

        anchors.fill: parent

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        MouseArea {
            id: mouseArea

            anchors.fill: parent

            property bool wasExpanded: false

            hoverEnabled: true
            onPressed: wasExpanded = root.expanded
            onClicked: mouse => {
                root.expanded = !wasExpanded;
            }
        }
    }
}
