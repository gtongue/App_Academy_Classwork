const GameView = require("./gameView.js");

addEventListener("DOMContentLoaded", () => {
  let canvas = document.getElementById("canvas");
  let ctx = canvas.getContext("2d");
  let view = new GameView(ctx);
  view.start();
});
