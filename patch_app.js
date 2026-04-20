const fs = require('fs');
const filePath = '/app/keep_in_rent/v1.9/app.js';
let content = fs.readFileSync(filePath, 'utf8');

const searchStr = `        if(!this.state.currentUser) {
            loginModal.classList.remove('hidden');
            loginModal.style.display = 'flex';
            setupModal.classList.add('hidden');
            setupModal.style.display = 'none';
            return;
        } else {
            loginModal.classList.add('hidden');
            loginModal.style.display = 'none';
        }`;

const replaceStr = `        if(!this.state.currentUser) {
            loginModal.classList.remove('hidden');
            loginModal.style.display = '';
            setupModal.classList.add('hidden');
            setupModal.style.display = 'none';
            return;
        } else {
            loginModal.classList.add('hidden');
            loginModal.style.display = 'none';
        }`;

content = content.replace(searchStr, replaceStr);
fs.writeFileSync(filePath, content);
