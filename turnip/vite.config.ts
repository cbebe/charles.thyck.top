import createReScriptPlugin from "@jihchi/vite-plugin-rescript";
import { BuildOptions, defineConfig, ServerOptions, UserConfig } from "vite";
import vitePluginWasmPack from "vite-plugin-wasm-pack";

function serveTurnipsDev(): { build: BuildOptions; server: ServerOptions } {
  /** @type {{  build: import('vite').BuildOptions }} */
  return {
    build: { rollupOptions: { input: { app: "./turnips.html" } } },
    server: { open: "/turnips.html" },
  };
}

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [createReScriptPlugin(), vitePluginWasmPack("./predictor")],
  ...(process.env.NODE_ENV === "production") ? {} : serveTurnipsDev(),
} as UserConfig);
