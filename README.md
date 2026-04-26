# 📄 AI PDF Analyzer

A powerful, modern web application that allows you to chat with your PDF documents using artificial intelligence. Powered by **Google Gemini**, this tool provides deep insights, summaries, and contextual answers from any PDF file.

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Python](https://img.shields.io/badge/python-3.10%2B-blue.svg)
![Framework](https://img.shields.io/badge/framework-Flask-lightgrey.svg)
![AI](https://img.shields.io/badge/AI-Google%20Gemini-orange.svg)

---

## ✨ Features

- **💬 Interactive Chat**: Ask questions about your PDF and get instant, context-aware answers.
- **📑 PDF Visualization**: Integrated PDF viewer using `PDF.js` to see your document side-by-side with the chat.
- **🚀 One-Click Analysis**:
  - **Summarize**: Get a concise summary of the entire document.
  - **Outline**: Generate a structured outline of the content.
  - **Key Points**: Extract the most important takeaways.
- **📍 Page-Specific Context**: Ask questions about the page you are currently viewing.
- **💡 Recommended Questions**: Smart suggestions for follow-up questions based on AI responses.
- **🎨 Premium UI**: Sleek dark mode interface with glassmorphism effects and smooth transitions.

---

## 🛠️ Tech Stack

- **Backend**: Python, Flask
- **AI Engine**: Google Gemini (via `google-genai`)
- **Frontend**: HTML5, Vanilla CSS3, JavaScript (ES6+)
- **PDF Engine**: PDF.js (Client-side rendering)
- **Deployment**: PyInstaller (Portable Executable)

---

## 🚀 Getting Started

### Prerequisites

- Python 3.10 or higher
- Google Gemini API Key

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/ai-pdf-analyzer.git
   cd ai-pdf-analyzer
   ```

2. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

3. **Set up Environment Variables**:
   Create a `.env` file in the root directory and add your Gemini API key:
   ```env
   GEMINI_API_KEY=your_api_key_here
   ```

4. **Run the application**:
   ```bash
   python main.py
   ```
   The app will be available at `http://127.0.0.1:5000`.

### Windows packaged app API key workflow

If you are using the packaged Windows app from the `dist/` folder, do not commit a real API key to GitHub.

Use the helper scripts instead:

1. Run `run-with-api-key.bat` or `start.bat`.
2. When prompted, paste your Gemini API key.
3. If the key is valid, the app starts with API access.
4. If you press Enter or enter an invalid key, the app starts without an API key and AI requests will show a missing API key message.

Before uploading this project publicly, run:

```bat
remove-api-key-for-github.bat
```

This removes local `.env` API key values and scans the project for Google API-key-looking strings.

To create, replace, show, or delete the full local `.env` files, run:

```bat
env-manager.bat
```

The manager writes the full `.env` content to the root project folder and the packaged app locations under `dist/` when they exist.

To stop the packaged app and anything using port `5000`, run:

```bat
stop.bat
```

---

## 📦 Building the Executable

To create a standalone portable version for Windows:

```bash
pip install pyinstaller
pyinstaller --onefile --add-data "templates;templates" --name PDFChatApp main.py
```

The executable will be generated in the `dist/` folder.

---

## 📖 Usage

1. **Upload**: Click the "Upload PDF" button to select your document.
2. **Chat**: Type your question in the input box and press Enter.
3. **Analyze**: Use the quick action buttons (Summarize, Outline, Key Points) for rapid insights.
4. **Navigate**: Use the arrows on the PDF viewer to flip through pages; the AI can answer questions specific to the page you're on!

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*Developed with ❤️ by Antigravity*
