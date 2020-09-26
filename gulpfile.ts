import { series } from "gulp";
import { ProgramBuilder } from 'brighterscript';

import * as fs from 'fs-extra';
import * as path from 'path';

const gulp = require('gulp');
const gulpClean = require('gulp-clean');
const outDir = './build';
const cp = require('child_process');
const pkg = require('./package.json');
const zip = require('gulp-zip');

export function clean() {
  console.log('Doing a clean at ' + outDir);
  return gulp.src(['out',
    'dist',
  ], { allowEmpty: true }).pipe(gulpClean({ force: true }));
}

export function createDirectories() {
  return gulp.src('*.*', { read: false })
    .pipe(gulp.dest('./dist'));
}

export function doc(cb) {
  let task = cp.exec('./node_modules/.bin/jsdoc -c jsdoc.json -t node_modules/minami -d docs');
  return task;
}

export async function compile(cb) {
  // copy all sources to tmp folder
  // so we can add the line numbers to them prior to transpiling
  let builder = new ProgramBuilder();
  await builder.run({});
  fs.removeSync(path.join('dist', 'manifest'));
  fs.removeSync(path.join('dist', 'source', 'roku_modules'));
  fs.removeSync(path.join('dist', 'components', 'roku_modules'));
  // fs.removeSync(path.join('dist', 'source', 'bslib.brs'));
}

export async function compileTests(cb) {
  // copy all sources to tmp folder
  // so we can add the line numbers to them prior to transpiling
  let builder = new ProgramBuilder();
  await builder.run({});
  // fs.removeSync(path.join('dist', 'source', 'bslib.brs'));
}

export function test() {
  fs.removeSync(path.join('dist', 'manifest'));
  fs.removeSync(path.join('dist', 'source', 'roku_modules'));
  fs.removeSync(path.join('dist', 'components', 'roku_modules'));
}
exports.dist = series(exports.compile, doc);
