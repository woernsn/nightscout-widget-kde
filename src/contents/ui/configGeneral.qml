import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kcmutils as KCMUtils
import org.kde.kirigami as Kirigami

import "../lib/charsets.js" as Charsets
import "../lib/units.js" as Units

KCMUtils.SimpleKCM {
    id: page

    property string cfg_nightscoutURLDefault: "https://appname.herokuapp.com"
    property string cfg_nightscoutTokenDefault: "plasmoid-0000000"
    property int cfg_charsetDefault: 0
    property int cfg_updateIntervalDefault: 5
    property int cfg_unitsDefault: 0
    property bool cfg_showUnitsDefault: true
    property int cfg_chartMinDefault: 50
    property int cfg_chartMaxDefault: 300

    property alias cfg_nightscoutURL: nightscoutURL.text
    property alias cfg_nightscoutToken: nightscoutToken.text
    property alias cfg_charset: charset.currentIndex
    property alias cfg_updateInterval: updateInterval.value
    property alias cfg_units: units.currentIndex
    property alias cfg_showUnits: showUnits.checked
    property alias cfg_chartMin: chartMin.text
    property alias cfg_chartMax: chartMax.text

    Kirigami.FormLayout {

        QQC2.TextField {
            id: nightscoutURL
            Kirigami.FormData.label: i18n("Nightscout URL")
        }
        QQC2.TextField {
            id: nightscoutToken
            Kirigami.FormData.label: i18n("Nightscout API token")
        }
        QQC2.ComboBox {
            id: charset
            Kirigami.FormData.label: i18n("Charset")
            model: [
                i18n(Charsets.getCharsetText(Charsets.Charset.UNICODE_1)),
                i18n(Charsets.getCharsetText(Charsets.Charset.UNICODE_2)),
                i18n(Charsets.getCharsetText(Charsets.Charset.EMOJI))
            ]
        }
        QQC2.SpinBox {
            id: updateInterval
            Kirigami.FormData.label: i18n("Update Interval (minutes)")
        }
        QQC2.ComboBox {
            id: units
            Kirigami.FormData.label: i18n("Units")
            model: [
                i18n(Units.getUnitText(Units.Unit.MG_DL)),
                i18n(Units.getUnitText(Units.Unit.MMOL_L))
            ]
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
