import QtQuick
import QtQuick.Layouts

import org.kde.plasma.core
import org.kde.plasma.components
import org.kde.plasma.plasmoid
import org.kde.plasma.components
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    Plasmoid.configurationRequired: true

    readonly property var trendArrows: ["", "⬆️⬆️", "⬆️", "↗️", "➡️", "↘️", "⬇️", "⬇️⬇️", "↔️", "🔄"]

    property string nightscoutURL: Plasmoid.configuration.nightscoutURL
    property string nightscoutToken: Plasmoid.configuration.nightscoutToken
    property int updateInterval: Plasmoid.configuration.updateInterval
    property bool showUnits: Plasmoid.configuration.showUnits

    property string glucose: "???"
    property string trend: "???"

    compactRepresentation: CompactRepresentation {}
    fullRepresentation: FullRepresentation {
        Layout.minimumWidth: 350
        Layout.minimumHeight: 130
    }

    onNightscoutURLChanged: configChanged()
    onNightscoutTokenChanged: configChanged()


    // Check if the configuration was adapted completely and try to fetch data.
    function configChanged() {
        if (nightscoutURL != "https://appname.herokuapp.com" && nightscoutToken != "plasmoid-0000000") {
            Plasmoid.configurationRequired = false;
        }
        readData();
    }

    // Start the timer to refresh data!
    Timer {
        id: textTimer
        interval: updateInterval * 60 * 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: readData()
    }

    // Update on mouse-click
    MouseArea {
        id: mouse_area
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton

        onClicked:
        {
            readData()
        }
    }

    // Read the data from NightScout using the provided configuration.
    function readData() {
        console.log("reading..")
        var request = new XMLHttpRequest();
        request.onreadystatechange = function() {
            if (request.readyState == XMLHttpRequest.DONE) {

                if (request.status == 200) {
                    var j = JSON.parse(request.responseText);
                    var bgs = j.bgs[0];

                    glucose = bgs.sgv;
                    if (showUnits) {
                        glucose += " mg/dl";
                    }
                    trend =  trendArrows[bgs.trend];
                } else {
                    glucose = "ERR";
                    trend = request.status;
                }

            }
        }

        if (nightscoutURL.charAt(-1)) {
            nightscoutURL = nightscoutURL.substring(1);
        }

        request.open("GET", nightscoutURL + "/pebble/?token=" + nightscoutToken);
        request.send();
    }
}
