# HDRP-Vegetation-Instancer

![Presentation](./presentation.png?raw=true "Presentation")

## Overview

HDRP vegetation instancer is a unity project whose goal is to bring vegetation details into unity terrains. All objects are proceduraly placed on the terrain without requiring any data saving. This makes the project very lightweight. Assets (like ferns) come from the Unity HDRP Terrain tools.   

It consists in 2 main scripts :   

- VegetationManager.cs : this script sets up the terrain data required for full GPU positioning. Their can only be one instance of it, and is used by all the VegetationInstancers.   

- VegetationInstancer.cs : in charge of displaying large amounts of vegetation (up to millions) using any shader implementing GPU indirect instancing rendering. Everything from positioning, texture mapping, slope etc, is done on the GPU, leading to almost 0 CPU charge.   

Note that this project only spawns vegetation objects without colliders, and is reserved for small objects to populate your world.   

## How to use

Put the VegetationManager.cs and any kind of the provided instancers on an empty GameObject and fill in the parameters.   
The VegetationManager is in charge of generating the data needed by the instancers. It was made to support multiple terrains chunks, which allows this project to work on truly large projects, and can also be used in addition with MegaWorld for example. Only one VegetationManager can exist so if you want severals instancers you need to put them on the same GameObject.   

## Code explanation

VegetationInstancer generates the chunks positions every frame using burst (takes about 2ms). It then exclusively uses the GPU for grass positioning.   
TerrainHeight.cs and TerrainsTextures.cs are used to sample the terrain efficiently using Native unmanaged containers which are then passed to a compute shader to sample the positions of vegetation on the GPU.   

All the code is commented and was made to be easily readable.   

## How to get GPU indirect instancing capable shaders ?

All shaders used in the sample scene were generated using MegaWorld. This Unity asset allows to procedurally generate and render large landscapes using GPU instancing and data streaming, along with texture mapping your terrains. It currently does not support small objects instancing such as grass, which is the reason of this project.   
Any shader can be converted by MegaWorld to a GPU indirect instancing capable shader, which means you can even give it your customs ShaderGraph shaders and provided the generated shader to the Vegetation Instancer.   

## In the futur

Fix flickering issues.   
