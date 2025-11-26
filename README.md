# ✍ processing-typewriter: Máquina de Escrever 2D

Este repositório contém o código-fonte para o desenvolvimento de uma **Máquina de Escrever 2D** interativa, totalmente implementada usando a linguagem e ambiente **Processing**. O projeto consiste em uma representação planar e animada de uma máquina de escrever, focada em simular o ciclo de uso, desde o ligamento até a digitação de caracteres.

## ✨ Funcionalidades Principais

O projeto simula a interação do usuário com o teclado do computador para controlar a máquina de escrever virtual, incluindo:

* **Ligar/Desligar:** Um botão OFF/ON que mudará de cor quando o usuário acionar a tecla 'O' minúscula ou maiúscula ("o" ou "O") do computador.
* **Modos de Digitação:** Alternância entre os modos "Dígito" e "Texto" acionados pelas teclas 'D' ou 'd' (Dig) e 'T' ou 't' (Text) do computador.
* **Animação:** Olhos e boca com mudança de aspecto para refletir alegria ou manter-se fechados/abertos em diferentes estados da máquina.
* **Teclados Ocultáveis:** Exibição do teclado de dígitos somente quando a tecla "Dig" for acionada, e do teclado de letras maiúsculas somente quando a tecla "Text" for acionada.
* **Feedback Sonoro:**
    * Trilha sonora curta em idioma estrangeiro ao pressionar um dígito.
    * Bip sonoro curto ao selecionar qualquer um dos 3 modos (OFF/ON, Dig ou Text).
    * Trilha sonora curta ao completar uma linha de dez elementos.
* **Quebra de Linha Automática:** Mudança de linha (Linha de Dez elementos cheia).

## ⚙️ Tecnologias Utilizadas

* **Processing (Linguagem e Ambiente):** Base do desenvolvimento, usando suas funções nativas para desenho e animação 2D (`rect()`, `ellipse()`, `arc()`).

* **Biblioteca Processing Sound:** Importada e utilizada para o carregamento e reprodução de todos os efeitos sonoros e trilhas sonoras.

* **Tratamento de eventos de Teclado e Mouse:** Implementação das funções `keyPressed()` e `mousePressed()` para gerenciar todas as interações do usuário, conforme as especificações do projeto.

* **Gerenciamento de Estados:** Uso extensivo de Variáveis Booleanas (ex: `maquinaLigada`, `modoDigitoAtivo`, `expressaoAlegre`) para controlar o fluxo do programa e a renderização dos diferentes estados da máquina.
* **Lógica de Animação:** Uso de variáveis globais que controlam incremental ou decrementalmente a altura dos elementos visuais dos olhos a cada ciclo do draw(). O fluxo da animação é gerenciado por flags booleanas que definem a direção e o estado final do olho (Fechado quando desligada, Aberto Padrão quando ligada, ou Alegre ao digitar ) por meio de limites máximos e mínimos definidos no código.

## ⚠️ Restrições de Desenvolvimento

Toda a máquina de escrever, seus componentes e elementos visuais **devem ser criados do zero** usando os recursos nativos do Processing.
* **Nenhuma imagem deve ser importada**. Apenas em casos excepcionais e mediante avaliação do detalhamento do projeto.

## 🗓️ Prazos de Entrega

* **Versão Intermediária (Somente Imagem):** Sábado, 14/11/2025.
    * Requer o código-fonte zipado com a imagem estática da máquina, **sem** interações de mouse/teclado e **sem** trilha sonora.
* **Versão Completa (Final):** Quinta-feira, 12/12/2025.
    * Requer o código completo e funcional, além de um vídeo de demonstração mostrando todas as opções funcionando.

---

**Autores:** Luiza Pauli e Italo Ferreira
