import QtQuick

import org.kde.plasma.configuration

ConfigModel {
    id: configModel
    ConfigCategory {
        name: i18n("General")
        icon: "configure"
        source: "configGeneral.qml"
    }
}
