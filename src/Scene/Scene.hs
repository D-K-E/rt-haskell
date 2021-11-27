-- scene module
module Scene.Scene where

import Math3D.Vector
import Hittable.HittableList

import GHC.Float

data Scene = SceneVals {
    img_width :: Int,
    img_height :: Int,
    aspect_ratio :: Double,
    nb_samples :: Int,
    bounce_depth :: Int,
    cam_look_from :: Vector,
    cam_look_to :: Vector,
    cam_vup :: Vector,
    cam_vfov :: Double,
    cam_aperture :: Double,
    cam_focus_distance :: Double,
    scene_obj :: HittableList,
    back_ground :: Vector
    }

-- default values
imageWidth :: Int
imageWidth = 320

aspectRatio :: Double
aspectRatio = 16.0 / 9.0

imageHeight :: Int
imageHeight = double2Int $! (int2Double imageWidth) / aspectRatio

nbSamples :: Int
nbSamples = 50

bounceDepth :: Int
bounceDepth = 20

camLookFrom :: Vector
camLookFrom = VList [13.0, 2.0, 3.0]

camLookTo :: Vector
camLookTo = VList [0.0, 0.0, 0.0]

camVFov :: Double
camVFov = 20.0

camVUp :: Vector
camVUp = VList [0.0, 1.0, 0.0]

camFocDistance :: Double
camFocDistance = 10.0


