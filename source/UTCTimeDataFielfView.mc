import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Application.Properties;

class UTCTimeDataFieldView extends WatchUi.SimpleDataField {

    var displaySecs as Boolean = true;
    var lastPropsReloadTime;

    function initialize() {
        SimpleDataField.initialize();
        loadProps();
        label = loadResource(Rez.Strings.label);
    }

    function compute(info) {
        if (lastPropsReloadTime.add(new Time.Duration(10)).compare(Time.now()) < 0) {
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
        displaySecs = Properties.getValue("displaySecs");

        lastPropsReloadTime = Time.now();
    }

}