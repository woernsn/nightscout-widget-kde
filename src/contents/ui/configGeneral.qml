import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kcmutils as KCMUtils
import org.kde.kirigami as Kirigami

KCMUtils.SimpleKCM {
    id: page

    property alias cfg_nightscoutURL: nightscoutURL.text
    property alias cfg_nightscoutToken: nightscoutToken.text
    property alias cfg_updateInterval: updateInterval.value
    property alias cfg_showUnits: showUnits.checked
    
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
        QQC2.CheckBox {
            id: showUnits
            Kirigami.FormData.label: i18n("Show Units")
        }
    }
}
