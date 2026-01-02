const Charset = {
    UNICODE_1: 0,
    UNICODE_2: 1,
    EMOJI: 2
}

// var DIRECTIONS = {
// NONE: 0
// , DoubleUp: 1
// , SingleUp: 2
// , FortyFiveUp: 3
// , Flat: 4
// , FortyFiveDown: 5
// , SingleDown: 6
// , DoubleDown: 7
// , 'NOT COMPUTABLE': 8
// , 'RATE OUT OF RANGE': 9
// };
const trendArrows = {
    0: ["", "⇈", "↑", "↗", "→", "↘", "↓", "⇊", "?", "↹"],
    1: ["", "⬆⬆", "⬆", "⬈", "➡", "⬊", "⬇", "⬇⬇", "?", "⬌"],
    2: ["", "⬆️⬆️", "⬆️", "↗️", "➡️", "↘️", "⬇️", "⬇️⬇️", "↔️", "🔄"],
}

function getTrendArrow(charset, trend) {
    return trendArrows[charset][trend];
}

function getCharsetText(charset) {
    if (charset == Charset.UNICODE_1) {
        return "Unicode 1 (" + trendArrows[Charset.UNICODE_1][3] + ")";
    } else if (charset == Charset.UNICODE_2) {
        return "Unicode 2 (" + trendArrows[Charset.UNICODE_2][3] + ")";
    } else if (charset == Charset.EMOJI) {
        return "Emoji (" + trendArrows[Charset.EMOJI][3] + ")";
    }
}
