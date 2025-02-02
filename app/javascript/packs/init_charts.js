import updateCharts from "./update_charts";
import updateElectricFields from "./update_electric_fields";

export default function initCharts() {
    const elemTestId = document.getElementById("test_id")
    fetch(`http://localhost:3000/examinations/data?test_id=${17}`, {method: "GET"})
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            setTimeout(() => {
                console.log("data from ", `http://localhost:3000/examinations/data?test_id=${17}`)
                console.log(data)
                updateCharts(data.dataPoints)
                updateElectricFields(data.averageValues)
            }, 1)
        });
}