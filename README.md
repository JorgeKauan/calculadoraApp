# Calculadora Flutter

Uma calculadora completa desenvolvida em Flutter com múltiplas funcionalidades: calculadora comum, científica e conversor de medidas.

## 🚀 Funcionalidades

### 📱 Calculadora Comum
![Calculadora Comum](assets/calculator_common.png)

- Operações básicas: adição, subtração, multiplicação, divisão
- Histórico de cálculos com opção de limpar
- Interface limpa e intuitiva
- Botão de backspace para corrigir erros

### 🔬 Calculadora Científica
![Calculadora Científica](assets/calculator_scientific.png)

- **Funções trigonométricas**: sin, cos, tan
- **Logaritmos**: log (base 10), ln (base e)
- **Potenciação**: x², x^y
- **Raiz quadrada**: √
- **Fatorial**: n!
- **Constantes**: π, e
- **Operações avançadas**: ± (mudança de sinal), % (porcentagem)

### 📏 Calculadora de Medidas
![Calculadora de Medidas](assets/calculator_measures.png)

- **Comprimento**: mm, cm, m, km, in, ft, yd, mi
- **Peso**: mg, g, kg, t, oz, lb
- **Volume**: ml, l, gal, qt, pt, cup
- **Temperatura**: Celsius, Fahrenheit, Kelvin
- Conversão em tempo real
- Interface intuitiva com dropdowns

## 📸 Capturas de Tela

### 🎨 Interface

- **Tema escuro** moderno e elegante
- **Navegação fluida** entre as três calculadoras
- **Botões responsivos** com feedback visual
- **Layout adaptativo** para diferentes tamanhos de tela

## 📱 Como Usar

### Navegação
1. **Calculadora Comum**: Tela inicial do app
2. **Botão SCI/SW**: Acesse o menu de seleção de calculadoras
3. **Menu**: Escolha entre Comum, Científica ou Medidas

### Calculadora Comum
- Digite números e operações normalmente
- Toque em `=` para ver o resultado
- Acesse o histórico pelo ícone na barra superior
- Use `C` para limpar e `⌫` para apagar

### Calculadora Científica
- Use as funções trigonométricas (sin, cos, tan)
- Calcule potências com `^` ou `x²`
- Use `√` para raiz quadrada
- Calcule fatorial com `n!`
- Insira constantes π e e

### Calculadora de Medidas
1. Selecione a categoria (Comprimento, Peso, Volume, Temperatura)
2. Digite o valor no campo superior
3. Escolha a unidade de origem no dropdown
4. Veja o resultado convertido automaticamente
5. Escolha a unidade de destino no dropdown inferior

## 🛠️ Tecnologias

- **Flutter**: Framework de desenvolvimento
- **Dart**: Linguagem de programação
- **Material Design**: Design system

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── models/
│   └── calculator_model.dart    # Modelos das calculadoras
├── screens/
│   ├── calculator_screen.dart           # Tela da calculadora comum
│   ├── scientific_calculator_screen.dart # Tela da calculadora científica
│   └── measure_calculator_screen.dart   # Tela do conversor de medidas
├── widgets/
│   ├── calculator_button.dart   # Widget do botão da calculadora
│   └── display.dart            # Widget do display
└── utils/
    └── constants.dart          # Constantes e configurações
```

## 🚀 Como Executar

1. **Clone o repositório**
   ```bash
   git clone https://github.com/seu-usuario/calculadoraApp.git
   cd calculadoraApp
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Execute o app**
   ```bash
   flutter run
   ```

## 📋 Pré-requisitos

- Flutter SDK (versão 3.0 ou superior)
- Dart SDK
- Android Studio / VS Code
- Emulador Android ou dispositivo físico

## 🎯 Funcionalidades Futuras

- [ ] Tema claro/escuro
- [ ] Mais categorias de conversão (área, velocidade, etc.)
- [ ] Histórico de conversões
- [ ] Favoritos de conversões
- [ ] Modo paisagem otimizado
- [ ] Suporte a mais funções científicas

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

Desenvolvido com ❤️ usando Flutter

---

**Calculadora Flutter** - Uma calculadora completa para todas as suas necessidades matemáticas! 🧮✨
