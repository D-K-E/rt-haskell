-- cornell box
module Scene.CornellBox(cornellBox) where

-- scene default values
import Scene.Scene

-- 
import System.Random
import Random

-- math
import Math3D.Vector
import Math3D.Ray
import Math3D.Transform

-- texture
import Texture.SolidColor
import Texture.TextureObj

-- hittable
import Hittable.HittableList
import Hittable.HittableObj
import Hittable.Hittable
import Hittable.AaRect

-- instance
import Instance.Box

--
import Camera
import Material.Material

--
import Utility.HelperTypes

cornellBox :: RandomGen g => g -> Scene
cornellBox gen =
    let cfrom = VList [278.0, 278.0, -800.0]
        cto = VList [278.0, 278.0, 0.0]
        cvfov = 40.0 
        -- set up camera
        sceneC = mkCamTime cfrom cto camVUp cvfov aspectRatio 0.0 camFocDistance

        whiteMat = LambMat $! Lamb {
            lalbedo = SolidTexture $! SolidV ( VList [0.75, 0.75, 0.75])
        }
        redMat = LambMat $! Lamb {
            lalbedo = SolidTexture $! SolidV ( VList [0.65, 0.05, 0.05])
        }
        greenMat = LambMat $! Lamb {
            lalbedo = SolidTexture $! SolidV ( VList [0.12, 0.45, 0.15])
        }
        lightMat = LightMat $! DLight {
            emitTexture = SolidTexture $! SolidV (VList [15.0, 15.0, 15.0])
        }
        -- cornell walls
        c1 = 0.0
        c2 = 555.0
        -- yz walls
        yzGreenWall = AaQuad $ mkYzRect c1 c2 c1 c2 c2 greenMat
        yzRedWall = AaQuad $ mkYzRect c1 c2 c1 c2 c1 redMat
        -- xz walls
        xzWhiteWall1 = AaQuad $ mkXzRect c1 c2 c1 c2 c2 whiteMat
        xzWhiteWall2 = AaQuad $ mkXzRect c1 c2 c1 c2 c1 whiteMat
        -- xy wall
        xyWhiteWall = AaQuad $ mkXyRect c1 c2 c1 c2 c2 whiteMat
        -- light
        lightR = AaQuad $ mkXzRect 213.0 343.0 227.0 332.0 554.0 lightMat

        -- boxes
        -- get locating parameters
        loc = getCameraLocatingParams gen sceneC
        (_, _, time) = loc
        b1 = mkBox (zeroV3) (VList [165.0, 330.0, 165.0]) whiteMat
        b1rot = rotateYByAngle b1 45.0 time
        b1trans = translate b1rot (VList [265.0, 0.0, 295.0]) time
        b2 = mkBox (zeroV3) (VList [165.0, 165.0, 165.0]) whiteMat
        b2rot = rotateYByAngle b2 (-18.0) time
        b2trans = translate b2rot (VList [130.0, 0.0, 65.0]) time

        hs = HList {objects = NList (HitBox b1trans) [HitBox b2trans,
                                                      yzGreenWall, yzRedWall,
                                                      xzWhiteWall1, xzWhiteWall2,
                                                      xyWhiteWall, lightR]}
    -- in error $ "\nN: " ++ show b2 ++ "\nR: " ++ show b2rot ++ "\nT: " ++ show b2trans
    in SceneVals {
        img_width = imageWidth,
        aspect_ratio = aspectRatio,
        img_height = imageHeight,
        nb_samples = 100,
        bounce_depth = 20,
        cam_look_from = cfrom,
        cam_look_to = cto,
        cam_vfov = cvfov,
        cam_vup = camVUp,
        cam_focus_distance = camFocDistance,
        cam_aperture = 0.0,
        scene_obj = hs,
        back_ground = VList [0.0, 0.0, 0.0]
    }