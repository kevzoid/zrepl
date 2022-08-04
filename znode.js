#!/usr/bin/env node
'use strict';
const repl = require('repl');
const path = require('path');
const os = require('os');
const zon_root = path.join(os.homedir(), 'zon1');
const zon_file = file=>path.join(zon_root, file);
require(zon_file('./pkg/util/config.js'));

const utils = 'etask string date csv exec json stream util'.split(/\s+/);
console.log(`Loaded modules: ${['lodash'].concat(utils)}`);
const r = repl.start(`Welcome to Node ${process.version}\n$ `);
for (let util of utils)
{
    let variable = util;
    if (r.context.global[variable] || r.context[variable])
        variable = `z${variable}`;
    if (r.context.global[variable] || r.context[variable])
        throw `cannot redeclare variable name "${variable}"`;
    r.context[variable] = require(zon_file(`./pkg/util/${util}`));
}

// in REPL, `_` by default is an alias to the result of the most recently
// evaluated expression. when invoking the setter of this variable, we get a
// warning in the terminal. we define the propery to supress this warning
Object.defineProperty(r.context, '_', {
    configurable: false,
    enumerable: true,
    value: require('lodash'),
});

