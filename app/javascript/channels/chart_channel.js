import consumer from "channels/consumer"
import updateCharts from '../packs/update_charts'
import updateElectricFields from "../packs/update_electric_fields";

consumer.subscriptions.create({ channel: "ChartChannel", chart_id: "1" }, {
  connected() {
    // Called when the subscription is ready for use on the server

    console.log("subscription is ready for use on the server")

  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnect")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    updateCharts(data.dataPoints);
    updateElectricFields(data.averageValues)

    console.log("chart_channel", data)
  }
});

