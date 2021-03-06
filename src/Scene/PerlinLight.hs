-- perlin sphere with light module
module Scene.PerlinLight(simpleLight) where

-- default values
import Scene.Scene

import Color.Pixel

-- math3d
import Math3D.Vector
import Math3D.CommonOps

-- texture
import Texture.TextureObj
import Texture.Noise
import Texture.SolidColor

-- hittable
import Hittable.Sphere
import Hittable.HittableObj
import Hittable.HittableList
import Hittable.AaRect

-- material
import Material.Material

import Utility.HelperTypes
--
import System.Random
import Random

simpleLight :: RandomGen g => g -> Scene
simpleLight g =
    let ptex = TextureCons $! mkPerlinNoise g 4.0
        lmb = LambMat $! LambT ptex
        sp1 = SphereObj {sphereCenter = fromList2Vec 0.0 [-1000.0, 0.0],
                         sphereRadius = 1000,
                         sphereMat = lmb}
        sp2 = SphereObj {sphereCenter = fromList2Vec 0.0 [2.0, 0.0],
                         sphereRadius = 2,
                         sphereMat = lmb}
        st1 = TextureCons $! SolidD 4.5 4.5 4.5
        lmat = LightMat $! DLightEmitTextureCons st1
        dlight = HittableCons $! mkXyRect 3.0 5.0 1.0 3.0 (-2.0) lmat
        sp3 = SphereObj {sphereCenter = fromList2Vec 0.0 [8.0, 0.0],
                         sphereRadius = 2,
                         sphereMat = lmat}
        hs = HList {
            objects = NList (HittableCons sp1) [HittableCons sp2, dlight, HittableCons sp3]
        }
    in SceneVals {
        img_width = imageWidth,
        aspect_ratio = aspectRatio,
        img_height = imageHeight,
        nb_samples = 200,
        bounce_depth = 100,
        cam_look_from = fromList2Vec 26.0 [3.0, 6.0],
        cam_look_to = fromList2Vec 0.0 [2.0, 0.0],
        cam_vfov = camVFov,
        cam_vup = camVUp,
        cam_focus_distance = camFocDistance,
        cam_aperture = 0.0,
        scene_obj = hs,
        sample_obj = HList {objects = NList dlight []},
        back_ground = PixSpecTrichroma (0.0, 0.0, 0.0)
    }

