---
title: "I Deleted My NPM Packages"
author: Charles Ancheta
date: 2023-05-10T00:59:18-06:00
description: These should've just been Github gists
tags:
  - js
  - npm
  - trash-packages
---

I deleted all 4 of my NPM packages today. It has been over a year since I've
last updated them, and I didn't want to add any more clutter to the system.

I've always thought that having published open source code meant something, but
then I realized that it doesn't matter if it's not useful.

Learning how to package libraries and applications was a good experience,
though, and I would probably publish stuff IF/WHEN I have actually solved a
need. Here are the reasons why I deleted each of them.

## TimeInterval nominal type: `libtime`

This should just be a single file that can be easily copied and extended. I also
created a [GitHub Gist](https://gist.github.com/cbebe/504e5098d3674da574ff85e8126cdb22)
so it can also be downloaded.

```typescript
/* TimeInterval nominal type and converters */
declare const TypeSymbol: unique symbol;
export type TimeInterval = number & { [TypeSymbol]: 'TimeInterval' };

/* Functions for converting to TimeInterval */
export const milliseconds = (howMany: number) => howMany as TimeInterval;
export const seconds = (howMany: number) => (howMany * 1000) as TimeInterval;
export const minutes = (howMany: number) => (howMany * 1000 * 60) as TimeInterval;
export const hours = (howMany: number) => (howMany * 1000 * 3600) as TimeInterval;
export const days = (howMany: number) => (howMany * 1000 * 3600 * 24) as TimeInterval;
export const weeks = (howMany: number) => (howMany * 1000 * 3600 * 24 * 7) as TimeInterval;

/* Functions for converting to numbers */
export const toSeconds = (timeInterval: TimeInterval) => timeInterval / 1000;
export const toMilliseconds = (timeInterval: TimeInterval) => timeInterval as number;
```

This can be used like so:

```typescript
async function delay(duration: TimeInterval): Promise<void> {
  return new Promise<void>((resolve) => {
    setTimeout(resolve, toMilliseconds(duration))
  })
}

async function main() {
  // do something here...

  await delay(minutes(3))

  // do another thing here...
}
```

## NestJS File Logger Module: `nestjs-file-logger`

This is also better suited to be just a copy-pasta, since I wouldn't have been
able to offer a decent amount of customizability, nor did I want to. I just
wanted to publish a package for the sake of it.

```typescript
import "reflect-metadata";
import { Module, ConsoleLogger, Inject, Injectable } from "@nestjs/common";
import { Logger as WinstonLogger, format, transports } from "winston";
import { WinstonModule } from "nest-winston";

type Level = "debug" | "log" | "warn" | "error";
@Injectable()
export class FileLogger extends ConsoleLogger {
  @Inject("winston") logger: WinstonLogger;
  private doLog(level: Level, message: any, ...optionalParams: any[]) {
    super[level](message, ...optionalParams);
    this.logger[level === "log" ? "info" : level](
      JSON.stringify([message instanceof Error ? message.stack : message, ...optionalParams])
    );
  }
  public debug(message: any, ...optionalParams: any[]): void { this.doLog("debug", message, ...optionalParams); }
  public log(message: any, ...optionalParams: any[]): void { this.doLog("log", message, ...optionalParams); }
  public warn(message: any, ...optionalParams: any[]): void { this.doLog("warn", message, ...optionalParams); }
  public error(message: any, ...optionalParams: any[]): void { this.doLog("error", message, ...optionalParams); }
}

const { combine, timestamp, printf } = format;
const logFormat = printf(({ level, message, timestamp }) => `[${timestamp}] ${level}: ${message}`);

const CustomWinstonModule = WinstonModule.forRoot({
  format: combine(timestamp({ format: () => new Date().toISOString() }), logFormat),
  transports: [
    new transports.File({ filename: "logs/error.log", level: "warn" }),
    new transports.File({ filename: "logs/combined.log", level: "info" }),
    new transports.File({ filename: "logs/debug.log", level: "debug" }),
  ],
});

@Module({ imports: [CustomWinstonModule], providers: [FileLogger], exports: [FileLogger] })
export class LoggerModule { }
```

Stolen from the README:

```typescript
/* Import `LoggerModule` into your `AppModule` */
import { Module } from "@nestjs/common";
import LoggerModule from "nest-file-logger";

@Module({
  imports: [LoggerModule],
})
export class AppModule {}

/***************************************/

/* Use `FileLogger` on application setup: */
import { NestFactory } from "@nestjs/core";
import { FileLogger } from "nest-file-logger";
import { AppModule } from "./app.module";

const app = await NestFactory.create(AppModule);
app.useLogger(app.get(FileLogger));
```

[Link to Gist](https://gist.github.com/cbebe/d309f16d4a052f539b13da797c327a94)

## Create Blog File CLI: `create-md-blog`

This was a CLI application that prompts you for a title and tags (even before
you write the actual blog post) and creates a Markdown file containing this
metadata. That's it. And I published it.

This did not need to exist at all. It's basically just a hammer looking for a
nail. Or me, an NPM-obsessed dev, looking for something to publish. It probably
took 100x more time to create this than the amount of time I've saved using
this CLI application. These days I just use `hugo new post/<title>.md`.

## NestJS Dependency Graph: `nestjs-dependency-graph`

This one would've actually been useful if it wasn't so hard to set up.
Fortunately,
[`nestjs-spelunker`](https://www.npmjs.com/package/nestjs-spelunker) is a
similar tool that is actually maintained and comes with a more portable JSON
format.
