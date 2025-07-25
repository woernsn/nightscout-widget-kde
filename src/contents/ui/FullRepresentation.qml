import QtQuick
import QtQuick.Layouts
import org.kde.quickcharts as Charts
import org.kde.quickcharts.controls
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.core
import org.kde.plasma.extras as PlasmaExtras
import org.kde.kquickcontrolsaddons
import org.kde.plasma.components
import org.kde.quickcharts.controls as ChartsControls

ColumnLayout {
    id: diagramRoot

    anchors.fill: parent

    Item {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.preferredHeight: 420
        Layout.preferredWidth: 650

        Label {
            id: currentBG
            text: glucose + " " + trend

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }

            font.pointSize: 48

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Charts.LineChart {
            id: lineChart

            anchors {
                margins: Kirigami.Units.mediumSpacing
                left: yAxisLabels.right
                right: parent.right
                bottom: xAxisLabels.top
                top: currentBG.bottom
            }

            interpolate: true

            yRange {
                automatic: false
                from: usedChartMin
                to: usedChartMax
            }

            lineWidth: 5

            valueSources: Charts.ArraySource {
                array: valueSources
            }

            colorSource: Charts.SingleValueSource {
                value: Kirigami.Theme.highlightColor
            }
        }

        ChartsControls.AxisLabels {
            id: xAxisLabels

            anchors {
                left: lineChart.left
                right: lineChart.right
                bottom: parent.bottom
                leftMargin: -Kirigami.Units.mediumSpacing
                rightMargin: -Kirigami.Units.mediumSpacing
            }

            delegate: Label {
                text: ChartsControls.AxisLabels.label
            }

            source: Charts.ArraySource {
                array: labelSources
                wrap: false
            }
        }

        ChartsControls.AxisLabels {
            id: yAxisLabels

            direction: AxisLabels.VerticalBottomTop

            anchors {
                left: parent.left
                top: lineChart.top
                bottom: lineChart.bottom
            }

            delegate: Label {
                text: ChartsControls.AxisLabels.label
            }

            source: Charts.ChartAxisSource {
                chart: lineChart
                axis: Charts.ChartAxisSource.YAxis
                itemCount: 6
            }

            // Round up axis labels for custom ranges
            onVisibleChildrenChanged: {
                for (let child of yAxisLabels.visibleChildren) {
                    if (child.text != "") {
                        child.text = Math.round(child.text);
                        readData();
                    }
                }
            }
        }

        GridLines {
            id: horizontalLines

            anchors.fill: lineChart

            chart: lineChart

            direction: GridLines.Horizontal

            major.count: 2
            major.lineWidth: 2
            major.color: Qt.rgba(0.8, 0.8, 0.8, 0)

            minor.count: 8
            minor.lineWidth: 1
            minor.color: Qt.rgba(0.8, 0.8, 0.8, 0.2)
        }

        GridLines {
            id: verticalLines

            anchors.fill: lineChart

            chart: lineChart

            direction: GridLines.Vertical

            major.count: 1
            major.lineWidth: 2
            major.color: Qt.rgba(0.8, 0.8, 0.8, 0)

            minor.count: 4
            minor.lineWidth: 1
            minor.color: Qt.rgba(0.8, 0.8, 0.8, 0.2)
        }
    }
}
