async function fetchStatus() {
    try {
        const response = await fetch("https://statusboard-tsxx.onrender.com/status");
        const data = await response.json();
        const list = document.getElementById("status-list");
        list.innerHTML = "";
        for (const [site, status] of Object.entries(data)) {
            const li = document.createElement("li");
            li.textContent = `${site}: ${status}`;
            list.appendChild(li);
        }
    } catch (err) {
        console.error(err);
    }
}

fetchStatus();
setInterval(fetchStatus, 10000);
