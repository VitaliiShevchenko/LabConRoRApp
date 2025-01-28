export default function updateCharts(data) {
    console.log("vhod")
    const fields = {
        torque: 0,
        speed: 1,
        mold_temp: 2,
        material_temp: 3,
        voltage: 4,
        current: 5,
        frequency: 6,
        power: 7,
        energy: 8,
        alarm: 9}
    let chart = window.chart;
    if (chart === undefined) return

    chart.data.labels = data[10]
    for(let key in fields){
        chart.data.datasets[fields[key]].data = data[fields[key]]
    }
    chart.update();
    console.log("chart must updated")
}