import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kcmutils as KCMUtils
import org.kde.kirigami as Kirigami

import "../lib/units.js" as Units


KCMUtils.SimpleKCM {
    id: page

    property string cfg_nightscoutURLDefault: "https://appname.herokuapp.com"
    property string cfg_nightscoutTokenDefault: "plasmoid-0000000"
    property int cfg_updateIntervalDefault: 5
    property int cfg_unitsDefault: 0
    property bool cfg_showUnitsDefault: true

    property alias cfg_nightscoutURL: nightscoutURL.text
    property alias cfg_nightscoutToken: nightscoutToken.text
    property alias cfg_updateInterval: updateInterval.value
    property alias cfg_units: page.units
    property alias cfg_showUnits: showUnits.checked
    property alias cfg_chartMin: chartMin.text
    property alias cfg_chartMax: chartMax.text

    property int units: 0

    Kirigami.FormLayout {

        QQC2.TextField {
            id: nightscoutURL
            Kirigami.FormData.label: i18n("Nightscout URL")
        }
        QQC2.TextField {
            id: nightscoutToken
            Kirigami.FormData.label: i18n("Nightscout API token")
        }
        QQC2.SpinBox {
            id: updateInterval
            Kirigami.FormData.label: i18n("Update Interval (minutes)")
        }
        QQC2.ComboBox {
            id: comboBox
            Kirigami.FormData.label: i18n("Units")
            textRole: "text"
            model: [
                {
                    text: i18n(Units.getUnitText(Units.Unit.MG_DL)),
                    value: Units.Unit.MG_DL
                },
                {
                    text: i18n(Units.getUnitText(Units.Unit.MMOL_L)),
                    value: Units.Unit.MMOL_L
                }
            ]
            onActivated: index => page.units = comboBox.model[index].value
        }
        QQC2.CheckBox {
            id: showUnits
            Kirigami.FormData.label: i18n("Show Units")
        }
        QQC2.TextField {
            id: chartMin
            Kirigami.FormData.label: i18n("Chart Minimum")
        }
        QQC2.TextField {
            id: chartMax
            Kirigami.FormData.label: i18n("Chart Maximum")
        }
    }
}
