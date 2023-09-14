# HDRP-Vegetation-Instancer

![Presentation](./presentation.png?raw=true "Presentation")

## Overview

HDRP vegetation instancer is a unity project whose goal is to bring vegetation details into unity terrains. All objects are proceduraly placed on the terrain without requiring any data saving. This makes the project very lightweight. Assets (like ferns) come from the Unity HDRP Terrain tools. Although the provided shaders work with HDRP, this project can work with URP as long as you provide your own shaders. To generate your shaders, see "How to get GPU indirect instancing capable shaders ?".   

It consists in 2 main scripts :   

- VegetationManager.cs : this script sets up the terrain data required for full GPU positioning. There can only be one instance of it, and is used by all the VegetationInstancers.   

- VegetationInstancer.cs : in charge of displaying large amounts of vegetation (up to millions) using any shader implementing GPU indirect instancing rendering. Everything from positioning, texture mapping, slope etc, is done on the GPU, leading to almost 0 CPU charge.   

Note that this project only spawns vegetation objects without colliders, and is reserved for small objects to populate your world.   

## How to use

Put the VegetationManager.cs and any kind of the provided instancers on an empty GameObject and fill in the parameters.   
The VegetationManager is in charge of generating the data needed by the instancers. It was made to support multiple terrains chunks, which allows this project to work on truly large projects, and can also be used in addition with MegaWorld (a unity asset store asset) for example. Only one VegetationManager must exist.   

### Manager parameters

![Manager](./manager.png?raw=true "Manager")

- Terrains : the terrain chunks on which you want to instantiate. They must have the same parameters (texture resolution, heightmap resolution, etc...) and be disposed in a square.   
- Reload Terrain Data : when checking this box, the manager regenerates the data necessary to instantiate on the terrains.   
- Cam : the player camera. This camera is used to perform instantiation and frustrum culling.   

### Instancer parameters

![Instancer](./instancer.png?raw=true "Instancer")

- Run In Editor : runs the instancer in editor.   
- Display Chunks : displays the chunks of vegetation used to instanciate objects. Red is for LOD0, yellow for LOD1. Only 2 levels of LODs are supported for now.   
- Display Terrains : displays the terrains mesh structure. Usefull to verify that the generated data fits correctly to your terrains.   
- Max Displacement : the maximum offset distance from the spawn point of your object. If this is 0, all objects will be instantiated in a perfect grid without any random offsets.   
- Y Position Offset : specify an additionnal height value to your objects. For example Unity's quad object is centered at the middle, so for it to be at the terrain level you have to set the offset to 0.5.   
- Size Bias : multiply the size of your objects by the specified value. If it is 2 all objects will have twice their original size.   
- Random Size : applies random size changes from 1/size to size.   
- Max Slope : specifies the maximum slope until which objects are allowed to spawn.   
- Falloff : allows objects on mapped on a texture to overextend on another texture.   
- Max Height : the maximum allowed height to spawn the objects.   
- Min Height : the minimum allowed height to spawn the ojbects.   
- Plant : the object to spawn.   
- LOD Plant : the LOD of the object.   
- Textures Indexes : the texture on which the object is allowed to live. -1 spawns the object everywhere. Only one texture is supported for now.   
- Centered Mesh : specify whether the object mesh is centered at its base or at its center.   
- Chunk Size : the chunks size. The bigger the faster they are to compute, but they should not be too big else they can start to be visible.   
- View Distance : the maximum distance to instanciate objects.   
- LOD View Distance : the distance after which we spawn LOD objects.   
- Plant Distance Int : the number of objects along the dimension of a chunk. 50 means there are 50*50 = 2500 objects in each chunk.   

This project is provided with an example scene, feel free to play around with it to understand fully how to use this asset.   

## Code explanation

VegetationInstancer generates the chunks positions every frame using burst (takes about 0.2ms). It then exclusively uses the GPU for grass positioning.   
In addition to this, GPU objects culling is performed to exclusively render what needs to be rendered.   
TerrainHeight.cs and TerrainsTextures.cs are used to sample the terrain efficiently using Native unmanaged containers which are then passed to a compute shader to sample the positions of vegetation on the GPU.   

All the code is commented and was made to be easily readable.   

## How to get GPU indirect instancing capable shaders ?

All shaders used in the sample scene were generated using MegaWorld. This Unity asset allows to procedurally generate and render large landscapes using GPU instancing and data streaming, along with texture mapping your terrains. It currently does not support small objects instancing such as grass, which is the reason of this project.   
Any shader can be converted by MegaWorld to a GPU indirect instancing capable shader, which means you can even give it your customs ShaderGraph shaders and provided the generated shader to the Vegetation Instancer.   

## Import Vegetation Instancer to your project

- Download the repository.   
- Copy the VegetationInstancer folder in your project.   
- If you don't have MegaWorld installed, you also have to copy the VladislavTsurikov folder at the root of your project.   

## In the futur

Fix multiple textures mapping.   
Support large objects with colliders ?   
