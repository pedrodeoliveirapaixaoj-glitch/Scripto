# Como transformar este App em um .APK 📱

Este guia explica como transformar seu código PWA (HTML/CSS/JS) em um aplicativo Android instalável.

## Opção 1: Web-to-APK (Mais Fácil)
1. Ative o **GitHub Pages** nas configurações do seu repositório.
2. Copie o link do seu app (ex: `https://seu-usuario.github.io/Scripto/app/`).
3. Acesse o site [WebToAPK.com](https://webtoapk.com/) ou [PWA2APK](https://pwa2apk.com/).
4. Cole o link e clique em **Generate APK**.
5. Baixe o arquivo e instale no seu celular.

## Opção 2: Kodular / App Inventor (Personalizado)
1. Vá para o [Kodular](https://www.kodular.io/).
2. Crie um projeto chamado "Scripto AI".
3. Adicione o componente **Web Viewer**.
4. Em "Home URL", cole o link do seu GitHub Pages.
5. Vá em **Export** -> **Android App (.apk)**.

## Opção 3: Capacitor (Profissional)
Se você tem o Node.js no seu computador:
1. No terminal, dentro da pasta `app`, rode:
   ```bash
   npm init -y
   npm install @capacitor/core @capacitor/cli
   npx cap init ScriptoAI com.scripto.ai --web-dir .
   npx cap add android
   npx cap open android
   ```
2. O Android Studio abrirá, e você poderá gerar o APK em **Build > Build Bundle(s) / APK(s) > Build APK(s)**.

---
**Dica:** Certifique-se de que o GitHub Pages está ativo para que o app funcione online!
