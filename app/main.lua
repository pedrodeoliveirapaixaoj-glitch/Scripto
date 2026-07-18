-- Scripto App: AI Engine
local IA = require("ia_logic")

print("------------------------------------------")
print("   SCRIPTO AI - SISTEMA INICIALIZADO     ")
print("------------------------------------------")

-- Exemplo de uso do Chat (Opção 1)
print("\n[Usuário]: Oi")
print("[IA]: " .. IA.responder("Oi"))

print("\n[Usuário]: Quem é você?")
print("[IA]: " .. IA.responder("Quem é você?"))

-- Exemplo de Automação (Opção 3)
print("\n[Sistema]: Solicitando otimização...")
local resultado = IA.executar_tarefa("otimizar scripts")
print("[IA]: " .. resultado)

print("\n------------------------------------------")
print("Aguardando novos comandos...")
