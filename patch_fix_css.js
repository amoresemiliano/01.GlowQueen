const fs = require('fs');
const filePath = '/app/keep_in_rent/v1.9/style.css';
let content = fs.readFileSync(filePath, 'utf8');

content += `\n
/* --- ANALYSIS VIEW --- */
.analysis-container {
    display: none;
}
.analysis-container.active {
    display: flex;
}
`;

fs.writeFileSync(filePath, content);
