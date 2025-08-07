import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
    connect() {
        const time_trial = document.getElementById("test_total_time")
        let ctx = document.getElementById('myChart').getContext('2d');
        window.chart = new Chart(ctx, {
            type: 'line', // You can use different types of charts
            data: {
                labels: [0, 1, 2, 3, 4], // Sample x-axis labels
                datasets: [
                    {
                       label: 'Torque,Nm',
                       data: [0], // Initial data
                       borderColor: 'rgba(75, 192, 192, 1)',
                       fill: false,
                       tension: 0.4 // Smooths the curve
                    },
                    {
                        label: 'Speed,min-1',
                        data: [100], // Initial data
                        borderColor: 'rgba(75, 0, 192, 1)',
                        fill: false,
                    },
                    {
                        label: 'MoldTemp,C',
                        data: [185], // Initial data
                        borderColor: 'rgba(100, 0, 0, 1)',
                        fill: false,
                    },
                    {
                        label: 'MatTemp,C',
                        data: [185], // Initial data
                        borderColor: 'rgba(200, 0, 0, 1)',
                        fill: false,
                    },
                    {
                        label: 'Voltage,V',
                        data: [220], // Initial data
                        borderColor: 'rgba(200, 100, 0, 1)',
                        fill: false,
                    },
                    {
                        label: 'Current,A',
                        data: [0], // Initial data
                        borderColor: 'rgba(200, 0, 0, 1)',
                        fill: false,
                    },
                    {
                        label: 'Frequency,Hz',
                        data: [50], // Initial data
                        borderColor: 'rgba(0, 0, 255, 1)',
                        fill: false,
                    },
                    {
                        label: 'Power,W',
                        data: [0], // Initial data
                        borderColor: 'rgba(200, 0, 200, 1)',
                        fill: false,
                    },
                    {
                        label: 'Energy,Wh',
                        data: [0], // Initial data
                        borderColor: 'rgba(100, 0, 255, 1)',
                        fill: false,
                    },
                    {
                        label: 'Alarm',
                        data: [0], // Initial data
                        borderColor: 'rgba(255, 100, 100, 1)',
                        fill: false,
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    x: {
                        type: 'linear',
                        position: 'bottom'
                    },
                    y: {
                        beginAtZero: true
                    }
                },
                elements: {
                    line: {
                        cubicInterpolationMode: 'monotone',
                        stepped: false
                    }
                }

            }
        });
        this.channel = consumer.subscriptions.create(
            { channel: "ChartChannel", chart_id: 1 },
            {
                received: data => this.updateChart(data)
            }
        )
    }

    disconnect() {
        if (this.channel) {
            this.channel.unsubscribe()
        }
    }

    updateChart(data) {
        console.log("Updating chart with:", data);
        // Update your chart here (e.g., Chart.js update logic)
    }

    received(data) {
        console.log("chart_controller",data)
    }
}
