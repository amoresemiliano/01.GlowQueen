const fs = require('fs');
const filePath = '/app/keep_in_rent/v1.9/style.css';
let content = fs.readFileSync(filePath, 'utf8');

const searchStr = `.app-view.active { display: block; animation: fadeIn 0.3s ease-out; } `;
const replaceStr = `.app-view.active { display: block; animation: fadeIn 0.3s ease-out; }
.analysis-container.active { display: flex !important; }`;

content = content.replace(searchStr, replaceStr);
fs.writeFileSync(filePath, content);
