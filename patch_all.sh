#!/bin/bash

cd /app/keep_in_rent/v1.9/

# index.html patch
cat << 'IN_EOF' > /tmp/index_patch.js
const fs = require('fs');
const filePath = 'index.html';
let content = fs.readFileSync(filePath, 'utf8');

content = content.replace(
`<div id="setup-modal" class="modal hidden">
        <div class="modal-content">
            <h3>📍 Identificación del Activo</h3>
            <form id="setup-form">
                <input type="text" name="direccion" id="input-dir" placeholder="Dirección" required>
                <input type="text" name="cp" id="input-cp" placeholder="Código Postal" required>
                <button type="submit" class="btn-primary" style="width:100%">Acceder al Activo</button>
                <button type="button" id="close-setup" class="btn-secondary hidden" style="width:100%; margin-top:5px;">Cancelar</button>
            </form>
        </div>
    </div>`,
`<!-- Login Modal -->
    <div id="login-modal" class="modal hidden">
        <div class="modal-content">
            <h3>🔐 Acceso a Keep in Rent</h3>
            <form id="login-form">
                <input type="email" name="email" id="login-email" placeholder="Email" required>
                <input type="password" name="password" id="login-password" placeholder="Contraseña" required>
                <button type="submit" class="btn-primary" style="width:100%">Iniciar Sesión</button>
            </form>
        </div>
    </div>

    <div id="setup-modal" class="modal hidden" style="display: none;">
        <div class="modal-content">
            <h3>📍 Registrar Nueva Propiedad</h3>
            <form id="setup-form">
                <input type="text" name="calle" id="input-calle" placeholder="Calle" required>
                <input type="text" name="cp" id="input-cp" placeholder="Código Postal" required>
                <input type="text" name="ciudad" id="input-ciudad" placeholder="Ciudad" required>
                <input type="text" name="pais" id="input-pais" placeholder="País" required>
                <button type="submit" class="btn-primary" style="width:100%">Guardar Activo</button>
                <button type="button" id="close-setup" class="btn-secondary hidden" style="width:100%; margin-top:5px;">Cancelar</button>
            </form>
        </div>
    </div>`
);

content = content.replace(
`<header class="main-header">
        <div class="header-info">
            <h1 style="font-size: 1.2rem;">📊 Madrid Rental BI</h1>
            <span id="display-address">Cargando...</span>
        </div>`,
`<header class="main-header">
        <div class="header-info" style="display:flex; align-items: center; justify-content: space-between; margin-bottom: 0.8rem;">
            <h1 style="font-size: 1.2rem;">📊 Keep in Rent</h1>
            <div style="display:flex; gap:10px; align-items:center;">
                <span id="display-address" style="display:none;"></span>
                <select id="property-selector" style="padding: 5px; border-radius: 4px; background: white; color: var(--primary); border: none;">
                    <option value="">Seleccionar Propiedad...</option>
                </select>
                <button id="btn-add-property" class="btn-primary" style="padding: 5px 10px; font-size: 0.8rem;">+ Propiedad</button>
                <button id="btn-logout" class="btn-secondary" style="padding: 5px 10px; font-size: 0.8rem; background: var(--danger); border: none; color: white;">Salir</button>
            </div>
        </div>`
);

content = content.replace(
`            <div class="tab-filter-row">
                <span>Periodo Gráfico:</span>
                <input type="date" id="f-dashboard-start"> a <input type="date" id="f-dashboard-end">
                <small style="margin-left:auto">💡 Haz clic en los nombres abajo en la gráfica para ocultar/mostrar.</small>
            </div> `,
`            <div class="tab-filter-row">
                <span>Periodo Gráfico:</span>
                <input type="date" id="f-dashboard-start"> a <input type="date" id="f-dashboard-end">

                <div style="display:flex; gap: 5px; margin-left: 10px;">
                    <button id="btn-30days" class="btn-secondary" style="font-size:0.75rem; padding:4px 8px;">Últimos 30 días</button>
                    <button id="btn-lastmonth" class="btn-secondary" style="font-size:0.75rem; padding:4px 8px;">Mes Pasado</button>
                    <button id="btn-thisyear" class="btn-secondary" style="font-size:0.75rem; padding:4px 8px;">Este Año</button>
                </div>

                <select id="chart-type" style="margin-left:auto; padding:4px;">
                    <option value="bar">Gráfico: Barras</option>
                    <option value="line">Gráfico: Líneas</option>
                </select>

                <small style="margin-left:10px">💡 Haz clic en los nombres abajo en la gráfica para ocultar/mostrar.</small>
            </div> `
);

content = content.replace(
`        <section id="view-bank" class="app-view">
            <div class="header-inline">
                <h2>Bancos: Conciliación</h2>
                <div class="tab-filter-row" style="margin:0">
                    <input type="date" id="f-bank-start"> a <input type="date" id="f-bank-end">
                </div>
            </div> `,
`        <section id="view-bank" class="app-view">
            <div class="header-inline">
                <h2>Bancos: Conciliación</h2>
                <div class="tab-filter-row" style="margin:0">
                    <input type="date" id="f-bank-start"> a <input type="date" id="f-bank-end">
                    <select id="f-bank-year" style="margin-left:10px;">
                        <option value="">Cualquier Año</option>
                        <option value="2025">2025</option>
                        <option value="2024">2024</option>
                        <option value="2023">2023</option>
                    </select>
                    <select id="f-bank-platform" style="margin-left:10px;">
                        <option value="">Cualquier Canal</option>
                        <option value="Booking">Booking</option>
                        <option value="Airbnb">Airbnb</option>
                        <option value="Directo">Directo</option>
                    </select>
                </div>
            </div> `
);

content = content.replace(
`<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> `,
`<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>`
);

content = content.replace(
`            <button class="nav-btn" data-target="view-market">Mercado</button> `,
`            <button class="nav-btn" data-target="view-market">Comparativa</button> `
);

content = content.replace(
`        <section id="view-market" class="app-view">
            <h2>Métricas de Mercado</h2>
            <div class="card-grid" id="market-cards-container"></div>
            <div class="card" style="margin-top:20px; text-align:center;">
                <p id="market-status-box">Cargando datos del activo...</p>
            </div>
        </section> `,
`        <section id="view-market" class="app-view">
            <h2>Comparativa de Mercado</h2>
            <div class="card-grid" id="market-cards-container" style="grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); margin-bottom: 20px;"></div>

            <div class="card" style="padding: 0; overflow: hidden; position: relative;">
                <div style="padding: 15px; background: #f8fafc; border-bottom: 1px solid #e2e8f0; display:flex; justify-content:space-between; align-items:center;">
                    <h3 style="margin:0;">📍 Mapa de Competencia Local</h3>
                    <div style="font-size: 0.8rem; display:flex; gap: 10px;">
                        <span style="color: blue;">● Tu Propiedad</span>
                        <span style="color: red;">● Turístico</span>
                        <span style="color: orange;">● Temporal</span>
                        <span style="color: green;">● Permanente</span>
                    </div>
                </div>
                <div id="map" style="height: 400px; width: 100%;"></div>
            </div>
            <div class="card" style="margin-top:20px; text-align:center;">
                <p id="market-status-box">Cargando datos del activo...</p>
            </div>
        </section> `
);

content = content.replace(
`        <section id="view-analysis" class="app-view">
            <div class="header-inline">
                <h2>Análisis por Período</h2>
                <div class="tab-filter-row" style="margin:0">
                    <input type="date" id="f-analysis-start"> a <input type="date" id="f-analysis-end">
                    <select id="f-analysis-platform"><option value="">Canal...</option></select>
                    <select id="f-analysis-origin"><option value="">Origen...</option></select>
                </div>
            </div>

            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th class="sortable" onclick="setSort('analysis', 'month')">Mes ↕</th>
                            <th class="sortable" onclick="setSort('analysis', 'nights')">Noches ↕</th>
                            <th class="sortable" onclick="setSort('analysis', 'bruto')">Bruto ↕</th>
                            <th class="sortable" onclick="setSort('analysis', 'net')">Neto ↕</th>
                        </tr>
                    </thead>
                    <tbody id="stats-table-body"></tbody>
                </table>
            </div>

            <div class="card" style="margin-top:20px;">
                <h3>Explorador Cruzado</h3>
                <div class="form-row-3" style="margin: 10px 0;">
                    <select id="analysis-pivot-x"><option value="month">Mes</option><option value="origin">País Origen</option><option value="platform">Canal</option></select>
                    <select id="analysis-pivot-y"><option value="bruto">Ingreso Bruto</option><option value="net">Ingreso Neto</option><option value="count">Nº Reservas</option></select>
                </div>
                <table class="data-table">
                    <tbody id="cross-analysis-body"></tbody>
                </table>
            </div>
        </section> `,
`        <section id="view-analysis" class="app-view" style="display: flex;">
            <!-- Sidebar for Analysis Type -->
            <div style="width: 200px; background: white; border-right: 1px solid #e2e8f0; padding: 15px; display: flex; flex-direction: column; gap: 10px;">
                <button class="btn-primary" id="btn-show-matrix" style="text-align:left; background: var(--accent);">Matriz de Resultados</button>
                <button class="btn-secondary" id="btn-show-period" style="text-align:left; border: none;">Análisis por Período</button>
                <button class="btn-secondary" id="btn-show-cross" style="text-align:left; border: none;">Explorador Cruzado</button>
            </div>

            <!-- Main Content Area -->
            <div style="flex: 1; padding: 15px; overflow-x: auto;">

                <div class="tab-filter-row" style="margin-bottom:20px;">
                    <input type="date" id="f-analysis-start"> a <input type="date" id="f-analysis-end">
                    <select id="f-analysis-platform"><option value="">Canal...</option><option value="Booking">Booking</option><option value="Airbnb">Airbnb</option><option value="Directo">Directo</option></select>
                    <select id="f-analysis-origin"><option value="">Origen...</option></select>
                </div>

                <!-- View: Matriz -->
                <div id="analysis-v-matrix">
                    <h2>Matriz de Resultados</h2>
                    <div style="margin-bottom: 10px;">
                        <label>Seleccionar Variables (Y): </label>
                        <select id="matrix-var-select" multiple style="height: 100px; width: 250px;">
                            <option value="res_count" selected>Nº Reservas</option>
                            <option value="nights" selected>Noches Ocupación</option>
                            <option value="bruto" selected>Ingreso Bruto</option>
                            <option value="net" selected>Ingreso Neto</option>
                            <option value="expenses" selected>Gastos Totales</option>
                            <option value="comisiones" selected>Comisiones (Canal + THL)</option>
                        </select>
                        <small>Presiona Ctrl/Cmd para seleccionar varias.</small>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead id="matrix-head"></thead>
                            <tbody id="matrix-body"></tbody>
                        </table>
                    </div>
                </div>

                <!-- View: Periodo -->
                <div id="analysis-v-period" class="hidden">
                    <h2>Análisis por Período</h2>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th class="sortable" onclick="setSort('analysis', 'month')">Mes ↕</th>
                                    <th class="sortable" onclick="setSort('analysis', 'nights')">Noches ↕</th>
                                    <th class="sortable" onclick="setSort('analysis', 'bruto')">Bruto ↕</th>
                                    <th class="sortable" onclick="setSort('analysis', 'net')">Neto ↕</th>
                                </tr>
                            </thead>
                            <tbody id="stats-table-body"></tbody>
                        </table>
                    </div>
                </div>

                <!-- View: Cruzado -->
                <div id="analysis-v-cross" class="hidden">
                    <h2>Explorador Cruzado</h2>
                    <div class="form-row-3" style="margin: 10px 0;">
                        <select id="analysis-pivot-x"><option value="month">Mes</option><option value="origin">País Origen</option><option value="platform">Canal</option></select>
                        <select id="analysis-pivot-y"><option value="bruto">Ingreso Bruto</option><option value="net">Ingreso Neto</option><option value="count">Nº Reservas</option></select>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <tbody id="cross-analysis-body"></tbody>
                        </table>
                    </div>
                </div>

            </div>
        </section> `
);

fs.writeFileSync(filePath, content);
IN_EOF

node /tmp/index_patch.js


# app.js patch
cat << 'IN_EOF' > /tmp/app_patch.js
const fs = require('fs');
const filePath = 'app.js';
let content = fs.readFileSync(filePath, 'utf8');

content = content.replace(
`    constructor() {
        this.currentActiveId = localStorage.getItem('last_active_id') || null;
        this.config = null;
        this.bookings = [];
        this.expenses = [];
        this.bankRecords = [];
        this.filters = {
            dashboard: { start: '2025-01-01', end: '2025-12-31' },
            bookings: { start: '2025-01-01', end: '2025-12-31', platform: '', origin: '' },
            expenses: { start: '2025-01-01', end: '2025-12-31', type: '' },
            analysis: { start: '2025-01-01', end: '2025-12-31', platform: '', origin: '' },
            bank: { start: '2025-01-01', end: '2025-12-31' }
        };
        if(this.currentActiveId) this.loadActiveData(this.currentActiveId);
    } `,
`    constructor() {
        this.currentUser = localStorage.getItem('keepinrent_user') || null;
        this.currentActiveId = localStorage.getItem('last_active_id') || null;
        this.properties = JSON.parse(localStorage.getItem('keepinrent_properties')) || [];
        this.config = null;
        this.bookings = [];
        this.expenses = [];
        this.bankRecords = [];
        this.filters = {
            dashboard: { start: '2025-01-01', end: '2025-12-31' },
            bookings: { start: '2025-01-01', end: '2025-12-31', platform: '', origin: '' },
            expenses: { start: '2025-01-01', end: '2025-12-31', type: '' },
            analysis: { start: '2025-01-01', end: '2025-12-31', platform: '', origin: '' },
            bank: { start: '2025-01-01', end: '2025-12-31', year: '', platform: '' }
        };
        if(this.currentActiveId && this.currentUser) this.loadActiveData(this.currentActiveId);
    }

    login(email) {
        this.currentUser = email;
        localStorage.setItem('keepinrent_user', email);
    }

    logout() {
        this.currentUser = null;
        this.currentActiveId = null;
        this.config = null;
        localStorage.removeItem('keepinrent_user');
        localStorage.removeItem('last_active_id');
    }

    addProperty(data) {
        const id = btoa(data.calle + data.cp);
        const prop = { id, owner: this.currentUser, ...data };

        if (!this.properties.find(p => p.id === id)) {
            this.properties.push(prop);
            localStorage.setItem('keepinrent_properties', JSON.stringify(this.properties));
        }

        this.loadActiveData(id);
        this.config = prop;
        this.save();
    }`
);

content = content.replace(
`        // Eventos de filtros
        ['dashboard','bookings','expenses','analysis','bank'].forEach(v => { `,
`        // Botones rápidos Dashboard
        document.getElementById('btn-30days').onclick = () => {
            const end = new Date();
            const start = new Date();
            start.setDate(end.getDate() - 30);
            this.state.filters.dashboard.start = start.toISOString().split('T')[0];
            this.state.filters.dashboard.end = end.toISOString().split('T')[0];
            document.getElementById('f-dashboard-start').value = this.state.filters.dashboard.start;
            document.getElementById('f-dashboard-end').value = this.state.filters.dashboard.end;
            this.renderDashboard();
        };

        document.getElementById('btn-lastmonth').onclick = () => {
            const date = new Date();
            const start = new Date(date.getFullYear(), date.getMonth() - 1, 1);
            const end = new Date(date.getFullYear(), date.getMonth(), 0);
            this.state.filters.dashboard.start = start.toISOString().split('T')[0];
            this.state.filters.dashboard.end = end.toISOString().split('T')[0];
            document.getElementById('f-dashboard-start').value = this.state.filters.dashboard.start;
            document.getElementById('f-dashboard-end').value = this.state.filters.dashboard.end;
            this.renderDashboard();
        };

        document.getElementById('btn-thisyear').onclick = () => {
            const year = new Date().getFullYear();
            this.state.filters.dashboard.start = year + '-01-01';
            this.state.filters.dashboard.end = year + '-12-31';
            document.getElementById('f-dashboard-start').value = this.state.filters.dashboard.start;
            document.getElementById('f-dashboard-end').value = this.state.filters.dashboard.end;
            this.renderDashboard();
        };

        document.getElementById('chart-type').onchange = () => {
            this.renderDashboard();
        };

        // Eventos de filtros
        ['dashboard','bookings','expenses','analysis','bank'].forEach(v => { `
);

content = content.replace(
`        document.getElementById('f-bookings-origin').onchange = (e) => { this.state.filters.bookings.origin = e.target.value; this.renderAll(); };
        document.getElementById('f-expenses-type').onchange = (e) => { this.state.filters.expenses.type = e.target.value; this.renderAll(); }; `,
`        document.getElementById('f-bookings-origin').onchange = (e) => { this.state.filters.bookings.origin = e.target.value; this.renderAll(); };
        document.getElementById('f-expenses-type').onchange = (e) => { this.state.filters.expenses.type = e.target.value; this.renderAll(); };
        document.getElementById('f-bank-year').onchange = (e) => { this.state.filters.bank.year = e.target.value; this.renderAll(); };
        document.getElementById('f-bank-platform').onchange = (e) => { this.state.filters.bank.platform = e.target.value; this.renderAll(); }; `
);

content = content.replace(
`        document.getElementById('setup-form').onsubmit = (e) => {
            e.preventDefault();
            const d = Object.fromEntries(new FormData(e.target));
            this.state.loadActiveData(btoa(d.direccion));
            this.state.config = d;
            this.state.save();
            location.reload();
        }; `,
`        document.getElementById('login-form').onsubmit = (e) => {
            e.preventDefault();
            const email = document.getElementById('login-email').value;
            this.state.login(email);
            const lm = document.getElementById('login-modal');
            lm.classList.add('hidden');
            lm.style.display = 'none';
            this.renderAll();
        };

        document.getElementById('btn-logout').onclick = () => {
            this.state.logout();
            location.reload();
        };

        document.getElementById('btn-add-property').onclick = () => {
            const sm = document.getElementById('setup-modal');
            sm.classList.remove('hidden');
            sm.style.display = 'flex';
            document.getElementById('close-setup').classList.remove('hidden');
        };

        document.getElementById('close-setup').onclick = () => {
            const sm = document.getElementById('setup-modal');
            sm.classList.add('hidden');
            sm.style.display = 'none';
        };

        document.getElementById('property-selector').onchange = (e) => {
            if(e.target.value) {
                this.state.loadActiveData(e.target.value);
                this.renderAll();
            }
        };

        document.getElementById('setup-form').onsubmit = (e) => {
            e.preventDefault();
            const d = Object.fromEntries(new FormData(e.target));
            this.state.addProperty(d);
            const sm = document.getElementById('setup-modal');
            sm.classList.add('hidden');
            sm.style.display = 'none';
            this.renderAll();
        }; `
);

content = content.replace(
`        document.getElementById('analysis-pivot-x').onchange = () => this.renderAnalysis();
        document.getElementById('analysis-pivot-y').onchange = () => this.renderAnalysis(); `,
`        document.getElementById('analysis-pivot-x').onchange = () => this.renderAnalysis();
        document.getElementById('analysis-pivot-y').onchange = () => this.renderAnalysis();

        document.getElementById('matrix-var-select').onchange = () => this.renderAnalysis();

        document.getElementById('btn-show-matrix').onclick = (e) => {
            ['matrix', 'period', 'cross'].forEach(v => {
                document.getElementById('analysis-v-' + v).classList.add('hidden');
                document.getElementById('btn-show-' + v).classList.remove('btn-primary');
                document.getElementById('btn-show-' + v).classList.add('btn-secondary');
                document.getElementById('btn-show-' + v).style.background = '';
            });
            document.getElementById('analysis-v-matrix').classList.remove('hidden');
            e.target.classList.add('btn-primary');
            e.target.classList.remove('btn-secondary');
            e.target.style.background = 'var(--accent)';
        };

        document.getElementById('btn-show-period').onclick = (e) => {
            ['matrix', 'period', 'cross'].forEach(v => {
                document.getElementById('analysis-v-' + v).classList.add('hidden');
                document.getElementById('btn-show-' + v).classList.remove('btn-primary');
                document.getElementById('btn-show-' + v).classList.add('btn-secondary');
                document.getElementById('btn-show-' + v).style.background = '';
            });
            document.getElementById('analysis-v-period').classList.remove('hidden');
            e.target.classList.add('btn-primary');
            e.target.classList.remove('btn-secondary');
            e.target.style.background = 'var(--accent)';
        };

        document.getElementById('btn-show-cross').onclick = (e) => {
            ['matrix', 'period', 'cross'].forEach(v => {
                document.getElementById('analysis-v-' + v).classList.add('hidden');
                document.getElementById('btn-show-' + v).classList.remove('btn-primary');
                document.getElementById('btn-show-' + v).classList.add('btn-secondary');
                document.getElementById('btn-show-' + v).style.background = '';
            });
            document.getElementById('analysis-v-cross').classList.remove('hidden');
            e.target.classList.add('btn-primary');
            e.target.classList.remove('btn-secondary');
            e.target.style.background = 'var(--accent)';
        };`
);


content = content.replace(
`                        // Infer category
                        let cat = 'Mantenimiento';
                        const text = fullObs.toLowerCase();
                        if(text.includes('luz') || text.includes('endesa') || text.includes('iberdrola')) cat = 'Luz';
                        else if(text.includes('gas') || text.includes('naturgy')) cat = 'Gas';
                        else if(text.includes('internet') || text.includes('wifi') || text.includes('digi') || text.includes('movistar')) cat = 'Internet';
                        else if(text.includes('comunidad') || text.includes('administracion')) cat = 'Comunidad';
                        else if(text.includes('ibi') || text.includes('suma') || text.includes('ayuntamiento')) cat = 'IBI';`,
`                        // Infer category
                        let cat = 'Mantenimiento';
                        const text = fullObs.toLowerCase();
                        if(text.includes('luz') || text.includes('endesa') || text.includes('iberdrola') || text.includes('electricidad') || text.includes('energia')) cat = 'Luz';
                        else if(text.includes('gas') || text.includes('naturgy') || text.includes('repsol')) cat = 'Gas';
                        else if(text.includes('internet') || text.includes('wifi') || text.includes('digi') || text.includes('movistar') || text.includes('vodafone') || text.includes('orange')) cat = 'Internet';
                        else if(text.includes('comunidad') || text.includes('administracion')) cat = 'Comunidad';
                        else if(text.includes('ibi') || text.includes('suma') || text.includes('ayuntamiento') || text.includes('hacienda') || text.includes('impuesto')) cat = 'Impuestos';
                        else if(text.includes('agua') || text.includes('canal')) cat = 'Agua';
                        else if(text.includes('seguro') || text.includes('mapfre') || text.includes('mutua')) cat = 'Seguro';`
);

content = content.replace(
`    renderAll() {
        if(!this.state.config) { document.getElementById('setup-modal').classList.remove('hidden'); return; }
        document.getElementById('display-address').innerText = this.state.config.direccion;
        this.renderDashboard();
        this.renderBookings();
        this.renderExpenses();
        this.renderAnalysis();
        this.renderBank();
    } `,
`    renderAll() {
        const loginModal = document.getElementById('login-modal');
        const setupModal = document.getElementById('setup-modal');

        if(!this.state.currentUser) {
            loginModal.classList.remove('hidden');
            loginModal.style.display = 'flex';
            setupModal.classList.add('hidden');
            setupModal.style.display = 'none';
            return;
        } else {
            loginModal.classList.add('hidden');
            loginModal.style.display = 'none';
        }

        const userProps = this.state.properties.filter(p => p.owner === this.state.currentUser);

        const sel = document.getElementById('property-selector');
        sel.innerHTML = '<option value="">Seleccionar Propiedad...</option>' +
            userProps.map(p => \`<option value="\${p.id}" \${p.id === this.state.currentActiveId ? 'selected' : ''}>\${p.calle}</option>\`).join('');

        if(!this.state.config || !this.state.currentActiveId) {
            if (userProps.length > 0) {
                this.state.loadActiveData(userProps[0].id);
                sel.value = userProps[0].id;
            } else {
                setupModal.classList.remove('hidden');
                setupModal.style.display = 'flex';
                document.getElementById('close-setup').classList.add('hidden');
                return;
            }
        }

        setupModal.classList.add('hidden');
        setupModal.style.display = 'none';
        const dispAddr = document.getElementById('display-address');
        if(dispAddr) dispAddr.innerText = this.state.config.calle + ', ' + this.state.config.ciudad;
        this.renderDashboard();
        this.renderBookings();
        this.renderExpenses();
        this.renderAnalysis();
        this.renderBank();
    } `
);

content = content.replace(
`    updateChart(bookings) {
        const ctx = document.getElementById('mainTimelineChart').getContext('2d');
        if(this.chart) this.chart.destroy();

        const dataSet = { bruto: new Array(12).fill(0), net: new Array(12).fill(0), clean: new Array(12).fill(0), fee: new Array(12).fill(0) };
        bookings.forEach(x => {
            const m = new Date(x.checkin).getMonth();
            dataSet.bruto[m] += parseFloat(x.bruto);
            dataSet.net[m] += parseFloat(x.net);
            dataSet.clean[m] += parseFloat(x.limpieza);
            dataSet.fee[m] += parseFloat(x.fee_banco) + parseFloat(x.fee_thl);
        });

        this.chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: MONTHS_ES,
                datasets: [
                    { label: 'Bruto', data: dataSet.bruto, backgroundColor: '#0ea5e9' },
                    { label: 'Neto', data: dataSet.net, backgroundColor: '#10b981' },
                    { label: 'Limpieza', data: dataSet.clean, backgroundColor: '#f59e0b', hidden: true },
                    { label: 'Comisiones', data: dataSet.fee, backgroundColor: '#f43f5e', hidden: true }
                ]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });
    } `,
`    updateChart(bookings, expenses) {
        const ctx = document.getElementById('mainTimelineChart').getContext('2d');
        if(this.chart) this.chart.destroy();

        const chartType = document.getElementById('chart-type').value;

        const dataSet = { bruto: new Array(12).fill(0), net: new Array(12).fill(0), clean: new Array(12).fill(0), fee: new Array(12).fill(0), expenses: new Array(12).fill(0) };
        bookings.forEach(x => {
            const m = new Date(x.checkin).getMonth();
            dataSet.bruto[m] += parseFloat(x.bruto);
            dataSet.net[m] += parseFloat(x.net);
            dataSet.clean[m] += parseFloat(x.limpieza);
            dataSet.fee[m] += parseFloat(x.fee_banco) + parseFloat(x.fee_thl);
        });

        expenses.forEach(x => {
            const m = new Date(x.date).getMonth();
            dataSet.expenses[m] += parseFloat(x.amount);
        });

        this.chart = new Chart(ctx, {
            type: chartType === 'line' ? 'line' : 'bar',
            data: {
                labels: MONTHS_ES,
                datasets: [
                    { label: 'Bruto', data: dataSet.bruto, backgroundColor: '#0ea5e9', borderColor: '#0ea5e9', tension: 0.1 },
                    { label: 'Neto', data: dataSet.net, backgroundColor: '#10b981', borderColor: '#10b981', tension: 0.1 },
                    { label: 'Limpieza', data: dataSet.clean, backgroundColor: '#f59e0b', borderColor: '#f59e0b', tension: 0.1, hidden: true },
                    { label: 'Comisiones', data: dataSet.fee, backgroundColor: '#f43f5e', borderColor: '#f43f5e', tension: 0.1, hidden: true },
                    { label: 'Gastos', data: dataSet.expenses, backgroundColor: '#64748b', borderColor: '#64748b', tension: 0.1, hidden: true }
                ]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });
    } `
);

content = content.replace(
`    renderDashboard() {
        const b = this.getFiltered('bookings', 'checkin', 'dashboard');
        const e = this.getFiltered('expenses', 'date', 'dashboard');
        const bruto = b.reduce((acc, x) => acc + parseFloat(x.bruto), 0);
        const gestion = b.reduce((acc, x) => acc + parseFloat(x.fee_banco||0) + parseFloat(x.fee_thl||0) + parseFloat(x.limpieza||0), 0);
        const prop = e.reduce((acc, x) => acc + parseFloat(x.amount), 0);

        document.getElementById('dash-bruto').innerText = bruto.toFixed(2) + '€';
        document.getElementById('dash-gestion').innerText = gestion.toFixed(2) + '€';
        document.getElementById('dash-propiedad').innerText = prop.toFixed(2) + '€';
        document.getElementById('dash-neto').innerText = (bruto - gestion - prop).toFixed(2) + '€';
        this.updateChart(b);
    } `,
`    renderDashboard() {
        const b = this.getFiltered('bookings', 'checkin', 'dashboard');
        const e = this.getFiltered('expenses', 'date', 'dashboard');
        const bruto = b.reduce((acc, x) => acc + parseFloat(x.bruto), 0);
        const gestion = b.reduce((acc, x) => acc + parseFloat(x.fee_banco||0) + parseFloat(x.fee_thl||0) + parseFloat(x.limpieza||0), 0);
        const prop = e.reduce((acc, x) => acc + parseFloat(x.amount), 0);

        document.getElementById('dash-bruto').innerText = bruto.toFixed(2) + '€';
        document.getElementById('dash-gestion').innerText = gestion.toFixed(2) + '€';
        document.getElementById('dash-propiedad').innerText = prop.toFixed(2) + '€';
        document.getElementById('dash-neto').innerText = (bruto - gestion - prop).toFixed(2) + '€';
        this.updateChart(b, e);
    } `
);

content = content.replace(
`    renderAnalysis() {
        const b = this.getFiltered('bookings', 'checkin', 'analysis');
        const months = {};
        b.forEach(x => {
            const m = x.checkin.substring(0,7);
            if(!months[m]) months[m] = { month: m, nights: 0, bruto: 0, net: 0 };
            months[m].nights += parseFloat(x.nights);
            months[m].bruto += parseFloat(x.bruto);
            months[m].net += parseFloat(x.net);
        });
        const data = this.sortData(Object.values(months), 'analysis');
        document.getElementById('stats-table-body').innerHTML = data.map(x => \`
            <tr><td>\${x.month}</td><td>\${x.nights}</td><td>\${x.bruto.toFixed(2)}€</td><td class="text-success">\${x.net.toFixed(2)}€</td></tr>
        \`).join('');

        // Explorador Cruzado
        const px = document.getElementById('analysis-pivot-x').value;
        const py = document.getElementById('analysis-pivot-y').value;
        const cross = {};
        b.forEach(x => {
            const key = px === 'month' ? x.checkin.substring(0,7) : x[px];
            if(!cross[key]) cross[key] = 0;
            cross[key] += py === 'count' ? 1 : parseFloat(x[py]);
        });
        document.getElementById('cross-analysis-body').innerHTML = Object.keys(cross).map(k => \`<tr><td><b>\${k}</b></td><td>\${cross[k].toFixed(2)}</td></tr>\`).join('');
    } `,
`    renderAnalysis() {
        const b = this.getFiltered('bookings', 'checkin', 'analysis');
        const e = this.getFiltered('expenses', 'date', 'analysis');

        // Platform & origin filter applies to both matrix & period logic
        let filteredB = b;
        const fPlatform = document.getElementById('f-analysis-platform') ? document.getElementById('f-analysis-platform').value : '';
        const fOrigin = document.getElementById('f-analysis-origin') ? document.getElementById('f-analysis-origin').value : '';
        if (fPlatform) filteredB = filteredB.filter(x => x.platform === fPlatform);
        if (fOrigin) filteredB = filteredB.filter(x => x.origin === fOrigin);

        const months = {};
        filteredB.forEach(x => {
            const m = x.checkin.substring(0,7);
            if(!months[m]) months[m] = { month: m, res_count: 0, nights: 0, bruto: 0, net: 0, comisiones: 0, expenses: 0 };
            months[m].res_count += 1;
            months[m].nights += parseFloat(x.nights);
            months[m].bruto += parseFloat(x.bruto);
            months[m].net += parseFloat(x.net);
            months[m].comisiones += (parseFloat(x.fee_banco||0) + parseFloat(x.fee_thl||0));
        });

        e.forEach(x => {
            const m = x.date.substring(0,7);
            if(!months[m]) months[m] = { month: m, res_count: 0, nights: 0, bruto: 0, net: 0, comisiones: 0, expenses: 0 };
            months[m].expenses += parseFloat(x.amount);
        });

        const data = this.sortData(Object.values(months), 'analysis');

        // Render Periodo
        document.getElementById('stats-table-body').innerHTML = data.map(x => \`
            <tr><td>\${x.month}</td><td>\${x.nights}</td><td>\${x.bruto.toFixed(2)}€</td><td class="text-success">\${x.net.toFixed(2)}€</td></tr>
        \`).join('');

        // Render Matrix
        const selObj = document.getElementById('matrix-var-select');
        let selectedVars = [];
        if(selObj && selObj.options) {
            for(let i=0; i<selObj.options.length; i++) {
                if(selObj.options[i].selected) selectedVars.push(selObj.options[i].value);
            }
        }

        const varLabels = {
            res_count: "Nº Reservas",
            nights: "Noches Ocupación",
            bruto: "Ingreso Bruto (€)",
            net: "Ingreso Neto (€)",
            expenses: "Gastos Totales (€)",
            comisiones: "Comisiones (€)"
        };

        const headHtml = '<tr><th>Variables</th>' + data.map(x => \`<th>\${x.month}</th>\`).join('') + '</tr>';
        document.getElementById('matrix-head').innerHTML = headHtml;

        let bodyHtml = '';
        selectedVars.forEach(v => {
            bodyHtml += \`<tr><td><b>\${varLabels[v]}</b></td>\`;
            data.forEach(x => {
                let val = x[v];
                let displayVal = (v === 'res_count' || v === 'nights') ? val : val.toFixed(2);
                bodyHtml += \`<td>\${displayVal}</td>\`;
            });
            bodyHtml += '</tr>';
        });
        document.getElementById('matrix-body').innerHTML = bodyHtml;

        // Explorador Cruzado
        const px = document.getElementById('analysis-pivot-x').value;
        const py = document.getElementById('analysis-pivot-y').value;
        const cross = {};
        b.forEach(x => {
            const key = px === 'month' ? x.checkin.substring(0,7) : x[px];
            if(!cross[key]) cross[key] = 0;
            cross[key] += py === 'count' ? 1 : parseFloat(x[py]);
        });
        document.getElementById('cross-analysis-body').innerHTML = Object.keys(cross).map(k => {
            const displayVal = py === 'count' ? cross[k] : cross[k].toFixed(2) + '€';
            return \`<tr><td><b>\${k}</b></td><td>\${displayVal}</td></tr>\`;
        }).join('');
    } `
);

content = content.replace(
`    renderBank() {
        const b = this.getFiltered('bookings', 'checkin', 'bank');
        document.getElementById('bank-list-body').innerHTML = b.map(x => {
            const rec = this.state.bankRecords.find(r => r.id === x.id) || { val: 0, obs: '' };
            const diff = rec.val - x.net;
            return \`<tr>
                <td>#\${x.booking_ref}</td><td>\${x.net.toFixed(2)}€</td>
                <td><input type="number" value="\${rec.val}" onchange="window.upBank(\${x.id}, 'val', this.value)" style="width:80px"></td>
                <td class="\${Math.abs(diff)<0.1?'text-success':'text-danger'}">\${diff.toFixed(2)}€</td>
                <td><input type="text" value="\${rec.obs}" onchange="window.upBank(\${x.id}, 'obs', this.value)"></td>
            </tr>\`;
        }).join('');
    } `,
`    renderBank() {
        let b = this.getFiltered('bookings', 'checkin', 'bank');

        const fYear = this.state.filters.bank.year;
        if(fYear) b = b.filter(x => x.checkin.startsWith(fYear));

        const fPlatform = this.state.filters.bank.platform;
        if(fPlatform) b = b.filter(x => x.platform === fPlatform);

        document.getElementById('bank-list-body').innerHTML = b.map(x => {
            const rec = this.state.bankRecords.find(r => r.id === x.id) || { val: 0, obs: '' };
            const diff = rec.val - x.net;

            let colorClass = 'text-warning'; // Default or something else if needed
            if (Math.abs(diff) < 0.01) colorClass = 'text-success'; // green for 0
            else if (diff < 0) colorClass = 'text-danger'; // red for negative
            else colorClass = 'text-accent'; // blue for positive (using accent color)

            return \`<tr>
                <td>#\${x.booking_ref}</td><td>\${x.net.toFixed(2)}€</td>
                <td><input type="number" value="\${rec.val}" onchange="window.upBank(\${x.id}, 'val', this.value)" style="width:80px"></td>
                <td class="\${colorClass}" style="font-weight: bold;">\${diff.toFixed(2)}€</td>
                <td><input type="text" value="\${rec.obs}" onchange="window.upBank(\${x.id}, 'obs', this.value)"></td>
            </tr>\`;
        }).join('');
    } `
);


content = content.replace(
`    renderMarket() {
        const c = document.getElementById('market-cards-container');
        const m = [{t:"Precio Medio", v:"142€"}, {t:"Ocupación", v:"78%"}, {t:"Demanda", v:"Alta"}, {t:"RevPAR", v:"110€"}];
        c.innerHTML = m.map(x => \`<div class="card"><h3>\${x.t}</h3><p>\${x.v}</p></div>\`).join('');
        document.getElementById('market-status-box').innerText = "Datos basados en CP " + this.state.config.cp;
    } `,
`    renderMarket() {
        const c = document.getElementById('market-cards-container');
        const m = [
            {t:"Precio Medio/Noche", v:"142€", icon:"euro-sign"},
            {t:"Ocupación Media", v:"78%", icon:"chart-pie"},
            {t:"Demanda", v:"Alta", icon:"fire"},
            {t:"RevPAR", v:"110€", icon:"chart-line"},
            {t:"Oferta Activa", v:"154 Pisos", icon:"building"},
            {t:"Rendimiento Anual", v:"6.5%", icon:"percent"}
        ];
        c.innerHTML = m.map(x => \`<div class="card"><h3><i class="fa fa-\${x.icon}"></i> \${x.t}</h3><p>\${x.v}</p></div>\`).join('');
        document.getElementById('market-status-box').innerText = "Datos simulados basados en Código Postal " + (this.state.config ? this.state.config.cp : '');

        // Leaflet Map Logic
        if (!this.mapInitialized) {
            // Wait for DOM to be ready before initializing
            setTimeout(() => {
                // Initialize map (simulated center in Madrid)
                const map = L.map('map').setView([40.4168, -3.7038], 14);

                L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                    attribution: '© OpenStreetMap contributors'
                }).addTo(map);

                // Add Property Marker (Blue)
                const blueIcon = new L.Icon({
                    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png',
                    shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                    iconSize: [25, 41], iconAnchor: [12, 41], popupAnchor: [1, -34], shadowSize: [41, 41]
                });
                L.marker([40.4168, -3.7038], {icon: blueIcon}).addTo(map).bindPopup("<b>Tu Propiedad</b><br>"+(this.state.config?this.state.config.calle:'')).openPopup();

                // Generate simulated competitors
                const colors = {
                    'Turístico': 'red',
                    'Temporal': 'orange',
                    'Permanente': 'green'
                };

                for(let i=0; i<15; i++) {
                    const lat = 40.4168 + (Math.random() - 0.5) * 0.02;
                    const lng = -3.7038 + (Math.random() - 0.5) * 0.02;
                    const types = ['Turístico', 'Temporal', 'Permanente'];
                    const type = types[Math.floor(Math.random() * types.length)];

                    const icon = new L.Icon({
                        iconUrl: \`https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-\${colors[type]}.png\`,
                        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                        iconSize: [25, 41], iconAnchor: [12, 41], popupAnchor: [1, -34], shadowSize: [41, 41]
                    });

                    L.marker([lat, lng], {icon: icon}).addTo(map).bindPopup(\`<b>Alquiler \${type}</b><br>Precio est.: \${Math.floor(Math.random() * 100 + 80)}€\`);
                }
                this.mapInitialized = true;
            }, 100);
        }
    } `
);

fs.writeFileSync(filePath, content);
IN_EOF

node /tmp/app_patch.js


# style.css patch
cat << 'IN_EOF' > /tmp/style_patch.js
const fs = require('fs');
const filePath = 'style.css';
let content = fs.readFileSync(filePath, 'utf8');

content = content.replace(
`.modal.hidden { display: none; } `,
`.modal.hidden { display: none !important; opacity: 0; pointer-events: none; visibility: hidden; } `
);

fs.writeFileSync(filePath, content);
IN_EOF

node /tmp/style_patch.js
