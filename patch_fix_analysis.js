const fs = require('fs');
const filePath = '/app/keep_in_rent/v1.9/index.html';
let content = fs.readFileSync(filePath, 'utf8');

const searchStr = `        <section id="view-analysis" class="app-view" style="display: flex;"> `;
const replaceStr = `        <section id="view-analysis" class="app-view analysis-container"> `;

content = content.replace(searchStr, replaceStr);
fs.writeFileSync(filePath, content);
