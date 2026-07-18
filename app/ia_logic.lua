-- Módulo de Inteligência Artificial para Scripto
local IA = {}

-- Banco de dados simples de conhecimento (Padrões)
local knowledge = {
    ["oi"] = "Olá! Eu sou a IA do Scripto. Como posso te ajudar hoje?",
    ["quem é você"] = "Eu sou um assistente inteligente criado para automatizar tarefas no seu repositório.",
    ["ajuda"] = "Eu posso responder perguntas básicas ou executar comandos de automação.",
    ["status"] = "Todos os sistemas estão operacionais.",
    ["github"] = "Seu repositório GitHub está conectado e atualizado."
}

-- Função de Chat (Opção 1)
function IA.responder(mensagem)
    mensagem = mensagem:lower()
    for padrao, resposta in pairs(knowledge) do
        if mensagem:find(padrao) then
            return resposta
        end
    end
    return "Desculpe, ainda estou aprendendo. Pode tentar perguntar de outra forma?"
end

-- Função de Automação (Opção 3)
function IA.executar_tarefa(tarefa)
    print("[IA] Analisando tarefa: " .. tarefa)
    
    if tarefa:find("limpar") then
        return "Executando limpeza de logs e arquivos temporários..."
    elseif tarefa:find("backup") then
        return "Iniciando processo de backup do repositório..."
    elseif tarefa:find("otimizar") then
        return "Otimizando scripts Lua para melhor performance..."
    else
        return "Tarefa não reconhecida. Por favor, defina uma automação válida."
    end
end

return IA
