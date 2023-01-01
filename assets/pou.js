// @ts-check
const audio = {
  lowFifth: new Audio("/mp3/pou-low-5th-shortened.mp3"),
  lowSixth: new Audio("/mp3/pou-low-6th-shortened.mp3"),
  root: new Audio("/mp3/pou-root-shortened.mp3"),
  second: new Audio("/mp3/pou-2nd-shortened.mp3"),
  third: new Audio("/mp3/pou-3rd-shortened.mp3"),
  highFifth: new Audio("/mp3/pou-5th-shortened.mp3"),
  highSixth: new Audio("/mp3/pou-6th-shortened.mp3"),
};

/** @type {Record<string, HTMLAudioElement>} */
const keys = {
  "z": audio.lowFifth,
  "x": audio.lowSixth,
  "a": audio.root,
  "s": audio.second,
  "d": audio.third,
  "q": audio.highFifth,
  "w": audio.highSixth,
};

const paths = {
  outline:
    "m -242.63672,31.222656 c -1.90776,0 -3.8419,0.203714 -5.43164,0.623047 -10.67178,2.814945 -20.82279,13.047273 -31.05859,30.917969 -4.40363,7.688284 -7.10234,13.982699 -8.23047,19.291016 -0.61082,2.874119 -0.69144,8.888255 -0.11328,11.25 0.70067,2.862276 2.37328,5.887056 4.49609,8.160152 5.61473,6.01219 14.78371,9.21584 29.33984,10.50586 1.44209,0.1278 7.11224,0.52643 12.59375,0.47852 8.34302,-0.0728 10.73687,-0.52188 14.13477,-0.98633 12.17117,-1.66363 19.56076,-4.59416 24.60742,-9.99805 2.12281,-2.273093 3.79542,-5.297876 4.4961,-8.160152 0.57815,-2.361747 0.49754,-8.375882 -0.11329,-11.25 -1.12943,-5.314452 -3.70656,-11.33777 -8.10351,-19.042969 -10.31408,-18.074362 -20.4516,-28.334671 -31.18555,-31.166016 -1.58974,-0.419332 -3.52387,-0.623047 -5.43164,-0.623047 z",
  body:
    "m -242.63696,32.123297 c -1.85143,0 -3.70281,0.19762 -5.20072,0.59273 -10.33441,2.725954 -20.31852,12.705884 -30.50718,30.494264 -4.38043,7.64779 -7.03049,13.84982 -8.1318,19.03192 -0.58493,2.75232 -0.64947,8.67825 -0.11834,10.84791 0.66213,2.70482 2.25287,5.58989 4.27829,7.758699 5.3966,5.77862 14.30082,8.94407 28.76259,10.22573 1.42073,0.1259 7.04763,0.52106 12.50466,0.47336 8.29776,-0.0724 10.59343,-0.50947 14.02292,-0.97824 12.06699,-1.64939 19.23549,-4.54428 24.06986,-9.72085 2.02542,-2.168809 3.61615,-5.053879 4.27828,-7.758699 0.53113,-2.16966 0.46608,-8.09559 -0.11885,-10.84791 -1.10399,-5.19471 -3.62756,-11.1186 -8.00261,-18.78542 -10.2676,-17.99291 -20.23856,-27.99822 -30.63586,-30.740764 -1.49791,-0.39511 -3.3498,-0.59273 -5.20124,-0.59273 z",
  "eye-outline":
    "m -947.13867,161.54883 c -17.83196,-7e-5 -31.99181,15.58348 -31.99219,34.53711 -7e-4,18.9545 14.15948,34.53913 31.99219,34.53906 14.0794,5e-5 25.74692,-9.77348 30.08594,-23.19141 4.33902,13.41796 16.00655,23.19146 30.08593,23.19141 17.83274,7e-5 31.99289,-15.58461 31.99219,-34.53906 -3.8e-4,-18.95368 -14.16025,-34.53718 -31.99219,-34.53711 -14.07878,-5e-5 -25.74649,9.77227 -30.08593,23.18945 -4.33945,-13.4172 -16.00717,-23.1895 -30.08594,-23.18945 z",
  sclera:
    "m -947.13867,164.57227 a 28.968658,31.514358 0 0 0 -28.96875,31.51367 28.968658,31.514358 0 0 0 28.96875,31.51562 28.968658,31.514358 0 0 0 28.96875,-31.51562 28.968658,31.514358 0 0 0 -28.96875,-31.51367 z m 60.17187,0 a 28.968658,31.514358 0 0 0 -28.96875,31.51367 28.968658,31.514358 0 0 0 28.96875,31.51562 28.968658,31.514358 0 0 0 28.96875,-31.51562 28.968658,31.514358 0 0 0 -28.96875,-31.51367 z",
  mouth:
    "m -263.62773,63.084741 c 0,0 -4.35224,14.1398 7.57709,9.86893 l 0.31739,1.18452 c 0,0 -13.63449,5.12106 -8.87669,-11.52117 v 0 z",
};

const svgns = "http://www.w3.org/2000/svg";

/**
 * @param {string} pathName
 * @param {Record<string, string>} obj
 * @param {string | undefined} className
 */
function makePath(pathName, obj = paths, className = undefined) {
  const path = document.createElementNS(svgns, "path");
  path.setAttribute("class", className || pathName);
  path.setAttribute("d", obj[pathName]);
  return path;
}

/**
 * @param {number} cx
 */
function makePupil(cx) {
  const circle = document.createElementNS(svgns, "circle");
  circle.setAttribute("class", "pupil");
  circle.setAttribute("cx", cx.toString());
  circle.setAttribute("cy", "51.881294");
  circle.setAttribute("r", "2.4246597");
  return circle;
}

const openMouth = {
  "upper-lip":
    "m 28.824959,36.085745 c 0,0 14.005899,-14.088017 31.490978,0.06023",
  "upper-mouth":
    "m 28.824959,36.085745 c 0,0 14.005899,-14.088017 31.490978,0.06023",
  "lower-mouth":
    "m 28.824959,36.085745 c 0,0 14.506532,31.22966 31.490978,0.06023",
  "lower-lip":
    "m 28.824959,36.085745 c 0,0 14.506532,31.22966 31.490978,0.06023",
};

function makeOpenMouthSvg() {
  const g = document.createElementNS(svgns, "g");
  g.setAttribute("transform", "translate(0, 5)");
  g.appendChild(makePath("lower-mouth", openMouth, "open-mouth"));
  g.appendChild(makePath("upper-mouth", openMouth, "open-mouth"));
  g.appendChild(makePath("upper-lip", openMouth, "open-lip"));
  g.appendChild(makePath("lower-lip", openMouth, "open-lip"));
  return g;
}

let clones = 0;

/**
 * @param {string} key
 */
function activatePou(key, event) {
  const a = keys[key];
  if (a === undefined) return;
  console.log(event);
  const currentPou = pouRecord[key];
  for (let i = 0; i < currentPou.idx; i++) {
    pouArray[i].lookRight();
  }
  currentPou.lookStraight();
  currentPou.openMouth();
  for (let i = currentPou.idx + 1; i < 7; i++) {
    pouArray[i].lookLeft();
  }
  if (a.paused) {
    a.play();
  } else {
    console.log(`Cloned audio: ${++clones}`);
    // @ts-expect-error
    a.cloneNode().play();
  }
}

class Pou {
  /**
   * @param {string} id
   * @param {number} idx
   */
  constructor(id, idx) {
    this.idx = idx;
    const color = makeHslColour(idx);
    const svg = document.createElementNS(svgns, "svg");
    svg.setAttribute("class", "pou");
    svg.setAttribute("id", id);
    svg.setAttribute("viewBox", "0 0 90.452331 81.230538");
    svg.setAttribute("version", "1.1");
    svg.setAttribute("xmlns", svgns);
    svg.setAttribute("xmlns:svg", svgns);
    const g = document.createElementNS(svgns, "g");
    g.setAttribute("transform", "translate(287.86288,-31.222656)");
    const body = makePath("body");
    body.style.fill = color;
    this.closedMouth = makePath("mouth");
    this.left = makePupil(-250.59694);
    this.right = makePupil(-234.67667);
    g.appendChild(makePath("outline"));
    g.appendChild(body);
    g.appendChild(makePath("eye-outline"));
    g.appendChild(makePath("sclera"));
    g.appendChild(this.left);
    g.appendChild(this.right);
    g.appendChild(this.closedMouth);
    this.openMouthSvg = makeOpenMouthSvg();
    this.openMouthSvg.classList.add("hidden");
    svg.appendChild(g);
    svg.appendChild(this.openMouthSvg);
    this.svg = svg;
    svg.addEventListener("click", (e) => activatePou(id, e));
  }

  /**
   * @param {number} offset
   */
  lookOffset(offset) {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
    this.left.style.transform = `translateX(${offset}px)`;
    this.right.style.transform = `translateX(${offset}px)`;
    this.timeout = setTimeout(() => {
      this.lookStraight();
    }, 500);
  }

  openMouth() {
    if (this.mouthTimeout) {
      clearTimeout(this.mouthTimeout);
    }
    this.closedMouth.classList.add("hidden");
    this.openMouthSvg.classList.remove("hidden");
    this.mouthTimeout = setTimeout(() => {
      this.closedMouth.classList.remove("hidden");
      this.openMouthSvg.classList.add("hidden");
      clearTimeout(this.mouthTimeout);
    }, 500);
  }

  lookStraight() {
    this.left.style.transform = `translateX(${0}px)`;
    this.right.style.transform = `translateX(${0}px)`;
    clearTimeout(this.timeout);
  }

  lookLeft() {
    this.lookOffset(-5);
  }
  lookRight() {
    this.lookOffset(5);
  }
}

const piano = document.querySelector(".piano");

/**
 * @param {number} i
 */
function makeHslColour(i) {
  return `hsl(${10 + i * (360 / 7)}, 100%, 50%)`;
}

const pouRecord = Object.fromEntries(["z", "x", "a", "s", "d", "q", "w"].map((
  id,
  idx,
) => [id, new Pou(id, idx)]));

const pouArray = Object.values(pouRecord);

pouArray.forEach((pou) => {
  piano?.appendChild(pou.svg);
});

document.addEventListener("keypress", (e) => {
  if (e.key === " ") {
    toggleConfetti();
  }
  activatePou(e.key, e);
});

const colours = [
  "blue",
  "cyan",
  "green",
  "indigo",
  "orange",
  "pink",
  "purple",
  "red",
  "steelblue",
  "white",
  "yellow",
];

const shapes = [
  "dodecagram",
  "hexagram",
  "pentagram",
  "rectangle",
  "square",
  "wavy-line",
];

/**
 * @param {number} min inclusive
 * @param {number} max exclusive
 */
function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min) + min);
}

/**
 * @param {string[]} arr
 */
function choose(arr) {
  return arr[getRandomInt(0, arr.length)];
}

function toggleConfetti() {
  const confetti = document.querySelector(".confetti");
  document.querySelector(".confetti-container")?.classList.toggle("hidden");
  if (confetti?.children.length === 0) {
    const n = getRandomInt(100, 150);
    for (let i = 0; i < n; i++) {
      const i = document.createElement("i");
      i.setAttribute("class", choose(shapes));
      i.setAttribute(
        "style",
        `--speed: ${getRandomInt(5, 50)}; --pou-bg: ${choose(colours)}`,
      );
      confetti?.appendChild(i);
    }
  } else if (confetti) {
    confetti.innerHTML = "";
  }
}

document.querySelector("#toggle-confetti")?.addEventListener("click", () => {
  toggleConfetti();
});
