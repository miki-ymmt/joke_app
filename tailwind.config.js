const { default: daisyui } = require("daisyui");

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        'noto': ['Noto Sans JP', 'sans-serif'],
        'kaisei': ['Kaisei Tokumin', 'sans-serif']
      },
      fontSize: {
        'xxs': '0.625rem',
      },
      animation: {
        "tilt-in-top-1": "tilt-in-top-1 1.5s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both"
      },
      keyframes: {
        "tilt-in-top-1": {
            "0%": {
                transform: "rotateY(30deg) translateY(-300px) skewY(-30deg)",
                opacity: "0"
            },
            "100%": {
                transform: "rotateY(0deg) translateY(0) skewY(0deg)",
                opacity: "1"
            }
        }
      }
    },
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["light", "dark", "nord"],
  },
}
