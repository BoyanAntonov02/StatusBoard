const STATUS_URL = "https://statusboard-tsxx.onrender.com/status";

async function fetchStatus() {
    const ul = document.getElementById("status-list");
    ul.innerHTML = "";

    try {
        const res = await fetch(STATUS_URL);
        const data = await res.json();

        for (const [site, status] of Object.entries(data)) {
            const li = document.createElement("li");
            li.textContent = `${site}: ${status}`;
            ul.appendChild(li);
        }
    } catch (err) {
        const li = document.createElement("li");
        li.textContent = `Error fetching status: ${err}`;
        ul.appendChild(li);
    }
}

fetchStatus();
setInterval(fetchStatus, 10000);
