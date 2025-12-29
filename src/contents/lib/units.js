const Unit = {
    MG_DL: 0,
    MMOL_L: 1
}

function getUnitAwareValue(mgPDl, unit) {
    if (unit == Unit.MG_DL) {
        return mgPDl;
    } else if (unit == Unit.MMOL_L) {
        return (mgPDl / 18).toFixed(2);
    }
}

function getUnitText(unit) {
    if (unit == Unit.MG_DL) {
        return "mg/dl";
    } else if (unit == Unit.MMOL_L) {
        return "mmol/l";
    }
}
