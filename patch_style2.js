const fs = require('fs');
const filePath = '/app/keep_in_rent/v1.9/index.html';
let content = fs.readFileSync(filePath, 'utf8');

const searchStr = `    <!-- Login Modal -->
    <div id="login-modal" class="modal hidden" style="display: none;">`;
const replaceStr = `    <!-- Login Modal -->
    <div id="login-modal" class="modal">`;

content = content.replace(searchStr, replaceStr);

const searchStr2 = `    <!-- Login Modal -->
    <div id="login-modal" class="modal hidden">`;
content = content.replace(searchStr2, replaceStr);

fs.writeFileSync(filePath, content);
