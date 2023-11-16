import { rimraf } from 'rimraf';
import fs from 'fs-extra';


async function main() {
  await rimraf('../static/assets');
  await fs.move('./dist/index.html', '../assets/turnip.html', { overwrite: true });
  await fs.move('./dist/assets', '../static/assets', { overwrite: true });
}

main()
