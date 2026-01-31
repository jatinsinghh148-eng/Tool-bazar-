<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tool Bazer - All-in-One Online Tools</title>
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-black: #0a0a0a;
            --secondary-black: #1a1a1a;
            --accent-yellow: #ffd700;
            --bright-yellow: #ffed4e;
            --dark-yellow: #cc9900;
            --text-white: #ffffff;
            --text-gray: #b0b0b0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: var(--primary-black);
            color: var(--text-white);
            overflow-x: hidden;
        }

        /* Animated Background */
        .animated-bg {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            background: linear-gradient(135deg, var(--primary-black) 0%, #1a1a00 100%);
        }

        .animated-bg::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: 
                radial-gradient(circle at 20% 50%, rgba(255, 215, 0, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(255, 237, 78, 0.05) 0%, transparent 50%);
            animation: bgMove 20s ease-in-out infinite;
        }

        @keyframes bgMove {
            0%, 100% { transform: translate(0, 0); }
            50% { transform: translate(-50px, -50px); }
        }

        /* Header */
        header {
            padding: 1.5rem 5%;
            background: rgba(26, 26, 26, 0.8);
            backdrop-filter: blur(10px);
            border-bottom: 2px solid var(--accent-yellow);
            position: sticky;
            top: 0;
            z-index: 100;
            animation: slideDown 0.6s ease-out;
        }

        @keyframes slideDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .logo {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2.5rem;
            background: linear-gradient(135deg, var(--accent-yellow) 0%, var(--bright-yellow) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: 3px;
            text-shadow: 0 0 30px rgba(255, 215, 0, 0.3);
            animation: glow 2s ease-in-out infinite;
        }

        @keyframes glow {
            0%, 100% { filter: drop-shadow(0 0 5px rgba(255, 215, 0, 0.5)); }
            50% { filter: drop-shadow(0 0 20px rgba(255, 215, 0, 0.8)); }
        }

        /* Hero Section */
        .hero {
            text-align: center;
            padding: 4rem 5% 3rem;
            animation: fadeIn 1s ease-out 0.3s backwards;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hero h1 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 3.5rem;
            margin-bottom: 1rem;
            letter-spacing: 2px;
        }

        .hero p {
            font-size: 1.2rem;
            color: var(--text-gray);
            max-width: 600px;
            margin: 0 auto;
        }

        /* Tools Grid */
        .tools-container {
            padding: 2rem 5%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .tools-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .tool-card {
            background: var(--secondary-black);
            border: 2px solid transparent;
            border-radius: 20px;
            padding: 2rem;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.8s ease-out backwards;
        }

        .tool-card:nth-child(1) { animation-delay: 0.1s; }
        .tool-card:nth-child(2) { animation-delay: 0.2s; }
        .tool-card:nth-child(3) { animation-delay: 0.3s; }
        .tool-card:nth-child(4) { animation-delay: 0.4s; }

        .tool-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--accent-yellow) 0%, var(--bright-yellow) 100%);
            opacity: 0;
            transition: opacity 0.4s;
            z-index: 0;
        }

        .tool-card:hover {
            border-color: var(--accent-yellow);
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(255, 215, 0, 0.3);
        }

        .tool-card:hover::before {
            opacity: 0.05;
        }

        .tool-card * {
            position: relative;
            z-index: 1;
        }

        .tool-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: inline-block;
            transition: transform 0.4s;
        }

        .tool-card:hover .tool-icon {
            transform: scale(1.2) rotate(5deg);
        }

        .tool-card h3 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 1.8rem;
            color: var(--accent-yellow);
            margin-bottom: 0.5rem;
            letter-spacing: 1px;
        }

        .tool-card p {
            color: var(--text-gray);
            font-size: 0.95rem;
            margin-bottom: 1rem;
        }

        /* Tool Interface */
        .tool-interface {
            display: none;
            background: var(--secondary-black);
            border: 2px solid var(--accent-yellow);
            border-radius: 20px;
            padding: 3rem;
            margin: 2rem auto;
            max-width: 800px;
            animation: scaleIn 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 10px 50px rgba(255, 215, 0, 0.2);
        }

        .tool-interface.active {
            display: block;
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .tool-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid rgba(255, 215, 0, 0.2);
        }

        .tool-header h2 {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 2.5rem;
            color: var(--accent-yellow);
            letter-spacing: 2px;
        }

        .close-btn {
            background: transparent;
            border: 2px solid var(--accent-yellow);
            color: var(--accent-yellow);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            font-size: 1.5rem;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .close-btn:hover {
            background: var(--accent-yellow);
            color: var(--primary-black);
            transform: rotate(90deg);
        }

        .input-group {
            margin-bottom: 1.5rem;
        }

        .input-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--accent-yellow);
            font-weight: 600;
            font-size: 0.95rem;
        }

        .input-group input,
        .input-group select {
            width: 100%;
            padding: 1rem;
            background: var(--primary-black);
            border: 2px solid rgba(255, 215, 0, 0.3);
            border-radius: 10px;
            color: var(--text-white);
            font-size: 1rem;
            font-family: 'Montserrat', sans-serif;
            transition: all 0.3s;
        }

        .input-group input:focus,
        .input-group select:focus {
            outline: none;
            border-color: var(--accent-yellow);
            box-shadow: 0 0 20px rgba(255, 215, 0, 0.2);
        }

        .file-upload {
            border: 2px dashed rgba(255, 215, 0, 0.3);
            border-radius: 10px;
            padding: 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background: var(--primary-black);
        }

        .file-upload:hover {
            border-color: var(--accent-yellow);
            background: rgba(255, 215, 0, 0.05);
        }

        .file-upload input[type="file"] {
            display: none;
        }

        .file-upload-text {
            color: var(--text-gray);
            font-size: 0.95rem;
        }

        .file-name {
            color: var(--accent-yellow);
            margin-top: 0.5rem;
            font-weight: 600;
        }

        .action-btn {
            width: 100%;
            padding: 1.2rem;
            background: linear-gradient(135deg, var(--accent-yellow) 0%, var(--bright-yellow) 100%);
            color: var(--primary-black);
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 700;
            font-family: 'Bebas Neue', sans-serif;
            letter-spacing: 2px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(255, 215, 0, 0.3);
            margin-top: 1rem;
        }

        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(255, 215, 0, 0.5);
        }

        .action-btn:active {
            transform: translateY(-1px);
        }

        .action-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Progress Bar */
        .progress-container {
            display: none;
            margin-top: 1.5rem;
        }

        .progress-container.active {
            display: block;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: var(--primary-black);
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--accent-yellow), var(--bright-yellow));
            width: 0%;
            transition: width 0.3s;
            animation: shimmer 1.5s infinite;
        }

        @keyframes shimmer {
            0% { background-position: -200px 0; }
            100% { background-position: 200px 0; }
        }

        .progress-text {
            text-align: center;
            color: var(--accent-yellow);
            font-size: 0.9rem;
            font-weight: 600;
        }

        /* Result Section */
        .result-container {
            display: none;
            margin-top: 2rem;
            padding: 2rem;
            background: var(--primary-black);
            border: 2px solid var(--accent-yellow);
            border-radius: 10px;
            animation: fadeIn 0.5s;
        }

        .result-container.active {
            display: block;
        }

        .result-container h3 {
            color: var(--accent-yellow);
            margin-bottom: 1rem;
            font-family: 'Bebas Neue', sans-serif;
            font-size: 1.8rem;
            letter-spacing: 1px;
        }

        .download-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            background: var(--accent-yellow);
            color: var(--primary-black);
            text-decoration: none;
            border-radius: 10px;
            font-weight: 700;
            transition: all 0.3s;
            margin-top: 1rem;
        }

        .download-btn:hover {
            background: var(--bright-yellow);
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 215, 0, 0.4);
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 3rem 5%;
            margin-top: 5rem;
            border-top: 2px solid rgba(255, 215, 0, 0.2);
            color: var(--text-gray);
        }

        footer p {
            font-size: 0.9rem;
        }

        .footer-logo {
            font-family: 'Bebas Neue', sans-serif;
            font-size: 1.8rem;
            color: var(--accent-yellow);
            margin-bottom: 1rem;
            letter-spacing: 2px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .logo {
                font-size: 2rem;
            }

            .tools-grid {
                grid-template-columns: 1fr;
            }

            .tool-interface {
                padding: 2rem 1.5rem;
            }

            .tool-header h2 {
                font-size: 2rem;
            }
        }

        /* Loading Spinner */
        .spinner {
            border: 3px solid rgba(255, 215, 0, 0.3);
            border-top: 3px solid var(--accent-yellow);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto;
            display: none;
        }

        .spinner.active {
            display: block;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Quality Options */
        .quality-options {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 1rem;
        }

        .quality-option {
            flex: 1;
            min-width: 120px;
            padding: 1rem;
            background: var(--primary-black);
            border: 2px solid rgba(255, 215, 0, 0.3);
            border-radius: 10px;
            cursor: pointer;
            text-align: center;
            transition: all 0.3s;
        }

        .quality-option:hover,
        .quality-option.selected {
            border-color: var(--accent-yellow);
            background: rgba(255, 215, 0, 0.1);
        }

        .quality-option input[type="radio"] {
            display: none;
        }

        .quality-label {
            font-weight: 600;
            color: var(--text-white);
        }

        .quality-size {
            font-size: 0.85rem;
            color: var(--text-gray);
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
    <div class="animated-bg"></div>

    <header>
        <div class="logo">⚡ TOOL BAZER</div>
    </header>

    <section class="hero">
        <h1>Your Ultimate Toolkit</h1>
        <p>Download, convert, and transform your content with lightning-fast tools. No registration required.</p>
    </section>

    <div class="tools-container">
        <div class="tools-grid">
            <div class="tool-card" onclick="openTool('youtube')">
                <div class="tool-icon">📺</div>
                <h3>YouTube Downloader</h3>
                <p>Download YouTube videos in multiple formats and quality options instantly</p>
            </div>

            <div class="tool-card" onclick="openTool('instagram')">
                <div class="tool-icon">📱</div>
                <h3>Instagram Reel Downloader</h3>
                <p>Save Instagram reels, videos, and stories directly to your device</p>
            </div>

            <div class="tool-card" onclick="openTool('pdf2word')">
                <div class="tool-icon">📄</div>
                <h3>PDF to Word</h3>
                <p>Convert PDF documents to editable Word files with preserved formatting</p>
            </div>

            <div class="tool-card" onclick="openTool('word2pdf')">
                <div class="tool-icon">📝</div>
                <h3>Word to PDF</h3>
                <p>Transform Word documents into professional PDF files seamlessly</p>
            </div>
        </div>

        <!-- YouTube Downloader Interface -->
        <div id="youtube-tool" class="tool-interface">
            <div class="tool-header">
                <h2>YouTube Downloader</h2>
                <button class="close-btn" onclick="closeTool('youtube')">×</button>
            </div>
            <div class="input-group">
                <label>YouTube Video URL</label>
                <input type="text" id="youtube-url" placeholder="https://www.youtube.com/watch?v=..." />
            </div>
            <div class="input-group">
                <label>Select Quality</label>
                <div class="quality-options">
                    <label class="quality-option selected">
                        <input type="radio" name="youtube-quality" value="1080p" checked />
                        <div class="quality-label">1080p HD</div>
                        <div class="quality-size">Best Quality</div>
                    </label>
                    <label class="quality-option">
                        <input type="radio" name="youtube-quality" value="720p" />
                        <div class="quality-label">720p</div>
                        <div class="quality-size">High Quality</div>
                    </label>
                    <label class="quality-option">
                        <input type="radio" name="youtube-quality" value="480p" />
                        <div class="quality-label">480p</div>
                        <div class="quality-size">Medium</div>
                    </label>
                    <label class="quality-option">
                        <input type="radio" name="youtube-quality" value="audio" />
                        <div class="quality-label">Audio Only</div>
                        <div class="quality-size">MP3</div>
                    </label>
                </div>
            </div>
            <button class="action-btn" onclick="downloadYoutube()">Download Video</button>
            <div class="progress-container" id="youtube-progress">
                <div class="progress-bar">
                    <div class="progress-fill" id="youtube-progress-fill"></div>
                </div>
                <div class="progress-text" id="youtube-progress-text">Processing...</div>
            </div>
            <div class="result-container" id="youtube-result">
                <h3>✅ Download Ready!</h3>
                <p id="youtube-video-info"></p>
                <a href="#" class="download-btn" id="youtube-download-link" download>
                    <span>⬇</span> Download Now
                </a>
            </div>
        </div>

        <!-- Instagram Reel Downloader Interface -->
        <div id="instagram-tool" class="tool-interface">
            <div class="tool-header">
                <h2>Instagram Reel Downloader</h2>
                <button class="close-btn" onclick="closeTool('instagram')">×</button>
            </div>
            <div class="input-group">
                <label>Instagram Reel URL</label>
                <input type="text" id="instagram-url" placeholder="https://www.instagram.com/reel/..." />
            </div>
            <button class="action-btn" onclick="downloadInstagram()">Download Reel</
