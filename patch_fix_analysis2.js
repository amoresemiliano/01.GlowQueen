const fs = require('fs');
const filePath = '/app/keep_in_rent/v1.9/app.js';
let content = fs.readFileSync(filePath, 'utf8');

const searchStr = `        document.getElementById('btn-show-matrix').onclick = (e) => {
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
        };`;

const replaceStr = `        const analysisNav = (targetId, btnId) => {
            ['matrix', 'period', 'cross'].forEach(v => {
                const el = document.getElementById('analysis-v-' + v);
                if(el) { el.classList.add('hidden'); el.style.display = 'none'; }

                const btn = document.getElementById('btn-show-' + v);
                if(btn) {
                    btn.classList.remove('btn-primary');
                    btn.classList.add('btn-secondary');
                    btn.style.background = '';
                }
            });

            const targetEl = document.getElementById('analysis-v-' + targetId);
            if(targetEl) { targetEl.classList.remove('hidden'); targetEl.style.display = 'block'; }

            const targetBtn = document.getElementById(btnId);
            if(targetBtn) {
                targetBtn.classList.add('btn-primary');
                targetBtn.classList.remove('btn-secondary');
                targetBtn.style.background = 'var(--accent)';
            }
        };

        document.getElementById('btn-show-matrix').onclick = (e) => analysisNav('matrix', 'btn-show-matrix');
        document.getElementById('btn-show-period').onclick = (e) => analysisNav('period', 'btn-show-period');
        document.getElementById('btn-show-cross').onclick = (e) => analysisNav('cross', 'btn-show-cross');

        // Initialize first view explicitly
        analysisNav('matrix', 'btn-show-matrix');
        `;

content = content.replace(searchStr, replaceStr);
fs.writeFileSync(filePath, content);
