<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 11/2/2025
  Time: 9:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ecommerce Homepage</title>
        <script src="/_sdk/element_sdk.js"></script>
        <style>
            body {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
                background: #f8f9fa;
                color: #2d3748;
                height: 100%;
                overflow-x: hidden;
            }

            html {
                height: 100%;
            }

            * {
                box-sizing: border-box;
            }

            header {
                background: #ffffff;
                padding: 1.5rem 2rem;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                position: sticky;
                top: 0;
                z-index: 100;
            }

            .header-content {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                font-size: 1.75rem;
                font-weight: 700;
                color: #2d3748;
            }

            nav {
                display: flex;
                gap: 2rem;
            }

            nav a {
                color: #4a5568;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            nav a:hover {
                color: #2d3748;
            }

            .hero {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 6rem 2rem;
                text-align: center;
            }

            .hero-content {
                max-width: 800px;
                margin: 0 auto;
            }

            .hero h1 {
                font-size: 3rem;
                margin: 0 0 1rem 0;
                font-weight: 700;
                line-height: 1.2;
            }

            .hero p {
                font-size: 1.25rem;
                margin: 0 0 2rem 0;
                opacity: 0.95;
            }

            .cta-button {
                background: #ffffff;
                color: #667eea;
                padding: 1rem 2.5rem;
                border: none;
                border-radius: 50px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }

            .cta-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
            }

            .features {
                padding: 5rem 2rem;
                background: #ffffff;
            }

            .features-content {
                max-width: 1200px;
                margin: 0 auto;
            }

            .features h2 {
                text-align: center;
                font-size: 2.5rem;
                margin: 0 0 3rem 0;
                color: #2d3748;
            }

            .features-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 2rem;
            }

            .feature-card {
                background: #f8f9fa;
                padding: 2rem;
                border-radius: 12px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            }

            .feature-icon {
                font-size: 3rem;
                margin-bottom: 1rem;
            }

            .feature-card h3 {
                font-size: 1.5rem;
                margin: 0 0 1rem 0;
                color: #2d3748;
            }

            .feature-card p {
                color: #4a5568;
                line-height: 1.6;
                margin: 0;
            }

            footer {
                background: #2d3748;
                color: white;
                padding: 2rem;
                text-align: center;
            }

            .footer-content {
                max-width: 1200px;
                margin: 0 auto;
            }

            @media (max-width: 768px) {
                .hero h1 {
                    font-size: 2rem;
                }

                .hero p {
                    font-size: 1rem;
                }

                nav {
                    gap: 1rem;
                }

                .features h2 {
                    font-size: 2rem;
                }

                .features-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
        <style>@view-transition {
            navigation: auto;
        }</style>
        <script src="/_sdk/data_sdk.js" type="text/javascript"></script>
        <script src="https://cdn.tailwindcss.com" type="text/javascript"></script>
    </head>
    <body>
        <header>
            <div class="header-content">
                <div class="logo" id="site-name">
                    ShopHub
                </div>
                <nav><a href="#home">Home</a> 
                    <a href="#products">Products</a> 
                    <a href="#about">About</a> 
                    <a href="#contact">Contact</a>
                    <a href="#login">Log In</a>
                    <a href="<%=request.getContextPath()%>/admin">ADMIN</a>
                </nav>
            </div>
        </header>
        <main>
            <section class="hero">
                <div class="hero-content">
                    <h1 id="hero-title">Discover Amazing Products</h1>
                    <p id="hero-subtitle">Shop the latest trends with unbeatable prices and quality</p><button class="cta-button" id="cta-button">Shop Now</button>
                </div>
            </section>
            <section class="features">
                <div class="features-content">
                    <h2 id="features-title">Why Choose Us</h2>
                    <div class="features-grid">
                        <div class="feature-card">
                            <div class="feature-icon">
                                🚚
                            </div>
                            <h3 id="feature-1-title">Free Shipping</h3>
                            <p id="feature-1-desc">Enjoy free shipping on all orders over $50. Fast and reliable delivery to your doorstep.</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">
                                💎
                            </div>
                            <h3 id="feature-2-title">Premium Quality</h3>
                            <p id="feature-2-desc">We source only the finest products to ensure your complete satisfaction with every purchase.</p>
                        </div>
                        <div class="feature-card">
                            <div class="feature-icon">
                                🔒
                            </div>
                            <h3 id="feature-3-title">Secure Payment</h3>
                            <p id="feature-3-desc">Shop with confidence using our secure payment system. Your data is always protected.</p>
                        </div>
                    </div>
                </div>
            </section>
        </main>
        <footer>
            <div class="footer-content">
                <p id="footer-text">© 2024 ShopHub. All rights reserved.</p>
            </div>
        </footer>
        <script>
            const defaultConfig = {
                background_color: "#f8f9fa",
                surface_color: "#ffffff",
                text_color: "#2d3748",
                primary_action_color: "#667eea",
                secondary_action_color: "#4a5568",
                font_family: "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif",
                font_size: 16,
                site_name: "ShopHub",
                hero_title: "Discover Amazing Products",
                hero_subtitle: "Shop the latest trends with unbeatable prices and quality",
                cta_button: "Shop Now",
                features_title: "Why Choose Us",
                feature_1_title: "Free Shipping",
                feature_1_desc: "Enjoy free shipping on all orders over $50. Fast and reliable delivery to your doorstep.",
                feature_2_title: "Premium Quality",
                feature_2_desc: "We source only the finest products to ensure your complete satisfaction with every purchase.",
                feature_3_title: "Secure Payment",
                feature_3_desc: "Shop with confidence using our secure payment system. Your data is always protected.",
                footer_text: "© 2024 ShopHub. All rights reserved."
            };

            async function onConfigChange(config) {
                const customFont = config.font_family || defaultConfig.font_family;
                const baseFontStack = '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, sans-serif';
                const fontFamily = `${customFont}, ${baseFontStack}`;
                        const baseSize = config.font_size || defaultConfig.font_size;

                        document.body.style.fontFamily = fontFamily;
                        document.body.style.background = config.background_color || defaultConfig.background_color;
                        document.body.style.color = config.text_color || defaultConfig.text_color;

                        const header = document.querySelector('header');
                        header.style.background = config.surface_color || defaultConfig.surface_color;

                        const logo = document.querySelector('.logo');
                        logo.style.color = config.text_color || defaultConfig.text_color;
                        logo.style.fontSize = `${baseSize * 1.75}px`;

                        const navLinks = document.querySelectorAll('nav a');
                        navLinks.forEach(link => {
                            link.style.color = config.secondary_action_color || defaultConfig.secondary_action_color;
                            link.style.fontSize = `${baseSize}px`;
                        });

                        const heroTitle = document.getElementById('hero-title');
                        heroTitle.style.fontSize = `${baseSize * 3}px`;

                        const heroSubtitle = document.getElementById('hero-subtitle');
                        heroSubtitle.style.fontSize = `${baseSize * 1.25}px`;

                        const ctaButton = document.querySelector('.cta-button');
                        ctaButton.style.background = config.surface_color || defaultConfig.surface_color;
                        ctaButton.style.color = config.primary_action_color || defaultConfig.primary_action_color;
                        ctaButton.style.fontSize = `${baseSize * 1.1}px`;

                        const featuresSection = document.querySelector('.features');
                        featuresSection.style.background = config.surface_color || defaultConfig.surface_color;

                        const featuresTitle = document.getElementById('features-title');
                        featuresTitle.style.fontSize = `${baseSize * 2.5}px`;
                        featuresTitle.style.color = config.text_color || defaultConfig.text_color;

                        const featureCards = document.querySelectorAll('.feature-card');
                        featureCards.forEach(card => {
                            card.style.background = config.background_color || defaultConfig.background_color;
                        });

                        const featureCardTitles = document.querySelectorAll('.feature-card h3');
                        featureCardTitles.forEach(title => {
                            title.style.fontSize = `${baseSize * 1.5}px`;
                            title.style.color = config.text_color || defaultConfig.text_color;
                        });

                        const featureCardDescs = document.querySelectorAll('.feature-card p');
                        featureCardDescs.forEach(desc => {
                            desc.style.fontSize = `${baseSize}px`;
                            desc.style.color = config.secondary_action_color || defaultConfig.secondary_action_color;
                        });

                        const footer = document.querySelector('footer');
                        footer.style.background = config.text_color || defaultConfig.text_color;

                        const footerText = document.getElementById('footer-text');
                        footerText.style.fontSize = `${baseSize}px`;

                        document.getElementById('site-name').textContent = config.site_name || defaultConfig.site_name;
                        document.getElementById('hero-title').textContent = config.hero_title || defaultConfig.hero_title;
                        document.getElementById('hero-subtitle').textContent = config.hero_subtitle || defaultConfig.hero_subtitle;
                        document.getElementById('cta-button').textContent = config.cta_button || defaultConfig.cta_button;
                        document.getElementById('features-title').textContent = config.features_title || defaultConfig.features_title;
                        document.getElementById('feature-1-title').textContent = config.feature_1_title || defaultConfig.feature_1_title;
                        document.getElementById('feature-1-desc').textContent = config.feature_1_desc || defaultConfig.feature_1_desc;
                        document.getElementById('feature-2-title').textContent = config.feature_2_title || defaultConfig.feature_2_title;
                        document.getElementById('feature-2-desc').textContent = config.feature_2_desc || defaultConfig.feature_2_desc;
                        document.getElementById('feature-3-title').textContent = config.feature_3_title || defaultConfig.feature_3_title;
                        document.getElementById('feature-3-desc').textContent = config.feature_3_desc || defaultConfig.feature_3_desc;
                        document.getElementById('footer-text').textContent = config.footer_text || defaultConfig.footer_text;
                    }

                    function mapToCapabilities(config) {
                        return {
                            recolorables: [
                                {
                                    get: () => config.background_color || defaultConfig.background_color,
                                    set: (value) => {
                                        config.background_color = value;
                                        window.elementSdk.setConfig({background_color: value});
                                    }
                                },
                                {
                                    get: () => config.surface_color || defaultConfig.surface_color,
                                    set: (value) => {
                                        config.surface_color = value;
                                        window.elementSdk.setConfig({surface_color: value});
                                    }
                                },
                                {
                                    get: () => config.text_color || defaultConfig.text_color,
                                    set: (value) => {
                                        config.text_color = value;
                                        window.elementSdk.setConfig({text_color: value});
                                    }
                                },
                                {
                                    get: () => config.primary_action_color || defaultConfig.primary_action_color,
                                    set: (value) => {
                                        config.primary_action_color = value;
                                        window.elementSdk.setConfig({primary_action_color: value});
                                    }
                                },
                                {
                                    get: () => config.secondary_action_color || defaultConfig.secondary_action_color,
                                    set: (value) => {
                                        config.secondary_action_color = value;
                                        window.elementSdk.setConfig({secondary_action_color: value});
                                    }
                                }
                            ],
                            borderables: [],
                            fontEditable: {
                                get: () => config.font_family || defaultConfig.font_family,
                                set: (value) => {
                                    config.font_family = value;
                                    window.elementSdk.setConfig({font_family: value});
                                }
                            },
                            fontSizeable: {
                                get: () => config.font_size || defaultConfig.font_size,
                                set: (value) => {
                                    config.font_size = value;
                                    window.elementSdk.setConfig({font_size: value});
                                }
                            }
                        };
                    }

                    function mapToEditPanelValues(config) {
                        return new Map([
                            ["site_name", config.site_name || defaultConfig.site_name],
                            ["hero_title", config.hero_title || defaultConfig.hero_title],
                            ["hero_subtitle", config.hero_subtitle || defaultConfig.hero_subtitle],
                            ["cta_button", config.cta_button || defaultConfig.cta_button],
                            ["features_title", config.features_title || defaultConfig.features_title],
                            ["feature_1_title", config.feature_1_title || defaultConfig.feature_1_title],
                            ["feature_1_desc", config.feature_1_desc || defaultConfig.feature_1_desc],
                            ["feature_2_title", config.feature_2_title || defaultConfig.feature_2_title],
                            ["feature_2_desc", config.feature_2_desc || defaultConfig.feature_2_desc],
                            ["feature_3_title", config.feature_3_title || defaultConfig.feature_3_title],
                            ["feature_3_desc", config.feature_3_desc || defaultConfig.feature_3_desc],
                            ["footer_text", config.footer_text || defaultConfig.footer_text]
                        ]);
                    }

                    if (window.elementSdk) {
                        window.elementSdk.init({
                            defaultConfig,
                            onConfigChange,
                            mapToCapabilities,
                            mapToEditPanelValues
                        });
                    }
        </script>
        <script>(function () {
         function c() {
             var b = a.contentDocument || a.contentWindow.document;
             if (b) {
                 var d = b.createElement('script');
                 d.innerHTML = "window.__CF$cv$params={r:'99d4bc625464fda7',t:'MTc2MjkzNjk0NS4wMDAwMDA='};var a=document.createElement('script');a.nonce='';a.src='/cdn-cgi/challenge-platform/scripts/jsd/main.js';document.getElementsByTagName('head')[0].appendChild(a);";
                 b.getElementsByTagName('head')[0].appendChild(d)
             }
         }
         if (document.body) {
             var a = document.createElement('iframe');
             a.height = 1;
             a.width = 1;
             a.style.position = 'absolute';
             a.style.top = 0;
             a.style.left = 0;
             a.style.border = 'none';
             a.style.visibility = 'hidden';
             document.body.appendChild(a);
             if ('loading' !== document.readyState)
                 c();
             else if (window.addEventListener)
                 document.addEventListener('DOMContentLoaded', c);
             else {
                 var e = document.onreadystatechange || function () {};
                 document.onreadystatechange = function (b) {
                     e(b);
                     'loading' !== document.readyState && (document.onreadystatechange = e, c())
                 }
             }
         }
     })();</script></body>
</html>