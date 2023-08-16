# HDRP-Vegetation-Instancer

![Presentation](./presentation.png?raw=true "Presentation")

## Overview

HDRP vegetation instancer is a unity project whose goal is to bring vegetation details into unity terrains. All objects are proceduraly placed on the terrain without requiring any data saving. This makes the project very lightweight. Assets (like ferns) come from the Unity HDRP Terrain tools.

It consists in 2 main scripts :   

- GrassInstancer.cs : in charge of displaying large amounts of grass (up to millions) using a custom shader and GPU indirect rendering. Everything from positioning, texture mapping, slope etc, is done on the GPU, leading to almost 0 CPU charge.   
The shader comes from this repository (with lots of changes) : https://github.com/MangoButtermilch/Unity-Grass-Instancer.   
Also thanks to Acerola for the code explanation here : https://github.com/GarrettGunnell/Grass.

![GrassInstancer](./grassInstancer.png?raw=true "GrassInstancer")

- BillboardGrassInstancer.cs : in charge of displaying large amounts of billboard grass. Also fully works on GPU like GrassInstancer. Below is the fps with a view range of 1000 to demonstrate.

![BillboardGrassInstancer](./billboardGrass.png?raw=true "BillboardGrassInstancer")

- VegetationInstancer.cs : in charge of displaying lower amounts of larger vegetation objects (ferns, bushes, etc...). This one works with any shader as long as GPU instancing is enabled, but is less optimized and can therefore work with fewer instances (about 10000).

![VegetationInstancer](./vegetationInstancer.png?raw=true "VegetationInstancer")

Note that this project only spawns vegetation objects without colliders at the moment.

## How to use

Put the TerrainGetter.cs and any kind of the provided instancers on an empty GameObject and fill in the parameters.   
The TerrainGetter is in charge of generating the data needed by the instancers. It was made to support multiple terrains chunks, which allows this project to work on truly large projects, and can also be used in addition with MegaWorld for example. Only one TerrainGetter can exist so if you want severals instancers you need to put them on the same GameObject.   
See below for the usage of VegetationInstancer.cs, GrassInstancer.cs and BillboardGrassInstancer are similar in the parameters.

![Usage](./usage.png?raw=true "Usage")

## Code explanation

GrassInstancer, BillboardGrassInstancer and VegetationInstancer all use the same code to generate the chunks positions at runtime using burst. However GrassInstancer and BillboardGrassInstancer exclusively use the GPU for grass positioning, whereas VegetationInstancer uses burst.   
The positions are not constantly regenerated, but only if a new chunk enters the camera frustrum. Finding new chunks is done in PickVisibleChunkJob.cs. Due to this, no CPU computation is required when the camera does not move. When a new chunk enters the camera view, all positions inside it are generated in a dedicated burst job for VegetationInstancer (PositionsJob.cs).   
TerrainHeight.cs and TerrainsTextures.cs are used to sample the terrain efficiently using Native unmanaged containers.

All the code is commented and was made to be easily readable.

## Work in progress
 
Lit billboard grass.
