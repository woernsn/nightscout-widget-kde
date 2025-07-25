import QtQuick
import QtQuick.Layouts

import org.kde.plasma.core
import org.kde.plasma.components
import org.kde.plasma.plasmoid
import org.kde.plasma.components
import org.kde.kirigami as Kirigami

import "../lib/utils.js" as Utils

PlasmoidItem {
    id: root

    Plasmoid.configurationRequired: true

    readonly property var trendArrows: ["", "⬆️⬆️", "⬆️", "↗️", "➡️", "↘️", "⬇️", "⬇️⬇️", "↔️", "🔄"]

    property string nightscoutURL: Plasmoid.configuration.nightscoutURL
    property string nightscoutToken: Plasmoid.configuration.nightscoutToken
    property int updateInterval: Plasmoid.configuration.updateInterval
    property bool showUnits: Plasmoid.configuration.showUnits
    property int chartMin: Plasmoid.configuration.chartMin
    property int chartMax: Plasmoid.configuration.chartMax

    property int usedChartMin: chartMin
    property int usedChartMax: chartMax

    property string glucose: "???"
    property string trend: "???"

    property var valueSources: []
    property var labelSources: []

    compactRepresentation: CompactRepresentation {}
    fullRepresentation: FullRepresentation {
        Layout.minimumWidth: 650
        Layout.minimumHeight: 420
    }

    // Check if the configuration was adapted completely and try to fetch data.
    function configChanged() {
        if (!Utils.isConfigDefault()) {
            Plasmoid.configurationRequired = false;
            textTimer.running = true
            readData();
        }
    }

    onNightscoutURLChanged: configChanged()
    onNightscoutTokenChanged: configChanged()
    onShowUnitsChanged: configChanged()
    onChartMinChanged: configChanged()
    onChartMaxChanged: configChanged()

    // Start the timer to refresh data!
    Timer {
        id: textTimer
        interval: updateInterval * 60 * 1000
        repeat: true
        running: false
        triggeredOnStart: false
        onTriggered: readData()
    }

    // Read the data from NightScout using the provided configuration.
    function readData() {

        if (Utils.isConfigDefault()) {
            return;
        }

        // get current glucose and trend
        Utils.sendJsonRequest(nightscoutURL + "/pebble/?token=" + nightscoutToken, function (response) {
            if (response.status == 200) {
                var j = response.content;
                var bgs = j.bgs[0];

                glucose = bgs.sgv;
                if (showUnits) {
                    glucose += " mg/dl";
                }

                trend = trendArrows[bgs.trend];
            } else {
                glucose = "ERR";
                trend = response.status;
            }
        });

        // get last 3 hours' data for the chart
        Utils.sendJsonRequest(nightscoutURL + "/api/v1/entries.json?count=37&token=" + nightscoutToken, function (response) {
            if (response.status == 200) {
                var j = response.content;

                var valArray = [];
                var labelArray = [];

                var i = 0;

                for (let entry of j.reverse()) {
                    valArray.push(entry.sgv);

                    var date = new Date(entry.created_at);
                    var paddedMinute = Utils.padTo2Digits(date.getMinutes());

                    if (i++ % 4 == 0) {
                        var paddedHour = Utils.padTo2Digits(date.getHours());
                        labelArray.push(paddedHour + ":" + paddedMinute);
                    } else {
                        labelArray.push("");
                    }
                }

                labelSources = labelArray;
                valueSources = valArray;

                // dynamically scale the chart if we are out of bounds!
                if (Math.max(...valArray) > chartMax) {
                    usedChartMax = Math.max(...valArray);
                } else {
                    usedChartMax = chartMax;
                }

                if (Math.min(...valArray) < chartMin) {
                    usedChartMin = Math.min(...valArray);
                } else {
                    usedChartMin = chartMin;
                }
            }
        });
    }
}
