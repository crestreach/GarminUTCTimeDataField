import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Application.Properties;

class UTCTimeDataFieldView extends WatchUi.SimpleDataField {

    var displaySecs as Boolean = true;
    var lastPropsReloadTime as Time.Moment = Time.now();
    var initialized as Boolean = false;

    function initialize() {
        SimpleDataField.initialize();
        loadProps();
        label = WatchUi.loadResource(Rez.Strings.label);
        initialized = true;
    }

    function compute(info) {
        if (!initialized || lastPropsReloadTime.add(new Time.Duration(10)).compare(Time.now()) < 0) {
            // refresh properties every 10 seconds
            loadProps();
        }

        var moment = Time.now();
        var utcInfo = Gregorian.utcInfo(moment, Time.FORMAT_SHORT);

        // Format the time
        var hours = utcInfo.hour.format("%02d");
        var mins  = utcInfo.min.format("%02d");
        var timeText = hours + ":" + mins;
        if (displaySecs) {
            var secs  = utcInfo.sec.format("%02d");
            timeText = timeText + ":" + secs;
        }

        return " " + timeText + " ";
    }

    private function loadProps() as Void {
        var displaySecsValue = Properties.getValue("displaySecs");
        if (displaySecsValue != null && displaySecsValue instanceof Boolean) {
            displaySecs = displaySecsValue as Boolean;
        } else {
            displaySecs = true;
        }

        lastPropsReloadTime = Time.now();
    }

}