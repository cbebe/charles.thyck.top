// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

async function createConfig() {
  return await (await import("./config/index.js")).default();
}

module.exports = createConfig;
