export default function updateElectricFields(data) {
    const voltElem = document.getElementById("test_mid_voltage")
    const currElem = document.getElementById("test_mid_current")
    const freqElem = document.getElementById("test_mid_frequency")
    const powerElem = document.getElementById("test_mid_power")
    const energyElem = document.getElementById("test_total_energy")

    voltElem.value = Number(data[0]).toFixed(2)
    currElem.value = Number(data[1]).toFixed(2)
    freqElem.value = Number(data[2]).toFixed(2)
    powerElem.value = Number(data[3]).toFixed(3)
    energyElem.value = Number(data[4]).toFixed(3)
}