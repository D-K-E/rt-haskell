{-# LANGUAGE BangPatterns #-}
-- image scene
module Scene.ImageScene(imgEarth) where

-- default scene
import Scene.Scene

-- hittable
import Hittable.HittableList
import Hittable.HittableObj
import Hittable.Sphere

import Color.Pixel

--
import GHC.Float
import Prelude hiding(subtract)
import Data.Bitmap.Base
import Data.Bitmap.Simple

-- material
import Material.Material

-- math
import Math3D.Vector
import Math3D.CommonOps

-- texture
import Texture.TextureObj
import Texture.Image

-- utility
import Utility.HelperTypes


imgEarth :: Bitmap Word8 -> Scene

imgEarth !bmp =
    let
        bbmp = bmp
        -- bbmp = flipBitmap bmp
        -- bbmp = mirrorBitmap bmp
        ptex = TextureCons $! bitmapToImageT bbmp
        -- ptex = SolidTexture $ SolidV ( VList [0.2, 0.3, 0.1] )
        lmb = LambMat $! LambT ptex 
        sp2 = SphereObj {sphereCenter = fromList2Vec 0.0 [0.0, 0.0],
                         sphereRadius = 2,
                         sphereMat = lmb}
        hs = HList {objects = NList (HittableCons sp2) []}
    in SceneVals {
        img_width = imageWidth,
        aspect_ratio = aspectRatio,
        img_height = imageHeight,
        nb_samples = nbSamples,
        bounce_depth = bounceDepth,
        cam_look_from = fromList2Vec 0.0 [0.0, 12.0],
        cam_look_to = camLookTo,
        cam_vfov = camVFov,
        cam_vup = camVUp,
        cam_focus_distance = camFocDistance,
        cam_aperture = 0.0,
        scene_obj = hs,
        sample_obj = hs,
        back_ground = PixSpecTrichroma (0.7,0.8,1.0)
    }

