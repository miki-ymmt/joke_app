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
        'kaisei': ['Kaisei Tokumin', 'san-serif']
      },
      fontSize: {
        'xxs': '0.625rem',
      },
    },
 },
  plugins: [require("daisyui")],
  daisyui: {
    themes: ["light", "dark", "nord"],
  },
}
