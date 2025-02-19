document.addEventListener("DOMContentLoaded", function () {
    const tdeeValue = parseFloat(document.getElementById("tdeeValue").textContent);

    // Controleer of TDEE geldig is
    if (isNaN(tdeeValue) || tdeeValue <= 0) {
        console.error("Ongeldige TDEE waarde:", tdeeValue);
        return;
    }

    // Activiteitsniveaus met correcte factoren
    const activityLevels = [
        { label: "Weinig actief", factor: 1.2 },
        { label: "Licht actief", factor: 1.375 },
        { label: "Gemiddeld actief", factor: 1.55 },
        { label: "Zeer actief", factor: 1.725 },
        { label: "Extreem actief", factor: 1.9 }
    ];

    // Bereken TDEE voor elk activiteitsniveau
    const tdeeValues = activityLevels.map(level => tdeeValue * (level.factor / 1.2));

    console.log("TDEE-waarden:", tdeeValues); // Controleer of waarden correct worden berekend

    // Controleer of er al een bestaande grafiek is en vernietig deze
    if (window.tdeeChartInstance) {
        window.tdeeChartInstance.destroy();
    }

    // Maak een nieuwe grafiek
    const ctx = document.getElementById("tdeeChart").getContext("2d");
    window.tdeeChartInstance = new Chart(ctx, {
        type: "bar",
        data: {
            labels: activityLevels.map(level => level.label),
            datasets: [{
                label: "TDEE (kcal)",
                data: tdeeValues,
                backgroundColor: "rgba(75, 192, 192, 0.6)",
                borderColor: "rgba(75, 192, 192, 1)",
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    suggestedMax: Math.max(...tdeeValues) + 200 // Zorgt dat de schaal niet verkeerd is
                }
            }
        }
    });
});
