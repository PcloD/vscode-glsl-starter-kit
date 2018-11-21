# This project provides basic usages of glsl-canvas, a VS Code extension, to live preview WebGL of GLSL shaders.

## Install

1. Install [VS Code](https://code.visualstudio.com/)
2. Install extension `Shader languages support for VS Code` for syntax highlighting.
3. Install extension `glsl-canvas` for for live preview.

## Setup

This project provides a workspace file for VS Code. Simply click `File > Open Workspace...` and choose `glsl-starter-kit.code-workspace` will do.

This file contains the path to the images, which are used as textures in your shader. Correct the path before and restart VS Code to update environment varaibles.

In "glsl-canvas.textures", the key "0" will map to `uniform sampler2D u_texture_0;`, the key "1" will map to `uniform sampler2D u_texture_1;` etc.

## Note

Since setting uniforms in workspace file requires reload VS Code, it's would be more convenient to transform all your uniforms to global variables in shader.

The WebGL version seems to be 2.0, some handy method in GL3 might not be available.
