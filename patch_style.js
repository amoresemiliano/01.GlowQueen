const fs = require('fs');
const filePath = '/app/keep_in_rent/v1.9/style.css';
let content = fs.readFileSync(filePath, 'utf8');

const searchStr = `.modal.hidden { display: none !important; opacity: 0; pointer-events: none; visibility: hidden; } `;
const replaceStr = `.modal.hidden { display: none !important; } `;

content = content.replace(searchStr, replaceStr);
fs.writeFileSync(filePath, content);
