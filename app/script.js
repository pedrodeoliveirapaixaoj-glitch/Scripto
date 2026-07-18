const chatContainer = document.getElementById('chat-container');
const userInput = document.getElementById('user-input');
const sendBtn = document.getElementById('send-btn');

const knowledge = {
    "oi": "Olá! Eu sou a IA do Scripto. Como posso te ajudar hoje?",
    "quem é você": "Eu sou um assistente inteligente criado para automatizar tarefas no seu repositório.",
    "ajuda": "Eu posso responder perguntas básicas ou executar comandos de automação.",
    "status": "Todos os sistemas estão operacionais.",
    "github": "Seu repositório GitHub está conectado e atualizado."
};

function addMessage(text, type) {
    const msgDiv = document.createElement('div');
    msgDiv.className = `message ${type}`;
    msgDiv.innerText = text;
    chatContainer.appendChild(msgDiv);
    chatContainer.scrollTop = chatContainer.scrollHeight;
}

function getResponse(msg) {
    msg = msg.toLowerCase();
    for (let key in knowledge) {
        if (msg.includes(key)) return knowledge[key];
    }
    return "Desculpe, ainda estou aprendendo. Pode tentar perguntar de outra forma?";
}

function runTask(task) {
    addMessage(`Comando: ${task}`, 'user');
    let response = "";
    if (task === 'limpar') response = "Executando limpeza de logs e arquivos temporários...";
    else if (task === 'backup') response = "Iniciando processo de backup do repositório...";
    else if (task === 'otimizar') response = "Otimizando scripts Lua para melhor performance...";
    
    setTimeout(() => addMessage(`[IA]: ${response}`, 'ai'), 500);
}

sendBtn.addEventListener('click', () => {
    const text = userInput.value.trim();
    if (text) {
        addMessage(text, 'user');
        userInput.value = '';
        setTimeout(() => {
            addMessage(getResponse(text), 'ai');
        }, 500);
    }
});

userInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') sendBtn.click();
});
